import 'package:get/get.dart';
import 'package:temp_mail/Pages/create_account.dart';
import 'package:temp_mail/Pages/dashboard.dart';
import 'package:temp_mail/Pages/login_page.dart';
import 'package:temp_mail/Pages/splash_page.dart';

class AppRoutes {
  static String INITIAL = "/";
  static String CREATEACCOUNT = "/CreateAccount";
  static String LOGIN = "/Login";
  static String DASHBAORD = "/DashBoard";

  static List<GetPage> routes = [
    GetPage(
      name: INITIAL,
      page: () => SplashPage(),
    ),
    GetPage(
      name: CREATEACCOUNT,
      page: () => CreateAccount(),
    ),
    GetPage(
      name: LOGIN,
      page: () => LoginPage(),
    ),
    GetPage(
      name: DASHBAORD,
      page: () => DashBoard(),
    ),
  ];
}
