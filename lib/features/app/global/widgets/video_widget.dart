
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';


class VideoWidget extends StatefulWidget {
  final File videoFile;
  const VideoWidget({super.key, required this.videoFile});

  @override
  _VideoWidgetState createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {
  late VideoPlayerController _controller;

  bool isPlay = false;


  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(widget.videoFile)
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return  Stack(
      alignment: Alignment.center,
      children: [
        _controller.value.isInitialized
            ? AspectRatio(
          aspectRatio: _controller.value.aspectRatio,
          child: VideoPlayer(_controller),
        )
            : Container(),
        Align(
          alignment: Alignment.center,
          child: IconButton(
            onPressed: () {
              if (isPlay) {
                _controller.pause();
              } else {
                _controller.play();
              }

              setState(() {
                isPlay = !isPlay;
              });
            },
            icon: Icon(
              isPlay ? Icons.pause_circle : Icons.play_circle, size: 40,
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
