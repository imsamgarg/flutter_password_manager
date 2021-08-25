import 'package:flutter/material.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:password_manager/app/core/theme/app_theme.dart';
import 'package:password_manager/app/core/values/sizing.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
    this.text, {
    this.onTap,
    this.onLongPress,
    this.padding,
    this.isLoading,
    this.color,
    this.textColor,
  });
  final VoidCallback? onTap;
  final EdgeInsets? padding;
  final VoidCallback? onLongPress;
  final String text;
  final Color? color;
  final Color? textColor;
  final bool? isLoading;

  @override
  Widget build(BuildContext context) {
    return Material(
      // color: Color(0xFF263238),
      color: color ?? Theme.of(context).buttonColor,
      borderRadius: BorderTheme.borderRadS,
      child: InkWell(
        borderRadius: BorderTheme.borderRadS,
        onTap: onTap,
        // highlightColor: Colors.blueGrey[700],
        // splashColor: Colors.blueGrey[300],
        splashFactory: InkSplash.splashFactory,
        onLongPress: (isLoading ?? false) ? () {} : onLongPress,
        child: Padding(
          padding: padding ??
              const EdgeInsets.symmetric(
                vertical: Sizing.buttonPaddingVer,
              ),
          child: Center(
            child: (isLoading ?? false)
                ? SpinKitThreeBounce(
                    size: 18,
                    color: Vx.white,
                  )
                : text.text.color(textColor ?? Vx.white).make(),
          ),
        ),
      ),
    );
  }
}

class DialogButton extends StatelessWidget {
  final VoidCallback onTap;
  final Color color;
  final String heading;

  const DialogButton({
    Key? key,
    required this.onTap,
    required this.color,
    required this.heading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 80,
      height: 40,
      child: CustomButton(
        heading,
        padding: const EdgeInsets.all(0),
        color: color,
        onTap: onTap,
      ),
    );
  }
}
