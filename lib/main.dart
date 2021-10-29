import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:temp_mail/Pages/create_account.dart';
import 'package:temp_mail/Pages/splash_page.dart';
import 'package:temp_mail/Repositories/SharedPreference.dart';
import 'package:temp_mail/Repositories/appRoutes.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreff.to.initial();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Temp Mail',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      getPages: AppRoutes.routes,
      initialRoute: AppRoutes.INITIAL,
      home: SplashPage(),
    );
  }
}
