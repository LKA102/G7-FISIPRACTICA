import 'package:flutter_app/app/modules/admin/home_admin_screen.dart';
import 'package:flutter_app/app/modules/auth/bindings/auth_binding.dart';
import 'package:flutter_app/app/modules/auth/views/login/login_screen.dart';
import 'package:flutter_app/app/modules/auth/views/pick_user/pick_user_screen.dart';
import 'package:flutter_app/app/modules/root_screen.dart';
import 'package:get/get.dart';


class AppRoutes {

  // route names
  static String root = '/';
  static String pickUser = '/pick_user';
  static String login = '/login';
  static String adminHomePage = '/admin_login';

  // get routes
  static String getRootPage() => root;
  static String getPickUserPage() => pickUser;
  static String getLoginPage() => login;
  static String getAdminHomePage() => adminHomePage;

  // List of routes
  static List<GetPage> routes = [
    GetPage(
      page: () => const RootScreen(),
      name: root,
    ),
    GetPage(
      page: () => const PickUserScreen(),
      name: pickUser,
      binding: AuthBinding()
    ),
    GetPage(
      page: () => const LoginScreen(),
      name: login,
      binding: AuthBinding()
    ),
    GetPage(
      page: () => const HomeAdminScreen(),
      name: adminHomePage,
    )
  ];

}
