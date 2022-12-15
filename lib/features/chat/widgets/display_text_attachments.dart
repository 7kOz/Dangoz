import 'package:audio_wave/audio_wave.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dangoz/base/app_colors.dart';
import 'package:dangoz/base/enums/message_enums.dart';
import 'package:dangoz/features/chat/widgets/chat_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class DisplayTextAttachments extends StatelessWidget {
  final String message;
  final MessageEnum type;
  const DisplayTextAttachments(
      {Key? key, required this.message, required this.type})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isPlaying = false;
    final AudioPlayer audioPlayer = AudioPlayer();
    String duration = '0';
    String finalDuration = '';
    return type == MessageEnum.TEXT
        ? Text(
            message,
            style: TextStyle(
              color: AppColors.white,
              fontSize: Get.width * 0.035,
            ),
          )
        : type == MessageEnum.AUDIO
            ? StatefulBuilder(builder: (context, setState) {
                return InkWell(
                  onTap: () async {
                    if (isPlaying) {
                      await audioPlayer.pause();
                      setState(() {
                        isPlaying = false;
                      });
                    } else {
                      audioPlayer.onDurationChanged.listen(
                        (Duration d) {
                          setState(() {
                            finalDuration = d.inSeconds.toString();
                          });
                        },
                      );
                      await audioPlayer.play(UrlSource(message));
                      setState(() {
                        isPlaying = true;
                      });

                      audioPlayer.onPositionChanged.listen(
                        (Duration d) {
                          setState(() {
                            duration = d.inSeconds.toString();
                          });
                        },
                      );
                      audioPlayer.onPlayerComplete.listen((event) {
                        setState(() {
                          isPlaying = false;
                        });
                      });
                    }
                  },
                  splashColor: Colors.transparent,
                  splashFactory: NoSplash.splashFactory,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Icon(
                            isPlaying ? Icons.pause_rounded : Icons.play_circle,
                            color: AppColors.white,
                          ),
                          SizedBox(width: 5),
                          audioWaves(isPlaying),
                        ],
                      ),
                      SizedBox(height: 5),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              duration,
                              style: TextStyle(
                                  color: duration == '0'
                                      ? AppColors.navy
                                      : AppColors.white),
                            ),
                            Text(
                              finalDuration,
                              style: TextStyle(color: AppColors.white),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              })
            : type == MessageEnum.VIDEO
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: ChatVideoPlayer(videoUrl: message))
                : type == MessageEnum.GIF
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: CachedNetworkImage(
                          imageUrl: message,
                        ),
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: CachedNetworkImage(
                          imageUrl: message,
                        ),
                      );
  }

  Widget audioWaves(bool play) {
    return AudioWave(
      height: Get.height * 0.05,
      width: Get.width * 0.5,
      spacing: 2.5,
      animation: true,
      alignment: 'bottom',
      bars: [
        AudioWaveBar(heightFactor: 0.1, color: AppColors.green),
        AudioWaveBar(heightFactor: 0.3, color: AppColors.green),
        AudioWaveBar(heightFactor: 0.7, color: AppColors.green),
        AudioWaveBar(heightFactor: 0.55, color: AppColors.red),
        AudioWaveBar(heightFactor: 0.4, color: AppColors.red),
        AudioWaveBar(heightFactor: 0.7, color: AppColors.green),
        AudioWaveBar(heightFactor: 0.3, color: AppColors.red),
        AudioWaveBar(heightFactor: 0.4, color: AppColors.green),
        AudioWaveBar(heightFactor: 0.4, color: AppColors.green),
        AudioWaveBar(heightFactor: 0.2, color: AppColors.red),
        AudioWaveBar(heightFactor: 0.1, color: AppColors.red),
        AudioWaveBar(heightFactor: 0.3, color: AppColors.green),
        AudioWaveBar(heightFactor: 0.7, color: AppColors.green),
        AudioWaveBar(heightFactor: 0.4, color: AppColors.red),
        AudioWaveBar(heightFactor: 0.2, color: AppColors.red),
        AudioWaveBar(heightFactor: 0.1, color: AppColors.red),
        AudioWaveBar(heightFactor: 0.3, color: AppColors.green),
        AudioWaveBar(heightFactor: 0.4, color: AppColors.green),
        AudioWaveBar(heightFactor: 0.5, color: AppColors.green),
        AudioWaveBar(heightFactor: 0.2, color: AppColors.red),
      ],
    );
  }
}
