

import 'package:whatsapp_clone_app/features/status/domain/entities/status_entity.dart';
import 'package:whatsapp_clone_app/features/status/domain/repository/status_repository.dart';

class GetMyStatusUseCase {

  final StatusRepository repository;

  const GetMyStatusUseCase({required this.repository});

  Stream<List<StatusEntity>> call(String uid) {
    return repository.getMyStatus(uid);
  }
}