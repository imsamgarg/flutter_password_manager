import 'package:flutter/material.dart';

import 'package:velocity_x/velocity_x.dart';

class CustomAppBar extends AppBar {
  CustomAppBar({
    IconData? leadingIcon,
    VoidCallback? leadingPress,
    IconData? trailingIcon,
    VoidCallback? trailingPress,
    required String heading,
    PreferredSizeWidget? bottom,
  }) : super(
          leading: leadingIcon == null
              ? null
              : IconButton(
                  onPressed: leadingPress,
                  icon: Icon(leadingIcon),
                ),
          centerTitle: true,
          actions: [
            if (trailingIcon != null)
              IconButton(
                onPressed: trailingPress,
                icon: Icon(trailingIcon),
              )
          ],
          title: heading.text.make(),
          bottom: bottom,
        );
}
