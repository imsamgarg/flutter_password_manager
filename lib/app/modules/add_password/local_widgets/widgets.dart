import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:password_manager/app/core/theme/app_theme.dart';
import 'package:password_manager/app/core/theme/color_theme.dart';
import 'package:password_manager/app/core/values/assets.dart';
import 'package:password_manager/app/modules/add_password/controllers/add_password_controller.dart';
import 'package:velocity_x/velocity_x.dart';

class SelectLogo extends GetView<AddPasswordController> {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        for (int i = 0; i < AssetsLogos.logoList.length; i++)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 6),
            child: Obx(
              () => ClipRRect(
                borderRadius: BorderTheme.borderRadM,
                child: SizedBox(
                  height: 50,
                  width: 50,
                  child: Stack(
                    children: [
                      PlatformLogo(i: i),
                      if (controller.selectedIndex == i) Mask(),
                    ],
                  ),
                ),
              ),
            ),
          ).onTap(() => controller.changeImage(i)),
      ],
    );
  }
}

class Mask extends StatelessWidget {
  const Mask({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorTheme.buttonColor.withOpacity(0.8),
      child: Center(
        child: Icon(
          Icons.check,
          size: 28,
        ),
      ),
    );
  }
}

class PlatformLogo extends StatelessWidget {
  const PlatformLogo({
    Key? key,
    required this.i,
  }) : super(key: key);

  final int i;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      AssetsLogos.logoList[i].path,
      fit: BoxFit.cover,
      height: 50,
      width: 50,
    );
  }
}
