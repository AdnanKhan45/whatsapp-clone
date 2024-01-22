

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:whatsapp_clone_app/features/app/const/firebase_collection_const.dart';
import 'package:whatsapp_clone_app/features/call/data/models/call_model.dart';
import 'package:whatsapp_clone_app/features/call/data/remote/call_remote_data_source.dart';
import 'package:whatsapp_clone_app/features/call/domain/entities/call_entity.dart';

class CallRemoteDataSourceImpl implements CallRemoteDataSource {
  final FirebaseFirestore fireStore;

  CallRemoteDataSourceImpl({required this.fireStore});

  @override
  Future<void> endCall(CallEntity call) async {
    final callCollection = fireStore.collection(FirebaseCollectionConst.call);

    try {
      await callCollection.doc(call.callerId).delete();
      await callCollection.doc(call.receiverId).delete();

    } catch (e) {
      print("something went wrong");
    }
  }

  @override
  Future<String> getCallChannelId(String uid) async {

    final callCollection = fireStore.collection(FirebaseCollectionConst.call);

    return callCollection
        .doc(uid)
        .get()
        .then((callConnection) {
      if (callConnection.exists) {
        return callConnection.data()!['callId'];
      }
      return Future.value("");
    });
  }

  @override
  Stream<List<CallEntity>> getMyCallHistory(String uid) {

    final myHistoryCollection = fireStore.collection(FirebaseCollectionConst.users)
        .doc(uid)
        .collection(FirebaseCollectionConst.callHistory).orderBy("createdAt", descending: true);

    return myHistoryCollection.snapshots().map((querySnapshots) => querySnapshots.docs.map((e) => CallModel.fromSnapshot(e)).toList());
  }

  @override
  Stream<List<CallEntity>> getUserCalling(String uid) {
    final callCollection = fireStore.collection(FirebaseCollectionConst.call);
    return callCollection
        .where("callerId", isEqualTo: uid).limit(1)
        .snapshots()
        .map((querySnapshot) =>
        querySnapshot.docs.map((e) =>
            CallModel.fromSnapshot(e)
        ).toList()
    );
  }

  @override
  Future<void> makeCall(CallEntity call) async {
    final callCollection = fireStore.collection(FirebaseCollectionConst.call);

    String callId = callCollection.doc().id;

    final callerData = CallModel(
      callerId: call.callerId,
      callerName: call.callerName,
      callerProfileUrl: call.callerProfileUrl,
      callId: callId,
      isCallDialed: true,
      isMissed: false,
      receiverId: call.receiverId,
      receiverName: call.receiverName,
      receiverProfileUrl: call.receiverProfileUrl,
      createdAt: Timestamp.now(),
    ).toDocument();

    final receiverData = CallModel(
      callerId: call.receiverId,
      callerName: call.receiverName,
      callerProfileUrl: call.receiverProfileUrl,
      callId: callId,
      isCallDialed: false,
      isMissed: false,
      receiverId: call.callerId,
      receiverName: call.callerName,
      receiverProfileUrl: call.callerProfileUrl,
      createdAt: Timestamp.now(),
    ).toDocument();


    try {

      await callCollection.doc(call.callerId).set(callerData);
      await callCollection.doc(call.receiverId).set(receiverData);

    }catch (e) {
      print("something went wrong");
    }



  }

  @override
  Future<void> saveCallHistory(CallEntity call) async {

    final myHistoryCollection = fireStore.collection(FirebaseCollectionConst.users).doc(call.callerId).collection(FirebaseCollectionConst.callHistory);
    final otherHistoryCollection = fireStore.collection(FirebaseCollectionConst.users).doc(call.receiverId).collection(FirebaseCollectionConst.callHistory);

    final callData = CallModel(
      callerId: call.callerId,
      callerName: call.callerName,
      callerProfileUrl: call.callerProfileUrl,
      callId: call.callId,
      isCallDialed: call.isCallDialed,
      isMissed: call.isMissed,
      receiverId: call.receiverId,
      receiverName: call.receiverName,
      receiverProfileUrl: call.receiverProfileUrl,
      createdAt: Timestamp.now(),
    ).toDocument();


    try {

      await myHistoryCollection.doc(call.callId).set(callData, SetOptions(merge: true));
      await otherHistoryCollection.doc(call.callId).set(callData, SetOptions(merge: true));


    }catch (e) {
      print("something went wrong");
    }



  }

  @override
  Future<void> updateCallHistoryStatus(CallEntity call) async {
    final myHistoryCollection = fireStore.collection(FirebaseCollectionConst.users).doc(call.callerId).collection(FirebaseCollectionConst.callHistory);
    final otherHistoryCollection = fireStore.collection(FirebaseCollectionConst.users).doc(call.receiverId).collection(FirebaseCollectionConst.callHistory);

    Map<String, dynamic> myHistoryInfo = {};
    Map<String, dynamic> otherHistoryInfo = {};

    if(call.isCallDialed != null) myHistoryInfo['isCallDialed'] = call.isCallDialed;
    if(call.isMissed != null) myHistoryInfo['isMissed'] = call.isMissed;

    if(call.isCallDialed != null) otherHistoryInfo['isCallDialed'] = call.isCallDialed;
    if(call.isMissed != null) otherHistoryInfo['isMissed'] = call.isMissed;

    myHistoryCollection.doc(call.callId).update(myHistoryInfo);
    otherHistoryCollection.doc(call.callId).update(otherHistoryInfo);
  }
}