import 'package:dangoz/base/app_colors.dart';
import 'package:dangoz/features/drawer/screens/drawer_menu_screen.dart';
import 'package:dangoz/features/feed/screens/main_feed_screen.dart';
import 'package:dangoz/features/profile/screens/user_profile_screen.dart';
import 'package:dangoz/models/drawer_menu_item_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({Key? key}) : super(key: key);

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  DrawerMenuItemModel currentItem = MenuItems.feed;
  @override
  Widget build(BuildContext context) => ZoomDrawer(
        menuBackgroundColor: AppColors.white,
        style: DrawerStyle.defaultStyle,
        angle: -0,
        slideWidth: Get.width * 0.6,
        showShadow: true,
        shadowLayer1Color: AppColors.navy,
        shadowLayer2Color: AppColors.green,
        borderRadius: 40,
        mainScreen: getScreen(),
        menuScreen: Builder(builder: (context) {
          return DrawerMenuScreen(
            currentItem: currentItem,
            onSelectedItem: (item) {
              setState(() => currentItem = item);
              ZoomDrawer.of(context)!.close();
            },
          );
        }),
      );

  Widget getScreen() {
    switch (currentItem) {
      case MenuItems.feed:
        return MainFeedScreen();
      case MenuItems.profile:
        return UserProfileScreen();
      default:
        return Container();
    }
  }
}
