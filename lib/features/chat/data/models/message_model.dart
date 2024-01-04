

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:whatsapp_clone_app/features/chat/domain/entities/message_entity.dart';

class MessageModel extends MessageEntity {

  final String? senderUid;
  final String? recipientUid;
  final String? senderName;
  final String? recipientName;
  final String? messageType;
  final String? message;
  final Timestamp? createdAt;
  final bool? isSeen;
  final String? repliedTo;
  final String? repliedMessage;
  final String? repliedMessageType;
  final String? messageId;

  MessageModel(
      {
        this.senderUid,
        this.recipientUid,
        this.senderName,
        this.recipientName,
        this.messageType,
        this.message,
        this.createdAt,
        this.isSeen,
        this.repliedTo,
        this.repliedMessage,
        this.repliedMessageType,
        this.messageId
      }) : super(
      senderUid: senderUid,
      recipientUid: recipientUid,
      senderName: senderName,
      recipientName: recipientName,
      message: message,
      messageType: messageType,
      messageId: messageId,
      createdAt: createdAt,
      isSeen: isSeen,
      repliedTo: repliedTo,
      repliedMessage: repliedMessage,
      repliedMessageType: repliedMessageType
  );

  factory MessageModel.fromSnapshot(DocumentSnapshot snapshot) {
    final snap = snapshot.data() as Map<String, dynamic>;

    return MessageModel(
      senderUid: snap['senderUid'],
      senderName: snap['senderName'],
      recipientUid: snap['recipientUid'],
      recipientName: snap['recipientName'],
      createdAt: snap['createdAt'],
      isSeen: snap['isSeen'],
      message: snap['message'],
      messageType: snap['messageType'],
      repliedMessage: snap['repliedMessage'],
      repliedTo: snap['repliedTo'],
      messageId: snap['messageId'],
      repliedMessageType: snap['repliedMessageType'],
    );
  }

  Map<String, dynamic> toDocument() => {
    "senderUid": senderUid,
    "senderName": senderName,
    "recipientUid": recipientUid,
    "recipientName": recipientName,
    "createdAt": createdAt,
    "isSeen": isSeen,
    "message": message,
    "messageType": messageType,
    "repliedMessage": repliedMessage,
    "repliedTo": repliedTo,
    "messageId": messageId,
    "repliedMessageType": repliedMessageType,
  };
}