import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:whatsapp_clone_app/features/app/const/page_const.dart';
import 'package:whatsapp_clone_app/features/app/global/widgets/profile_widget.dart';
import 'package:whatsapp_clone_app/features/app/theme/style.dart';
import 'package:whatsapp_clone_app/features/chat/domain/entities/chat_entity.dart';
import 'package:whatsapp_clone_app/features/chat/domain/entities/message_entity.dart';
import 'package:whatsapp_clone_app/features/chat/presentation/cubit/chat/chat_cubit.dart';

class ChatPage extends StatefulWidget {
  final String uid;
  const ChatPage({super.key, required this.uid});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {

  @override
  void initState() {
    BlocProvider.of<ChatCubit>(context).getMyChat(chat: ChatEntity(senderUid: widget.uid));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocBuilder<ChatCubit, ChatState>(
          builder: (context, state) {
            if(state is ChatLoaded) {
              final myChat = state.chatContacts;

              if(myChat.isEmpty) {
                return const Center(
                  child: Text("No Conversation Yet"),
                );
              }

              return ListView.builder(itemCount: myChat.length, itemBuilder: (context, index) {

                final chat = myChat[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, PageConst.singleChatPage,
                        arguments: MessageEntity(
                          senderUid: chat.senderUid,
                          recipientUid:chat.recipientUid,
                          senderName: chat.senderName,
                          recipientName: chat.recipientName,
                          senderProfile: chat.senderProfile,
                          recipientProfile: chat.recipientProfile,
                          uid: widget.uid
                    ));
                  },
                  child: ListTile(
                    leading: SizedBox(
                      width: 50,
                      height: 50,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: profileWidget(),
                      ),
                    ),
                    title: Text("${chat.recipientName}"),
                    subtitle: Text("${chat.recentTextMessage}", maxLines: 1, overflow: TextOverflow.ellipsis,),
                    trailing: Text(
                      DateFormat.jm().format(chat.createdAt!.toDate()),
                      style: const TextStyle(color: greyColor, fontSize: 13),
                    ),
                  ),
                );
              });

            }
            return const Center(
              child: CircularProgressIndicator(
                color: tabColor,
              ),
            );
          },
        )
    );
  }
}
