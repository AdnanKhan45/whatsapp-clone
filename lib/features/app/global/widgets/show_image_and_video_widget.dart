
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:whatsapp_clone_app/features/app/theme/style.dart';


class ShowMultiImageAndVideoPickedWidget extends StatefulWidget {
  final List<File> selectedFiles;
  final VoidCallback onTap;
  const ShowMultiImageAndVideoPickedWidget({super.key, required this.selectedFiles, required this.onTap});

  @override
  State<ShowMultiImageAndVideoPickedWidget> createState() => _ShowMultiImageAndVideoPickedWidgetState();
}

class _ShowMultiImageAndVideoPickedWidgetState extends State<ShowMultiImageAndVideoPickedWidget> {

  late PageController _pageController;
  late Map<int, Future<void>> _videoInitFutures;
  late Map<int, VideoPlayerController> _videoControllers;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _videoControllers = {};
    _videoInitFutures = {};

    for (int i = 0; i < widget.selectedFiles.length; i++) {
      if (_isVideo(widget.selectedFiles[i])) {
        _videoControllers[i] = VideoPlayerController.file(widget.selectedFiles[i]);
        _videoInitFutures[i] = _videoControllers[i]!.initialize();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      child: Stack(
        alignment: Alignment.center,
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: widget.selectedFiles.length,
            itemBuilder: (context, index) {
              return _buildItem(widget.selectedFiles[index], index);
            },
          ),

          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(onTap: () {
                    Navigator.pop(context);
                  },child: const Icon(Icons.close_outlined, size: 30, color: Colors.white,)),
                  const Row(
                    children: [
                      Icon(Icons.crop, size: 30, color: Colors.white,),
                      SizedBox(width: 20,),
                      Icon(Icons.emoji_emotions_outlined, size: 30, color: Colors.white,),
                      SizedBox(width: 20,),
                      Icon(Icons.text_fields, size: 30, color: Colors.white,),
                      SizedBox(width: 20,),
                      Icon(Icons.edit_outlined, size: 30, color: Colors.white,),
                    ],
                  )
                ],
              ),
            ),
          ),

          Align(
            alignment: Alignment.bottomRight,
            child: GestureDetector(
              onTap: widget.onTap,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: tabColor),
                      child: const Center(
                        child: Icon(
                          Icons.send_outlined,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool _isVideo(File file) {
    return file.path.toLowerCase().endsWith('.mp4'); // Assuming mp4 as video format, modify as required
  }

  Widget _buildItem(File file, int index) {
    if (_isVideo(file)) {
      return FutureBuilder(
        future: _videoInitFutures[index],
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Stack(
              alignment: Alignment.center,
              children: [
                AspectRatio(aspectRatio: 16/9,child: VideoPlayer(_videoControllers[index]!)),
                Center(
                  child: IconButton(
                    icon: Icon(
                      _videoControllers[index]!.value.isPlaying ? Icons.pause : Icons.play_arrow,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      setState(() {
                        if (_videoControllers[index]!.value.isPlaying) {
                          _videoControllers[index]!.pause();
                        } else {
                          _videoControllers[index]!.play();
                        }
                      });
                    },
                  ),
                )
              ],
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      );
    } else {
      return Image.file(file, fit: BoxFit.cover);
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    _videoControllers.values.forEach((controller) {
      controller.dispose();
    });
    super.dispose();
  }


}


