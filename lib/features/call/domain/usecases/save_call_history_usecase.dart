



import 'package:whatsapp_clone_app/features/call/domain/entities/call_entity.dart';
import 'package:whatsapp_clone_app/features/call/domain/repository/call_repository.dart';

class SaveCallHistoryUseCase {

  final CallRepository repository;

  const SaveCallHistoryUseCase({required this.repository});

  Future<void> call(CallEntity call) async {
    return await repository.saveCallHistory(call);
  }
}