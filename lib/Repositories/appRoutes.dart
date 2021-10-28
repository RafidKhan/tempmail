import 'package:get/get.dart';
import 'package:temp_mail/Pages/create_account.dart';
import 'package:temp_mail/Pages/splash_page.dart';

class AppRoutes {
  static String CREATEACCOUNT = "/CreateAccount";
  static String INITIAL = "/";


  static List<GetPage> routes = [
    GetPage(
      name: CREATEACCOUNT,
      page: () => CreateAccount(),
    ),
    GetPage(
      name: INITIAL,
      page: () => SplashPage(),
    ),

  ];
}
