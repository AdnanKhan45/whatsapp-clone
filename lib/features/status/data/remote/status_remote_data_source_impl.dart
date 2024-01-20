
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:whatsapp_clone_app/features/app/const/firebase_collection_const.dart';
import 'package:whatsapp_clone_app/features/status/data/models/status_model.dart';
import 'package:whatsapp_clone_app/features/status/data/remote/status_remote_data_source.dart';
import 'package:whatsapp_clone_app/features/status/domain/entities/status_entity.dart';
import 'package:whatsapp_clone_app/features/status/domain/entities/status_image_entity.dart';

class StatusRemoteDataSourceImpl implements StatusRemoteDataSource {
  final FirebaseFirestore fireStore;

  StatusRemoteDataSourceImpl({required this.fireStore});

  @override
  Future<void> createStatus(StatusEntity status) async {
    final statusCollection =
    fireStore.collection(FirebaseCollectionConst.status);

    final statusId = statusCollection.doc().id;

    final newStatus = StatusModel(
        imageUrl: status.imageUrl,
        profileUrl: status.profileUrl,
        uid: status.uid,
        createdAt: status.createdAt,
        phoneNumber: status.phoneNumber,
        username: status.username,
        statusId: statusId,
        caption: status.caption,
        stories: status.stories,
    ).toDocument();

    final statusDocRef = await statusCollection.doc(statusId).get();

    try {
      if (!statusDocRef.exists) {
        statusCollection.doc(statusId).set(newStatus);
      } else {
        return;
      }
    } catch (e) {
      print("Some error occur while creating status");
    }

  }

  @override
  Future<void> deleteStatus(StatusEntity status) async {
    final statusCollection =
    fireStore.collection(FirebaseCollectionConst.status);

    try {
      statusCollection.doc(status.statusId).delete();
    } catch (e) {
      print("some error occur while deleting status");
    }

  }

  @override
  Stream<List<StatusEntity>> getMyStatus(String uid) {
    final statusCollection =
    fireStore.collection(FirebaseCollectionConst.status)
        .where("uid", isEqualTo: uid)
        .limit(1)
      .where(
        "createdAt",
        isGreaterThan: DateTime.now().subtract(
        const Duration(hours: 24),
    ));


    return statusCollection.snapshots().map((querySnapshot) => querySnapshot
        .docs
        .where((doc) => doc
        .data()['createdAt']
        .toDate()
        .isAfter(DateTime.now().subtract(const Duration(hours: 24))))
        .map((e) => StatusModel.fromSnapshot(e))
        .toList());
  }

  @override
  Future<List<StatusEntity>> getMyStatusFuture(String uid) {
    final statusCollection =
    fireStore.collection(FirebaseCollectionConst.status)
        .where("uid", isEqualTo: uid)
        .limit(1)
        .where(
        "createdAt",
        isGreaterThan: DateTime.now().subtract(
          const Duration(hours: 24),
        ));

    return statusCollection.get().then((querySnapshot) => querySnapshot
        .docs
        .where((doc) => doc
        .data()['createdAt']
        .toDate()
        .isAfter(DateTime.now().subtract(const Duration(hours: 24))))
        .map((e) => StatusModel.fromSnapshot(e))
        .toList());
  }

  @override
  Stream<List<StatusEntity>> getStatuses(StatusEntity status) {
    final statusCollection =
    fireStore.collection(FirebaseCollectionConst.status)
        .where(
        "createdAt",
        isGreaterThan: DateTime.now().subtract(
          const Duration(hours: 24),
        ));


    return statusCollection.snapshots().map((querySnapshot) => querySnapshot
        .docs
        .where((doc) => doc
        .data()['createdAt']
        .toDate()
        .isAfter(DateTime.now().subtract(const Duration(hours: 24))))
        .map((e) => StatusModel.fromSnapshot(e))
        .toList());
  }

  @override
  Future<void> seenStatusUpdate(String statusId, int imageIndex, String userId) async {
    try {
      final statusDocRef = fireStore
          .collection(FirebaseCollectionConst.status)
          .doc(statusId);

      final statusDoc = await statusDocRef.get();

      final stories = List<Map<String, dynamic>>.from(statusDoc.get('stories'));

      final viewersList = List<String>.from(stories[imageIndex]['viewers']);

      // Check if the user ID is already present in the viewers list
      if (!viewersList.contains(userId)) {
        viewersList.add(userId);

        // Update the viewers list for the specified image index
        stories[imageIndex]['viewers'] = viewersList;

        await statusDocRef.update({
          'stories': stories,
        });
      }


    } catch (error) {
      print('Error updating viewers list: $error');
    }
  }

  @override
  Future<void> updateOnlyImageStatus(StatusEntity status) async {
    final statusCollection =
    fireStore.collection(FirebaseCollectionConst.status);

    final statusDocRef = await statusCollection.doc(status.statusId).get();

    try {
      if (statusDocRef.exists) {

        final existingStatusData = statusDocRef.data()!;
        final createdAt = existingStatusData['createdAt'].toDate();

        // check if the existing status is still within its 24 hours period
        if (createdAt.isAfter(DateTime.now().subtract(const Duration(hours: 24)))) {
          // if it is, update the existing status with the new stores (images, or videos)

          final stories = List<Map<String, dynamic>>.from(statusDocRef.get('stories'));

          stories.addAll(status.stories!.map((e) => StatusImageEntity.toJsonStatic(e)));
          // final updatedStories = List<StatusImageEntity>.from(existingStatusData['stories'])
          //   ..addAll(status.stories!);

          await statusCollection.doc(status.statusId).update({
            'stories': stories,
            'imageUrl': stories[0]['url']
          });
          return;
        }
      } else {
        return;
      }
    } catch (e) {
      print("Some error occur while updating status stories");
    }
  }

  @override
  Future<void> updateStatus(StatusEntity status) async {
    final statusCollection =
    fireStore.collection(FirebaseCollectionConst.status);

    Map<String, dynamic> statusInfo = {};

    if (status.imageUrl != "" && status.imageUrl != null) {
      statusInfo['imageUrl'] = status.imageUrl;
    }

    if (status.stories != null) {
      statusInfo['stories'] = status.stories;
    }

    statusCollection.doc(status.statusId).update(statusInfo);
  }

}