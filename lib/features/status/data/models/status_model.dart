

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:whatsapp_clone_app/features/status/domain/entities/status_entity.dart';
import 'package:whatsapp_clone_app/features/status/domain/entities/status_image_entity.dart';

class StatusModel extends StatusEntity {

  final String? statusId;
  final String? imageUrl;
  final String? uid;
  final String? username;
  final String? profileUrl;
  final Timestamp? createdAt;
  final String? phoneNumber;
  final String? caption;
  final List<StatusImageEntity>? stories;

  StatusModel(
      {this.statusId,
      this.imageUrl,
      this.uid,
      this.username,
      this.profileUrl,
      this.createdAt,
      this.phoneNumber,
      this.caption,
      this.stories}) : super(
    statusId: statusId,
    imageUrl: imageUrl,
    uid: uid,
    username: username,
    profileUrl: profileUrl,
    createdAt: createdAt,
    phoneNumber: phoneNumber,
    caption: caption,
    stories: stories
  );

  factory StatusModel.fromSnapshot(DocumentSnapshot snapshot) {
    final snap = snapshot.data() as Map<String, dynamic>;

    final stories = snap['stories'] as List;
    List<StatusImageEntity> storiesData =
    stories.map((element) => StatusImageEntity.fromJson(element)).toList();

    return StatusModel(
        stories: storiesData,
        statusId: snap['statusId'],
        username: snap['username'],
        phoneNumber: snap['phoneNumber'],
        createdAt: snap['createdAt'],
        uid: snap['uid'],
        profileUrl: snap['profileUrl'],
        imageUrl: snap['imageUrl'],
        caption: snap['caption']
    );
  }

  Map<String, dynamic> toDocument() => {
    "stories": stories?.map((story) => story.toJson()).toList(),
    "statusId": statusId,
    "username": username,
    "phoneNumber": phoneNumber,
    "createdAt": createdAt,
    "uid": uid,
    "profileUrl": profileUrl,
    "imageUrl": imageUrl,
    "caption": caption,
  };
}