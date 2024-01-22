


import 'package:whatsapp_clone_app/features/call/domain/entities/call_entity.dart';

abstract class CallRemoteDataSource {

  Future<void> makeCall(CallEntity call);
  Future<void> endCall(CallEntity call);
  Future<void> updateCallHistoryStatus(CallEntity call);

  Future<void> saveCallHistory(CallEntity call);
  Stream<List<CallEntity>> getUserCalling(String uid);
  Stream<List<CallEntity>> getMyCallHistory(String uid);
  Future<String> getCallChannelId(String uid);
}