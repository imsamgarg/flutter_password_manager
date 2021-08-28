import 'package:get/get.dart';

import 'package:password_manager/app/modules/add_password/bindings/add_password_binding.dart';
import 'package:password_manager/app/modules/add_password/views/add_password_view.dart';
import 'package:password_manager/app/modules/backup_restore/bindings/backup_restore_binding.dart';
import 'package:password_manager/app/modules/backup_restore/views/backup_restore_view.dart';
import 'package:password_manager/app/modules/home/bindings/home_binding.dart';
import 'package:password_manager/app/modules/home/views/home_view.dart';
import 'package:password_manager/app/modules/login/bindings/login_binding.dart';
import 'package:password_manager/app/modules/login/views/login_view.dart';
import 'package:password_manager/app/modules/password_info/bindings/password_info_binding.dart';
import 'package:password_manager/app/modules/password_info/views/password_info_view.dart';
import 'package:password_manager/app/modules/register/bindings/register_binding.dart';
import 'package:password_manager/app/modules/register/views/register_view.dart';
import 'package:password_manager/app/modules/settings/bindings/settings_binding.dart';
import 'package:password_manager/app/modules/settings/views/settings_view.dart';
import 'package:password_manager/app/modules/startup/bindings/startup_binding.dart';
import 'package:password_manager/app/modules/startup/views/startup_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.REGISTER;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.STARTUP,
      page: () => StartupView(),
      binding: StartupBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.ADD_PASSWORD,
      page: () => AddPasswordView(),
      binding: AddPasswordBinding(),
    ),
    GetPage(
      name: _Paths.PASSWORD_INFO,
      page: () => PasswordInfoView(),
      binding: PasswordInfoBinding(),
    ),
    GetPage(
      name: _Paths.SETTINGS,
      page: () => SettingsView(),
      binding: SettingsBinding(),
    ),
    GetPage(
      name: _Paths.BACKUP_RESTORE,
      page: () => BackupRestoreView(),
      binding: BackupRestoreBinding(),
    ),
  ];
}
