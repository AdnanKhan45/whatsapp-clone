

import 'package:whatsapp_clone_app/features/call/data/remote/call_remote_data_source.dart';
import 'package:whatsapp_clone_app/features/call/domain/entities/call_entity.dart';
import 'package:whatsapp_clone_app/features/call/domain/repository/call_repository.dart';

class CallRepositoryImpl implements CallRepository {
  final CallRemoteDataSource remoteDataSource;

  CallRepositoryImpl({required this.remoteDataSource});

  @override
  Future<void> endCall(CallEntity call) async => remoteDataSource.endCall(call);

  @override
  Future<String> getCallChannelId(String uid) async => remoteDataSource.getCallChannelId(uid);

  @override
  Stream<List<CallEntity>> getMyCallHistory(String uid) => remoteDataSource.getMyCallHistory(uid);

  @override
  Stream<List<CallEntity>> getUserCalling(String uid) => remoteDataSource.getUserCalling(uid);

  @override
  Future<void> makeCall(CallEntity call) async => remoteDataSource.makeCall(call);

  @override
  Future<void> saveCallHistory(CallEntity call) async => remoteDataSource.saveCallHistory(call);

  @override
  Future<void> updateCallHistoryStatus(CallEntity call) async => remoteDataSource.updateCallHistoryStatus(call);
}