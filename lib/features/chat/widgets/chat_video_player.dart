import 'package:cached_video_player/cached_video_player.dart';
import 'package:dangoz/base/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class ChatVideoPlayer extends StatefulWidget {
  String videoUrl;
  ChatVideoPlayer({Key? key, required this.videoUrl}) : super(key: key);

  @override
  State<ChatVideoPlayer> createState() => _ChatVideoPlayerState();
}

class _ChatVideoPlayerState extends State<ChatVideoPlayer> {
  late CachedVideoPlayerController videoPlayerController;
  bool isPlay = false;

  @override
  void initState() {
    super.initState();
    videoPlayerController = CachedVideoPlayerController.network(widget.videoUrl)
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
      aspectRatio: 16 / 16,
      child: Stack(
        children: [
          CachedVideoPlayer(videoPlayerController),
          Align(
            alignment: Alignment.center,
            child: InkWell(
              onTap: () {
                isPlay
                    ? videoPlayerController.pause()
                    : videoPlayerController.play();

                setState(() {
                  isPlay = !isPlay;
                });
              },
              splashColor: Colors.transparent,
              splashFactory: NoSplash.splashFactory,
              child: Icon(
                !isPlay ? Icons.play_circle : Icons.pause_circle,
                color: AppColors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
