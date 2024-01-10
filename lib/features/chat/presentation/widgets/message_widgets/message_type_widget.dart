
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_clone_app/features/app/const/message_type_const.dart';
import 'package:whatsapp_clone_app/features/app/global/widgets/profile_widget.dart';
import 'package:whatsapp_clone_app/features/app/theme/style.dart';
import 'package:whatsapp_clone_app/features/chat/presentation/widgets/message_widgets/message_audio_widget.dart';
import 'package:whatsapp_clone_app/features/chat/presentation/widgets/message_widgets/message_video_widget.dart';

class MessageTypeWidget extends StatelessWidget {
  final String? type;
  final String? message;
  const MessageTypeWidget({Key? key, this.type, this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    if(type == MessageTypeConst.textMessage) {
      return Text(
        "$message",
        style: const TextStyle(color: Colors.white, fontSize: 16,),
      );
    } else if (type == MessageTypeConst.photoMessage) {
      return Container(
        padding: const EdgeInsets.only(bottom: 20),
        child: profileWidget(
          imageUrl: message
        ),
      );
    } else if (type == MessageTypeConst.videoMessage) {
      return Container(
          padding: const EdgeInsets.only(bottom: 20),
          child: CachedVideoMessageWidget(url: message!));
    } else if (type == MessageTypeConst.gifMessage) {
      return Container(
        padding: const EdgeInsets.only(bottom: 20),
        child: CachedNetworkImage(imageUrl: message!,
          placeholder: (context, url) => const CircularProgressIndicator(),
          errorWidget: (context, url, error) => const Icon(Icons.error),),
      );
    } else if (type == MessageTypeConst.audioMessage) {
      return MessageAudioWidget(audioUrl: message,);
    } else {
      return Text(
        "$message", maxLines: 2,
        style: const TextStyle(color: greyColor, fontSize: 12, overflow: TextOverflow.ellipsis),
      );
    }
  }
}
