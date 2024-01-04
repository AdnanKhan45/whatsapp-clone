

import 'package:whatsapp_clone_app/features/chat/domain/entities/chat_entity.dart';
import 'package:whatsapp_clone_app/features/chat/domain/entities/message_entity.dart';
import 'package:whatsapp_clone_app/features/chat/domain/repository/chat_repository.dart';

class SendMessageUseCase {

  final ChatRepository repository;

  SendMessageUseCase({required this.repository});

  Future<void> call(ChatEntity chat, MessageEntity message) async {
    return await repository.sendMessage(chat, message);
  }
}