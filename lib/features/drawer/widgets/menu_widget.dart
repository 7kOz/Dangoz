import 'package:dangoz/base/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

class DrawerMenuWidget extends StatelessWidget {
  const DrawerMenuWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () => ZoomDrawer.of(context)!.toggle(),
        splashColor: Colors.transparent,
        splashFactory: NoSplash.splashFactory,
        child: Icon(
          Icons.menu,
          color: AppColors.navy,
        ));
  }
}
