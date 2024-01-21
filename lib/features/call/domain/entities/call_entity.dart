


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class CallEntity extends Equatable {

  final String? callId;
  final String? callerId;
  final String? callerName;
  final String? callerProfileUrl;

  final String? receiverId;
  final String? receiverName;
  final String? receiverProfileUrl;
  final bool? isCallDialed;
  final bool? isMissed;
  final Timestamp? createdAt;

  const CallEntity(
      {
        this.callId,
        this.callerId,
        this.callerName,
        this.callerProfileUrl,
        this.receiverId,
        this.receiverName,
        this.receiverProfileUrl,
        this.isCallDialed,
        this.isMissed,
        this.createdAt,
      });

  @override
  List<Object?> get props => [
    callId,
    callerId,
    callerName,
    callerProfileUrl,
    receiverId,
    receiverName,
    receiverProfileUrl,
    isCallDialed,
    isMissed,
    createdAt,
  ];


}