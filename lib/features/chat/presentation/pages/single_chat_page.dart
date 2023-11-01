
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:swipe_to/swipe_to.dart';
import 'package:whatsapp_clone_app/features/app/theme/style.dart';

class SingleChatPage extends StatefulWidget {
  const SingleChatPage({super.key});

  @override
  State<SingleChatPage> createState() => _SingleChatPageState();
}

class _SingleChatPageState extends State<SingleChatPage> {

  final TextEditingController _textMessageController = TextEditingController();

  bool _isDisplaySendButton = false;
  @override
  void dispose() {
    _textMessageController.dispose();
    super.dispose();
  }

  bool _isShowAttachWindow = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Column(
          children: [
            Text('Username'),
            Text('Online', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w400),),
          ],
        ),
        actions: const [
          Icon(
            Icons.videocam_rounded,
            size: 25,
          ),
          SizedBox(
            width: 25,
          ),
          Icon(
            Icons.call,
            size: 22,
          ),
          SizedBox(
            width: 25,
          ),
          Icon(
            Icons.more_vert,
            size: 22,
          ),
          SizedBox(
            width: 15,
          ),
        ],
      ),
      body: GestureDetector(
        onTap: () {
          setState(() {
            _isShowAttachWindow = false;
          });
        },
        child: Stack(
          children: [
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              top: 0,
              child: Image.asset("assets/whatsapp_bg_image.png",
                  fit: BoxFit.cover),
            ),

            Column(
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      _messageLayout(
                        message: "Hello",
                        alignment: Alignment.centerRight,
                        createAt: Timestamp.now(),
                        isSeen: false,
                        isShowTick: true,
                        messageBgColor: messageColor,
                        onLongPress: () {},
                        onSwipe: () {},
                      ),
                      _messageLayout(
                        message: "How are you?",
                        alignment: Alignment.centerRight,
                        createAt: Timestamp.now(),
                        isSeen: false,
                        isShowTick: true,
                        messageBgColor: messageColor,
                        onLongPress: () {},
                        onSwipe: () {},
                      ),
                      _messageLayout(
                        message: "Hi",
                        alignment: Alignment.centerLeft,
                        createAt: Timestamp.now(),
                        isSeen: false,
                        isShowTick: false,
                        messageBgColor: senderMessageColor,
                        onLongPress: () {},
                        onSwipe: () {},
                      ),
                      _messageLayout(
                        message: "Doing good, how about you?",
                        alignment: Alignment.centerLeft,
                        createAt: Timestamp.now(),
                        isSeen: false,
                        isShowTick: false,
                        messageBgColor: senderMessageColor,
                        onLongPress: () {},
                        onSwipe: () {},
                      ),

                    ],
                  ),
                ),

                Container(
                  margin: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          decoration: BoxDecoration(
                              color: appBarColor,
                              borderRadius: BorderRadius.circular(25)),
                          height: 50,
                          child: TextField(
                            onTap: () {
                              setState(() {
                                _isShowAttachWindow = false;
                              });
                            },
                            controller: _textMessageController,
                            onChanged: (value) {
                              if (value.isNotEmpty) {
                                setState(() {
                                  _isDisplaySendButton = true;
                                });
                              } else {
                                setState(() {
                                  _isDisplaySendButton = false;
                                });
                              }
                            },
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(vertical: 15),
                              prefixIcon: const Icon(Icons.emoji_emotions, color: greyColor,),
                              suffixIcon: Padding(
                                padding: const EdgeInsets.only(top: 12.0),
                                child: Wrap(
                                  children: [
                                    Transform.rotate(
                                      angle: -0.5,
                                      child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            _isShowAttachWindow = !_isShowAttachWindow;
                                          });
                                        },
                                        child: const Icon(
                                          Icons.attach_file,
                                          color: greyColor,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    const Icon(
                                      Icons.camera_alt,
                                      color: greyColor,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                  ],
                                ),
                              ),
                              hintText: 'Message',
                              border: InputBorder.none,

                            ),
                          ),
                        ),
                      ),

                      const SizedBox(width: 10.0),
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: tabColor),
                        child: Center(
                          child: Icon(
                            _isDisplaySendButton
                                ? Icons.send_outlined
                                : Icons.mic,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            _isShowAttachWindow == true?Positioned(
              bottom: 65,
              top: 340,
              left: 15,
              right: 15,
              child: Container(
                width: double.infinity,
                height:
                MediaQuery.of(context).size.width * 0.20,
                padding: const EdgeInsets.symmetric(
                    horizontal: 5, vertical: 20),
                decoration: BoxDecoration(
                  color: bottomAttachContainerColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _attachWindowItem(
                          icon: Icons.document_scanner,
                          color: Colors.deepPurpleAccent,
                          title: "Document",
                        ),
                        _attachWindowItem(
                            icon: Icons.camera_alt,
                            color: Colors.pinkAccent,
                            title: "Camera",
                            onTap: () {}),
                        _attachWindowItem(
                            icon: Icons.image,
                            color: Colors.purpleAccent,
                            title: "Gallery"),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                      children: [
                        _attachWindowItem(
                            icon: Icons.headphones,
                            color: Colors.deepOrange,
                            title: "Audio"),
                        _attachWindowItem(
                            icon: Icons.location_on,
                            color: Colors.green,
                            title: "Location"),
                        _attachWindowItem(
                            icon: Icons.account_circle,
                            color: Colors.deepPurpleAccent,
                            title: "Contact"),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                      children: [
                        _attachWindowItem(
                          icon: Icons.bar_chart,
                          color: tabColor,
                          title: "Poll",
                        ),
                        _attachWindowItem(
                            icon: Icons.gif_box_outlined,
                            color: Colors.indigoAccent,
                            title: "Gif",
                            onTap: () {}),
                        _attachWindowItem(
                            icon: Icons.videocam_rounded,
                            color: Colors.lightGreen,
                            title: "Video",
                            onTap: () {}),
                      ],
                    )
                  ],
                ),
              ),
            ) : Container()
          ],
        ),
      ),
    );
  }

  _messageLayout({
    Color? messageBgColor,
    Alignment? alignment,
    Timestamp? createAt,
    VoidCallback? onSwipe,
    String? message,
    bool? isShowTick,
    bool? isSeen,
    VoidCallback? onLongPress,
}) {


    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: SwipeTo(
        onRightSwipe: onSwipe,
        child: GestureDetector(
          onLongPress: onLongPress,
          child: Container(
            alignment: alignment,
            child: Stack(
              children: [
                Column(
                  children: [

                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      padding: const EdgeInsets.only(left: 5, right: 85, top: 5, bottom: 5),
                      constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * 0.80),
                      decoration: BoxDecoration(
                          color: messageBgColor,
                          borderRadius: BorderRadius.circular(8)),
                      child: Text(
                        "$message",
                        style: const TextStyle(color: Colors.white, fontSize: 16,),
                      ),
                    ),
                    const SizedBox(height: 3),

                  ],
                ),

                Positioned(
                  bottom: 4,
                  right: 10,
                  child: Row(
                    children: [
                      Text(DateFormat.jm().format(createAt!.toDate()),
                          style: const TextStyle(fontSize: 12, color: greyColor)),
                      const SizedBox(
                        width: 5,
                      ),
                      isShowTick == true
                          ? Icon(
                        isSeen == true? Icons.done_all : Icons.done,
                        size: 16,
                        color: isSeen == true? Colors.blue : greyColor,
                      )
                          : Container()
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
}

  _attachWindowItem(
      {IconData? icon, Color? color, String? title, VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 55,
            height: 55,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40), color: color),
            child: Icon(icon),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            "$title",
            style: const TextStyle(color: greyColor, fontSize: 13),
          ),
        ],
      ),
    );
  }

}
