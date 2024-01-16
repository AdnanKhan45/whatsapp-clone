
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class CachedVideoMessageWidget extends StatefulWidget {
  final String url;
  const CachedVideoMessageWidget({
    Key? key,
    required this.url,
  }) : super(key: key);

  @override
  State<CachedVideoMessageWidget> createState() => _CachedVideoMessageWidgetState();
}

class _CachedVideoMessageWidgetState extends State<CachedVideoMessageWidget> {
  late VideoPlayerController videoPlayerController;
  bool isPlay = false;

  @override
  void initState() {
    super.initState();
    videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(widget.url))
      ..initialize().then((value) {
        videoPlayerController.setVolume(1);
      });
  }

  @override
  void dispose() {
    super.dispose();
    videoPlayerController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Stack(
        children: [
          VideoPlayer(videoPlayerController),
          Align(
            alignment: Alignment.center,
            child: IconButton(
              onPressed: () {
                if (isPlay) {
                  videoPlayerController.pause();
                } else {
                  videoPlayerController.play();
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
      ),
    );
  }
}
