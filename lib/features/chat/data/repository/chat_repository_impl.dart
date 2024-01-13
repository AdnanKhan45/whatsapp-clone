

import 'package:whatsapp_clone_app/features/chat/data/remote/chat_remote_data_source.dart';
import 'package:whatsapp_clone_app/features/chat/domain/entities/chat_entity.dart';
import 'package:whatsapp_clone_app/features/chat/domain/entities/message_entity.dart';
import 'package:whatsapp_clone_app/features/chat/domain/repository/chat_repository.dart';

class ChatRepositoryImpl implements ChatRepository {
  final ChatRemoteDataSource remoteDataSource;

  ChatRepositoryImpl({required this.remoteDataSource});
  @override
  Future<void> deleteChat(ChatEntity chat) async => remoteDataSource.deleteChat(chat);

  @override
  Future<void> deleteMessage(MessageEntity message) async => remoteDataSource.deleteMessage(message);
  @override
  Stream<List<MessageEntity>> getMessages(MessageEntity message) => remoteDataSource.getMessages(message);

  @override
  Stream<List<ChatEntity>> getMyChat(ChatEntity chat) => remoteDataSource.getMyChat(chat);
  @override
  Future<void> sendMessage(ChatEntity chat, MessageEntity message) async => remoteDataSource.sendMessage(chat, message);

  @override
  Future<void> seenMessageUpdate(MessageEntity message) async => remoteDataSource.seenMessageUpdate(message);

}