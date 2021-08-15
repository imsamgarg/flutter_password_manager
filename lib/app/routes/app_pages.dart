import 'package:get/get.dart';

import 'package:password_manager/app/modules/add_password/bindings/add_password_binding.dart';
import 'package:password_manager/app/modules/add_password/views/add_password_view.dart';
import 'package:password_manager/app/modules/home/bindings/home_binding.dart';
import 'package:password_manager/app/modules/home/views/home_view.dart';
import 'package:password_manager/app/modules/login/bindings/login_binding.dart';
import 'package:password_manager/app/modules/login/views/login_view.dart';
import 'package:password_manager/app/modules/register/bindings/register_binding.dart';
import 'package:password_manager/app/modules/register/views/register_view.dart';
import 'package:password_manager/app/modules/startup/bindings/startup_binding.dart';
import 'package:password_manager/app/modules/startup/views/startup_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.STARTUP;

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
  ];
}
