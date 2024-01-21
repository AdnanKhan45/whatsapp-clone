


import 'package:whatsapp_clone_app/features/call/domain/entities/call_entity.dart';
import 'package:whatsapp_clone_app/features/call/domain/repository/call_repository.dart';

class MakeCallUseCase {

  final CallRepository repository;

  const MakeCallUseCase({required this.repository});

  Future<void> call(CallEntity call) async {
    return await repository.makeCall(call);
  }
}