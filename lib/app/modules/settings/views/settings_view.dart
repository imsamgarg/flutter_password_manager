import 'package:custom_utils/spacing_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:password_manager/app/core/theme/app_theme.dart';
import 'package:password_manager/app/global_widgets/app_bar.dart';
import 'package:velocity_x/velocity_x.dart';
import '../controllers/settings_controller.dart';

class SettingsView extends GetView<SettingsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(heading: "Settings"),
      body: Padding(
        padding: PaddingTheme.sidePaddingM,
        child: ListView(
          children: [
            verSpacing16,
            _CustomTile(
              onTap: controller.backupAndRestore,
              title: "Backup & Restore",
            ),
            _CustomTile(
              onTap: controller.changePassCode,
              title: "Change Pass Code",
            ),
            Obx(
              () => _CustomTile(
                onTap: () {},
                isOneLine: false,
                trailing: Switch(
                  value: controller.askForPassSwitch,
                  onChanged: controller.toggleAskForPassSwitch,
                ),
                title: "Ask For Password Every Time",
                subtitle: "Prompt For Password Each Time You Decrypt Password",
              ),
            ),
            _CustomTile(
              title: "Delete All Passwords",
              onTap: controller.deleteAllPasswords,
              trailing: Icon(
                Icons.delete,
                color: Vx.red400,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _CustomTile extends StatelessWidget {
  final Widget? trailing;
  final String? subtitle;
  final String title;
  final bool isOneLine;
  final VoidCallback? onTap;

  const _CustomTile({
    Key? key,
    this.trailing,
    this.subtitle,
    required this.title,
    this.onTap,
    this.isOneLine = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _trailing = trailing ??
        Icon(
          Icons.arrow_forward_ios_rounded,
          size: 18,
        );
    return ListTile(
      title: title.text.size(isOneLine ? 18 : 16).make(),
      isThreeLine: !isOneLine,
      subtitle: subtitle?.text.make(),
      contentPadding: const EdgeInsets.only(left: 10, top: 5, bottom: 5),
      trailing: SizedBox(height: 50, width: 50, child: _trailing),
      shape: RoundedRectangleBorder(borderRadius: BorderTheme.borderRadM),
      onTap: onTap,
    );
  }
}
