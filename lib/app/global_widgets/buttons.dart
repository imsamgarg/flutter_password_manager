import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:password_manager/app/core/theme/app_theme.dart';
import 'package:password_manager/app/core/values/sizing.dart';
import 'package:velocity_x/velocity_x.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
    this.text, {
    this.onTap,
    this.onLongPress,
    this.padding,
    this.isLoading,
  });
  final VoidCallback? onTap;
  final EdgeInsets? padding;
  final VoidCallback? onLongPress;
  final String text;
  final bool? isLoading;

  @override
  Widget build(BuildContext context) {
    return Material(
      // color: Color(0xFF263238),
      color: Theme.of(context).buttonColor,
      borderRadius: BorderTheme.borderRadS,
      child: InkWell(
        borderRadius: BorderTheme.borderRadS,
        onTap: onTap,
        // highlightColor: Colors.blueGrey[700],
        // splashColor: Colors.blueGrey[300],
        splashFactory: InkSplash.splashFactory,
        onLongPress: onLongPress,
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
                : text.text.make(),
          ),
        ),
      ),
    );
  }
}
