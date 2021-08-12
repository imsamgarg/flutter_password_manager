import 'package:flutter/material.dart';
import 'package:password_manager/app/core/theme/app_theme.dart';
import 'package:velocity_x/velocity_x.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
    this.text, {
    this.onTap,
    this.onLongPress,
    this.padding,
  });
  //  : super(key: key);
  final VoidCallback? onTap;
  final EdgeInsets? padding;
  final VoidCallback? onLongPress;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).buttonColor,
      borderRadius: BorderTheme.borderRadM,
      child: InkWell(
        borderRadius: BorderTheme.borderRadM,
        onTap: onTap,
        onLongPress: onLongPress,
        child: Padding(
          padding: padding ?? const EdgeInsets.all(8.0),
          child: Center(child: text.text.make()),
        ),
      ),
    );
  }
}
