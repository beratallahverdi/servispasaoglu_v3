import 'dart:io';

import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:servispasaoglu_v3/utils/constants.dart';

import 'package:video_player/video_player.dart';

class VideoPage extends StatefulWidget {
  static const String routeName = '/pages/video';
  const VideoPage({Key? key, required this.videoUrl}) : super(key: key);
  final String videoUrl;
  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  late VideoPlayerController _controller;
  late ChewieController _chewieController;
  Widget _chewieWidget = const Center(
    child: CircularProgressIndicator(),
  );

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
      widget.videoUrl,
      videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
    );
    _controller.initialize().then((_) {
      // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
      setState(() {
        _chewieController = ChewieController(
          videoPlayerController: _controller,
          autoPlay: true,
          looping: false,
        );
        _chewieWidget = Chewie(
          controller: _chewieController,
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      key: ServisPasaogluConstants.scaffoldMessengerKey,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(
              Platform.isIOS ? Icons.arrow_back_ios_new : Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(children: [
          _chewieWidget,
        ]),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _chewieController.dispose();
    super.dispose();
  }
}
