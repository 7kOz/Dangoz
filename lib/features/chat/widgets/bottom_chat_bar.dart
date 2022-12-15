import 'dart:async';
import 'dart:io';

import 'package:dangoz/base/app_colors.dart';
import 'package:dangoz/base/enums/message_enums.dart';
import 'package:dangoz/base/utils.dart';
import 'package:dangoz/features/chat/controller/chat_controller.dart';
import 'package:dangoz/features/chat/providers/message_reply_provider.dart';
import 'package:dangoz/features/chat/widgets/message_reply_preview.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class BottomChatBar extends ConsumerStatefulWidget {
  final String recieverId;
  const BottomChatBar({
    Key? key,
    required this.recieverId,
  }) : super(key: key);

  @override
  ConsumerState<BottomChatBar> createState() => _BottomChatBarState();
}

class _BottomChatBarState extends ConsumerState<BottomChatBar> {
  bool isShowSendButton = false;
  final TextEditingController _messageController = TextEditingController();
  FlutterSoundRecorder? _soundRecorder;
  bool isRecorderInit = false;
  bool isRecording = false;
  bool isShoeEmojiContainer = false;
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _soundRecorder = FlutterSoundRecorder();
    openAudio();
  }

  void sendTextMessage() async {
    if (isShowSendButton) {
      ref.read(chatControllerProvider).sendTextMessage(
            _messageController.text.trim(),
            widget.recieverId,
          );

      setState(() {
        _messageController.text = '';
        isShowSendButton = false;
      });
    } else {
      var tempDir = await getTemporaryDirectory();
      var path = '${tempDir.path}/flutter_sound.aac';
      if (!isRecorderInit) {
        return;
      }
      if (isRecording) {
        await _soundRecorder!.stopRecorder();
        sendAttachmentMessage(File(path), MessageEnum.AUDIO);
      } else {
        await _soundRecorder!.startRecorder(
          toFile: path,
        );
      }
      setState(() {
        isRecording = !isRecording;
      });
    }
  }

  void sendAttachmentMessage(
    File file,
    MessageEnum messageEnum,
  ) {
    ref.read(chatControllerProvider).sendAttachmentMessage(
          file,
          widget.recieverId,
          messageEnum,
        );
  }

  void sendGIFtMessage(String gifUrl, String recieverUserId) {
    ref.read(chatControllerProvider).sendGIFMessage(gifUrl, recieverUserId);
  }

  void selectImage() async {
    File? image = await pickImageFromGallery();
    if (image != null) {
      sendAttachmentMessage(image, MessageEnum.IMAGE);
    }
  }

  void selectVideo() async {
    File? video = await pickVideoFromGallery();
    if (video != null) {
      sendAttachmentMessage(video, MessageEnum.VIDEO);
    }
  }

  void selectGIF() async {
    final gif = await pickGIF(context);
    if (gif != null) {
      sendGIFtMessage(gif.url, widget.recieverId);
    }
  }

  void hideEmojiContainer() {
    setState(() {
      isShoeEmojiContainer = false;
    });
  }

  void showEmojiContainer() {
    setState(() {
      isShoeEmojiContainer = true;
    });
  }

  void showKeyboard() => focusNode.requestFocus();

  void hideKeyboard() => focusNode.unfocus();

  void toggleEmojiKeyboardContainer() {
    if (isShoeEmojiContainer) {
      //showKeyboard();
      hideEmojiContainer();
    } else {
      //hideKeyboard();
      showEmojiContainer();
    }
  }

  void openAudio() async {
    final status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      Get.snackbar(
        'Oops',
        'Mic Permission Not Allowed 😔',
        backgroundColor: AppColors.red,
        colorText: Colors.white,
      );
      throw RecordingPermissionException('Mic Permission Not Allowed');
    }
    await _soundRecorder!.openRecorder();
    isRecorderInit = true;
  }

  void deleteAudio() async {
    if (_soundRecorder != null) {
      _soundRecorder!.stopRecorder();
      var tempDir = await getTemporaryDirectory();
      var path = '${tempDir.path}/flutter_sound.aac';
      File(path).delete();
      setState(() {
        isRecording = false;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    _messageController.dispose();
    _soundRecorder!.closeRecorder();
    isRecorderInit = false;
  }

  @override
  Widget build(BuildContext context) {
    final messageReply = ref.watch(messageReplyProvider);
    final isShowMessageReply = messageReply != null;
    return Column(
      children: [
        isShowMessageReply ? const MessageReplyPreview() : const SizedBox(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            isRecording
                ? CircleAvatar(
                    radius: 25,
                    backgroundColor: AppColors.navy,
                    child: Center(
                      child: InkWell(
                        onTap: deleteAudio,
                        splashColor: Colors.transparent,
                        splashFactory: NoSplash.splashFactory,
                        child: Icon(
                          Icons.delete,
                          color: AppColors.red,
                        ),
                      ),
                    ),
                  )
                : Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 4.0),
                      child: TextFormField(
                        focusNode: focusNode,
                        controller: _messageController,
                        onChanged: (value) {
                          if (value.isNotEmpty) {
                            setState(() {
                              isShowSendButton = true;
                            });
                          } else {
                            setState(() {
                              isShowSendButton = false;
                            });
                          }
                        },
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: AppColors.navy,
                          prefixIcon: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: SizedBox(
                              width: 60,
                              child: Row(
                                children: [
                                  InkWell(
                                    onTap: toggleEmojiKeyboardContainer,
                                    splashColor: Colors.transparent,
                                    splashFactory: NoSplash.splashFactory,
                                    child: const Icon(
                                      Icons.emoji_emotions,
                                      color: Colors.yellow,
                                      size: 25,
                                    ),
                                  ),
                                  const Spacer(),
                                  InkWell(
                                    onTap: selectGIF,
                                    splashColor: Colors.transparent,
                                    splashFactory: NoSplash.splashFactory,
                                    child: const Icon(
                                      Icons.gif,
                                      color: Colors.white,
                                      size: 30,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          suffixIcon: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: SizedBox(
                              width: 60,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  InkWell(
                                    onTap: selectImage,
                                    splashColor: Colors.transparent,
                                    splashFactory: NoSplash.splashFactory,
                                    child: Icon(
                                      Icons.camera_alt,
                                      color: AppColors.white,
                                      size: 25,
                                    ),
                                  ),
                                  const Spacer(),
                                  InkWell(
                                    onTap: selectVideo,
                                    splashColor: Colors.transparent,
                                    splashFactory: NoSplash.splashFactory,
                                    child: Icon(
                                      Icons.video_camera_back,
                                      color: AppColors.white,
                                      size: 25,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          hintText: 'Hmmmm',
                          hintStyle: TextStyle(
                            color: AppColors.lightGrey,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(
                                width: 0, style: BorderStyle.none),
                          ),
                          contentPadding: const EdgeInsets.all(20),
                        ),
                      ),
                    ),
                  ),
            Padding(
              padding: const EdgeInsets.only(
                bottom: 8,
                right: 4,
                left: 2,
                top: 8,
              ),
              child: CircleAvatar(
                radius: 25,
                backgroundColor: AppColors.navy,
                child: Center(
                  child: InkWell(
                    onTap: sendTextMessage,
                    splashColor: Colors.transparent,
                    splashFactory: NoSplash.splashFactory,
                    child: Icon(
                      isShowSendButton == true
                          ? Icons.send
                          : isRecording
                              ? Icons.check
                              : Icons.mic,
                      color: isRecording ? AppColors.green : AppColors.white,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
        isShoeEmojiContainer
            ? SizedBox(
                height: Get.height * 0.35,
                child: EmojiPicker(
                  onEmojiSelected: ((category, emoji) {
                    setState(() {
                      _messageController.text =
                          _messageController.text + emoji.emoji;
                    });
                    if (!isShowSendButton) {
                      setState(() {
                        isShowSendButton = true;
                      });
                    }
                  }),
                ),
              )
            : const SizedBox(),
      ],
    );
  }
}
