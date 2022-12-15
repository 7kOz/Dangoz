import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class ProfileImage extends StatelessWidget {
  String imageUrl;
  ProfileImage({Key? key, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          SizedBox(
            child: Image.asset(
              'assets/images/dangozLogo.png',
              height: Get.height * 0.2,
            ),
          ),
          Positioned(
            left: Get.width * 0.1105,
            top: Get.height * 0.05,
            child: CircleAvatar(
              radius: Get.height * 0.05,
              backgroundImage: NetworkImage(imageUrl),
            ),
          ),
        ],
      ),
    );
  }
}
