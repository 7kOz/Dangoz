import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dangoz/base/app_colors.dart';
import 'package:dangoz/base/buttons.dart';
import 'package:dangoz/features/chat/repository/chat_repository.dart';
import 'package:dangoz/models/drawer_menu_item_model.dart';
import 'package:dangoz/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

class MenuItems {
  static const feed =
      DrawerMenuItemModel('Home', CupertinoIcons.dot_radiowaves_left_right);

  static const profile = DrawerMenuItemModel('Profile', Icons.person);

  static const allItems = <DrawerMenuItemModel>[
    feed,
    profile,
  ];
}

class DrawerMenuScreen extends ConsumerWidget {
  final DrawerMenuItemModel currentItem;
  final ValueChanged<DrawerMenuItemModel> onSelectedItem;
  const DrawerMenuScreen({
    Key? key,
    required this.currentItem,
    required this.onSelectedItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
          child: Container(
        height: Get.height * 0.85,
        width: Get.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StreamBuilder<UserModel>(
              stream: ref
                  .read(chatRepositoryProvider)
                  .userData(FirebaseAuth.instance.currentUser!.uid),
              builder: (context, snapshot) {
                if (snapshot.data == null) {
                  return Container();
                }
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 16,
                  ),
                  child: Column(
                    children: [
                      snapshot.data!.profileImage == ''
                          ? CircleAvatar(
                              radius: 50,
                              backgroundColor: AppColors.navy,
                              child: Center(
                                child: Icon(CupertinoIcons.person,
                                    color: AppColors.lightGrey,
                                    size: Get.width * 0.075),
                              ),
                            )
                          : CircleAvatar(
                              radius: 50,
                              backgroundImage: NetworkImage(
                                snapshot.data!.profileImage as String,
                              ),
                            ),
                      const SizedBox(height: 10),
                      snapshot.data!.userName == ''
                          ? Text(
                              'Setup Profile',
                              style: TextStyle(
                                color: AppColors.navy,
                                fontSize: Get.width * 0.03,
                              ),
                            )
                          : Text(
                              '@${snapshot.data!.userName}',
                              style: TextStyle(
                                color: AppColors.navy,
                                fontSize: Get.width * 0.03,
                              ),
                            ),
                    ],
                  ),
                );
              },
            ),
            SizedBox(
              height: Get.height * 0.025,
            ),
            ...MenuItems.allItems.map(buildMenuItem).toList(),
            Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: InkWell(
                onTap: () {
                  FirebaseAuth.instance.signOut();
                  print('Signed Out');
                },
                child: Buttons.primaryButton(
                    AppColors.red, AppColors.white, 'Sign Out'),
              ),
            ),
            SizedBox(height: Get.height * 0.1),
          ],
        ),
      )),
    );
  }

  Widget buildMenuItem(DrawerMenuItemModel item) => ListTile(
        selected: currentItem == item,
        selectedTileColor: Colors.transparent,
        minLeadingWidth: 20,
        leading: Icon(
          item.icon,
          color: AppColors.navy,
        ),
        title: Text(
          item.title,
          style: TextStyle(
            color: AppColors.navy,
            letterSpacing: 1,
            fontSize: Get.width * 0.04,
          ),
        ),
        onTap: () => onSelectedItem(item),
      );
}
