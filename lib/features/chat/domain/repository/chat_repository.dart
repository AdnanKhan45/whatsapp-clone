

import 'package:whatsapp_clone_app/features/chat/domain/entities/chat_entity.dart';
import 'package:whatsapp_clone_app/features/chat/domain/entities/message_entity.dart';

abstract class ChatRepository {

  Future<void> sendMessage(ChatEntity chat, MessageEntity message);
  Stream<List<ChatEntity>> getMyChat(ChatEntity chat);
  Stream<List<MessageEntity>> getMessages(MessageEntity message);
  Future<void> deleteMessage(MessageEntity message);
  Future<void> seenMessageUpdate(MessageEntity message);

  Future<void> deleteChat(ChatEntity chat);
}