import 'package:flutter/material.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:password_manager/app/core/theme/app_theme.dart';
import 'package:password_manager/app/core/theme/color_theme.dart';
import 'package:password_manager/app/core/values/assets.dart';

class LoadingWidget extends StatelessWidget {
  final double? size;
  final Color? color;
  const LoadingWidget({Key? key, this.size, this.color}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: SpinKitThreeBounce(
          color: color ?? Theme.of(context).primaryColor,
          size: size ?? 50,
        ),
      ),
    );
  }
}

typedef SelectLogoCallback = void Function(int);

class SelectLogo extends StatelessWidget {
  final int? index;
  final SelectLogoCallback onPress;

  const SelectLogo({Key? key, required this.index, required this.onPress})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        for (int i = 0; i < AssetsLogos.logoList.length; i++)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 6),
            child: ClipRRect(
              borderRadius: BorderTheme.borderRadM,
              child: SizedBox(
                height: 50,
                width: 50,
                child: Stack(
                  children: [
                    PlatformLogo(i: i),
                    if (index == i) Mask(),
                  ],
                ),
              ),
            ),
          ).onTap(() => onPress(i)),
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
