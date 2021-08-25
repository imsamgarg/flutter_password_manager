import 'package:flutter/material.dart';

import 'package:velocity_x/velocity_x.dart';

class CustomAppBar extends AppBar {
  CustomAppBar({
    IconData? leadingIcon,
    VoidCallback? leadingPress,
    String? leadingTooltip,
    IconData? trailingIcon,
    VoidCallback? trailingPress,
    String? trailingTooltip,
    required String heading,
    PreferredSizeWidget? bottom,
  }) : super(
          leading: leadingIcon == null
              ? null
              : IconButton(
                  onPressed: leadingPress,
                  icon: Icon(leadingIcon),
                  tooltip: leadingTooltip,
                ),
          centerTitle: true,
          actions: [
            if (trailingIcon != null)
              IconButton(
                onPressed: trailingPress,
                icon: Icon(trailingIcon),
                tooltip: trailingTooltip,
              )
          ],
          title: heading.text.make(),
          bottom: bottom,
        );
}
