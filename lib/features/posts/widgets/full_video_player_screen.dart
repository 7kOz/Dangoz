import 'package:cached_video_player/cached_video_player.dart';
import 'package:dangoz/base/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class FullPostVideoPlayer extends StatefulWidget {
  String videoUrl;
  FullPostVideoPlayer({Key? key, required this.videoUrl}) : super(key: key);

  @override
  State<FullPostVideoPlayer> createState() => _FullPostVideoPlayerState();
}

class _FullPostVideoPlayerState extends State<FullPostVideoPlayer> {
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.navy,
      ),
      body: Center(
        child: AspectRatio(
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
                    //Add Repeat Loop
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
        ),
      ),
    );
  }
}
