import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:custom_utils/log_utils.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:password_manager/app/core/theme/app_theme.dart';
import 'package:password_manager/app/core/theme/color_theme.dart';
import 'package:password_manager/app/core/utils/helpers.dart';
import 'package:password_manager/app/data/models/password_model.dart';
import 'package:password_manager/app/data/services/database_service/database_service.dart';
import 'package:password_manager/app/global_widgets/buttons.dart';
import 'package:password_manager/app/modules/home/controllers/home_controller.dart';

class PasswordInfoController extends GetxController {
  late Password password;

  late final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late final TextEditingController websiteController = TextEditingController();
  late final TextEditingController emailController = TextEditingController();
  late final TextEditingController passController = TextEditingController();
  late final TextEditingController notesController = TextEditingController();

  late final FocusNode focusNode = FocusNode();
  final _isPasswordHidden = true.obs;

  final Rx<int?> _selectedIndex = Rx<int?>(null);

  int? get selectedIndex => _selectedIndex.value;

  @override
  void onInit() {
    initControllers();
    super.onInit();
  }

  void changeLogo(int p1) {
    _selectedIndex.value = p1;
  }

  void initControllers() {
    final cont = Get.find<HomeController>();
    password = cont.passwords[cont.index];
    emailController.text = password.email!;
    passController.text = password.password!;
    notesController.text = password.notes!;
    websiteController.text = password.website!;
  }

  void deletePass() async {
    focusNode.unfocus();
    final deleteSelected = await Get.dialog(
      AlertDialog(
        title: Text("Confirm"),
        content: Text("Are You Sure Want To Delete?"),
        shape: RoundedRectangleBorder(borderRadius: BorderTheme.borderRadM),
        actions: [
          _Button(
              heading: 'No',
              color: Colors.transparent,
              onTap: () => Get.back(result: false)),
          _Button(
            heading: 'Yes',
            color: Vx.red700,
            onTap: () => Get.back(result: true),
          ),
        ],
      ),
    );
    if (!deleteSelected) return;
    bool deleteSuccessfull = false;

    deleteSuccessfull = await Get.showOverlay(
      asyncFunction: _deletePass,
      loadingWidget: SpinKitThreeBounce(color: ColorTheme.primaryColor),
    );

    if (deleteSuccessfull) {
      Get.back(result: true);
      successSnackbar("Password Deleted Succesfully!!");
    } else {
      errorSnackbar("Error In Deleting Password");
    }
  }

  Future<bool> _deletePass() async {
    try {
      final service = Get.find<DatabaseService>();
      await service.connection.deletePass(password);
      return true;
    } on Exception catch (e, s) {
      customLog("Error Deleting Pass", name: "Error", error: e, stackTrace: s);
      return false;
    }
  }
}

class _Button extends StatelessWidget {
  final VoidCallback onTap;
  final Color color;
  final String heading;

  const _Button({
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
