import 'package:custom_utils/log_utils.dart';
import 'package:custom_utils/spacing_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:password_manager/app/core/theme/app_theme.dart';
import 'package:password_manager/app/core/theme/color_theme.dart';
import 'package:password_manager/app/core/values/assets.dart';
import 'package:password_manager/app/core/values/sizing.dart';
import 'package:password_manager/app/data/models/password_model.dart';
import 'package:password_manager/app/global_widgets/app_bar.dart';
import 'package:password_manager/app/global_widgets/widgets.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  final heading = "Passwords";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        heading: heading,
        leadingIcon: Icons.settings,
        leadingPress: controller.onSettingsTap,
        leadingTooltip: "Settings",
        trailingIcon: Icons.add_circle_outline_rounded,
        trailingPress: controller.onAddTap,
        trailingTooltip: "Add Password",
      ),
      body: GestureDetector(
        onTap: controller.unfocus,
        child: FutureBuilder<bool>(
          future: controller.instance,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: "Something Went Wrong".text.size(24).make(),
              );
            }
            if (snapshot.hasData) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2),
                child: GetBuilder(
                  init: controller,
                  builder: (_) {
                    if (controller.passwords.length == 0)
                      return Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              iconSize: 48,
                              onPressed: controller.onAddTap,
                              icon: Icon(
                                Icons.add_circle_outline_rounded,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                            verSpacing16,
                            "Add Password".text.size(20).make(),
                          ],
                        ),
                      );
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SearchWidget(),
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount: controller.passwords.length,
                            itemBuilder: (_, i) {
                              if (controller.passwords[i].isVisible) {
                                return PasswordTile(controller.passwords[i], i);
                              } else {
                                return SizedBox.shrink();
                              }
                            },
                          ),
                        ),
                      ],
                    );
                  },
                ),
              );
            } else
              return LoadingWidget();
          },
        ),
      ),
    );
  }
}

class SearchWidget extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: controller.searchText,
      focusNode: controller.focusNode,
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        filled: true,
        fillColor: ColorTheme.inputBorderColor.withOpacity(0.2),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderTheme.borderRadS,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderTheme.borderRadS,
        ),
        prefixIcon: Icon(
          Icons.search,
          color: ColorTheme.inputBorderFocusedColor,
        ),
      ),
    );
  }
}

class PasswordTile extends GetView<HomeController> {
  final Password password;
  final int index;

  const PasswordTile(this.password, this.index);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: controller,
      id: "Tile$index",
      builder: (_) {
        customLog("Tile Update $index");
        return ListTile(
          shape: RoundedRectangleBorder(borderRadius: BorderTheme.borderRadM),
          title: (password.website ?? " --- ").text.semiBold.make(),
          subtitle: (password.email ?? " --- ").text.sm.make(),
          leading: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: WebsiteImage(password.website, password.r),
          ),
          onTap: () => controller.onTilePress(index),
          contentPadding: EdgeInsets.zero,
          trailing: SizedBox(
            height: 50,
            width: 50,
            child: InkWell(
              borderRadius: BorderTheme.borderRadM,
              onTap: () => controller.copyPassword(index),
              child: Icon(Icons.copy),
            ).tooltip("Copy Password"),
          ),
        );
      },
    );
  }
}

class WebsiteImage extends StatelessWidget {
  const WebsiteImage(
    this.website,
    this.r,
  );

  final String? website;
  final String? r;

  @override
  Widget build(BuildContext context) {
    final type = r ?? "";
    final h = 50.0, w = 50.0;
    if (type.isNotEmpty && AssetsLogos.isLogoExist(type))
      return ClipRRect(
        borderRadius: BorderTheme.borderRadM,
        child: SizedBox(
          height: h,
          width: w,
          child: Image.asset(
            AssetsLogos.logos[type]!.path,
            fit: BoxFit.cover,
          ),
        ),
      );
    return SizedBox(
      height: h,
      width: w,
      child: Center(
        child: website![0].text.size(22).bold.capitalize.make(),
      )
          .box
          .color(ColorTheme.buttonColor)
          .withRounded(value: Sizing.radiusS)
          .make(),
    );
  }
}
