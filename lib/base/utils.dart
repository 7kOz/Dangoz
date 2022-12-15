import 'dart:io';

import 'package:dangoz/base/app_colors.dart';
import 'package:enough_giphy_flutter/enough_giphy_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

Future<File?> pickImageFromGallery() async {
  File? image;
  try {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      image = File(pickedImage.path);
    }
  } catch (e) {
    Get.snackbar(
      'Oops',
      e.toString(),
      backgroundColor: AppColors.red,
    );
  }
  return image;
}

Future<File?> pickVideoFromGallery() async {
  File? video;
  try {
    final pickedVideo =
        await ImagePicker().pickVideo(source: ImageSource.gallery);

    if (pickedVideo != null) {
      video = File(pickedVideo.path);
    }
  } catch (e) {
    Get.snackbar(
      'Oops',
      e.toString(),
      backgroundColor: AppColors.red,
    );
  }
  return video;
}

Future<GiphyGif?> pickGIF(BuildContext context) async {
  GiphyGif? gif;
  try {
    gif = await Giphy.getGif(
      context: context,
      apiKey: 'QMJvN6ijsJu4QZS45rLuQKqPTINtgmSg',
    );
  } catch (e) {
    Get.snackbar(
      'Oops',
      e.toString(),
      backgroundColor: AppColors.red,
    );
  }
  return gif;
}
