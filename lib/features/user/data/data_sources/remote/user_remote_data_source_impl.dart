
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:whatsapp_clone_app/features/app/const/app_const.dart';
import 'package:whatsapp_clone_app/features/app/const/firebase_collection_const.dart';
import 'package:whatsapp_clone_app/features/user/data/data_sources/remote/user_remote_data_source.dart';
import 'package:whatsapp_clone_app/features/user/data/models/user_model.dart';
import 'package:whatsapp_clone_app/features/user/domain/entities/contact_entity.dart';
import 'package:whatsapp_clone_app/features/user/domain/entities/user_entity.dart';

class UserRemoteDataSourceImpl implements UserRemoteDataSource {

  final FirebaseFirestore fireStore;
  final FirebaseAuth auth;

  UserRemoteDataSourceImpl({required this.fireStore, required this.auth});

  String _verificationId = "";


  @override
  Future<void> createUser(UserEntity user) async {

    final userCollection =
    fireStore.collection(FirebaseCollectionConst.users);

    final uid = await getCurrentUID();

    final newUser = UserModel(
        email: user.email,
        uid: uid,
        isOnline: user.isOnline,
        phoneNumber: user.phoneNumber,
        username: user.username,
        profileUrl: user.profileUrl,
        status: user.status
    ).toDocument();


    try {

      userCollection.doc(uid).get().then((userDoc) {


        if(!userDoc.exists) {
          userCollection.doc(uid).set(newUser);
        } else {
          userCollection.doc(uid).update(newUser);
        }
      });

    } catch (e) {
      throw Exception("Error occur while creating user");
    }


  }

  @override
  Stream<List<UserEntity>> getAllUsers() {
    final userCollection =
    fireStore.collection(FirebaseCollectionConst.users);
    return userCollection.snapshots().map((querySnapshot) => querySnapshot.docs.map((e) => UserModel.fromSnapshot(e)).toList());

  }

  @override
  Future<String> getCurrentUID() async => auth.currentUser!.uid;

  @override
  Future<List<ContactEntity>> getDeviceNumber() async {
    List<ContactEntity> contactsList=[];

    if(await FlutterContacts.requestPermission()) {
      List<Contact> contacts = await FlutterContacts.getContacts(
          withProperties: true, withPhoto: true);

      for (var contact in contacts) {
        contactsList.add(
            ContactEntity(
                name: contact.name,
                photo: contact.photo,
                phones: contact.phones
            )
        );
      }
    }

    return contactsList;
  }

  @override
  Stream<List<UserEntity>> getSingleUser(String uid) {
    final userCollection =
    fireStore.collection(FirebaseCollectionConst.users).where("uid", isEqualTo: uid);
    return userCollection.snapshots().map((querySnapshot) => querySnapshot.docs.map((e) => UserModel.fromSnapshot(e)).toList());
  }

  @override
  Future<bool> isSignIn() async => auth.currentUser?.uid != null;

  @override
  Future<void> signInWithPhoneNumber(String smsPinCode) async {

    try {

      final AuthCredential credential = PhoneAuthProvider.credential(
          smsCode: smsPinCode, verificationId: _verificationId);

      await auth.signInWithCredential(credential);


    } on FirebaseAuthException catch(e) {
      if(e.code == 'invalid-verification-code') {
        toast("Invalid Verification Code");
      } else if (e.code == 'quota-exceeded') {
        toast("SMS quota-exceeded");
      }
    } catch (e) {
      toast("Unknown exception please try again");
    }
  }

  @override
  Future<void> signOut() async => auth.signOut();

  @override
  Future<void> updateUser(UserEntity user) async {
    final userCollection =
    fireStore.collection(FirebaseCollectionConst.users);

    Map<String, dynamic> userInfo = {};

    if(user.username != "" && user.username != null) userInfo['username'] = user.username;
    if(user.status != "" && user.status != null) userInfo['status'] = user.status;

    if(user.profileUrl != "" && user.profileUrl != null) userInfo['profileUrl'] = user.profileUrl;

    if(user.isOnline != null) userInfo['isOnline'] = user.isOnline;

    userCollection.doc(user.uid).update(userInfo);



  }

  @override
  Future<void> verifyPhoneNumber(String phoneNumber) async  {

    phoneVerificationCompleted(AuthCredential authCredential) {
      print("phone verified : Token ${authCredential.token} ${authCredential.signInMethod}");
    }

    phoneVerificationFailed(FirebaseAuthException firebaseAuthException) {
      print(
        "phone failed : ${firebaseAuthException.message},${firebaseAuthException.code}",
      );
    }

    phoneCodeAutoRetrievalTimeout(String verificationId) {
      _verificationId = verificationId;
      print("time out :$verificationId");
    }

    phoneCodeSent(String verificationId, int? forceResendingToken) {
      _verificationId = verificationId;
    }

    await auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: phoneVerificationCompleted,
      verificationFailed: phoneVerificationFailed,
      timeout: const Duration(seconds: 60),
      codeSent: phoneCodeSent,
      codeAutoRetrievalTimeout: phoneCodeAutoRetrievalTimeout,
    );
  }

}