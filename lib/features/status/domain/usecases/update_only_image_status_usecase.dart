

import 'package:whatsapp_clone_app/features/status/domain/entities/status_entity.dart';
import 'package:whatsapp_clone_app/features/status/domain/repository/status_repository.dart';

class UpdateOnlyImageStatusUseCase {

  final StatusRepository repository;

  const UpdateOnlyImageStatusUseCase({required this.repository});

  Future<void> call(StatusEntity status) async {
    return await repository.updateOnlyImageStatus(status);
  }
}