
import 'package:whatsapp_clone_app/features/status/domain/entities/status_entity.dart';

abstract class StatusRemoteDataSource {

  Future<void> createStatus(StatusEntity status);
  Future<void> updateStatus(StatusEntity status);
  Future<void> updateOnlyImageStatus(StatusEntity status);
  Future<void> seenStatusUpdate(String statusId, int imageIndex, String userId);
  Future<void> deleteStatus(StatusEntity status);
  Stream<List<StatusEntity>> getStatuses(StatusEntity status);
  Stream<List<StatusEntity>> getMyStatus(String uid);
  Future<List<StatusEntity>> getMyStatusFuture(String uid);
}