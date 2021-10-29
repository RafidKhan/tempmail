import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:temp_mail/Repositories/SharedPreference.dart';
import 'package:temp_mail/Repositories/api_methods.dart';
import 'package:temp_mail/Repositories/appRoutes.dart';
import 'package:temp_mail/Variables/login_data.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final apiCall = Get.put(ApiCall());
  final loginData = Get.put(LoginData());

  timerFunc() {
    Timer(Duration(seconds: 3), () {
      if (SharedPreff.to.prefss!.getBool("Login_Status") == true) {
        Get.toNamed(AppRoutes.DASHBAORD);
      } else {
        Get.toNamed(AppRoutes.LOGIN);
      }
    });
  }

  @override
  void initState() {
    loginData.token =  SharedPreff.to.prefss!.getString("SP_Token");
    loginData.id =  SharedPreff.to.prefss!.getString("SP_ID");
    loginData.email =  SharedPreff.to.prefss!.getString("Email");
    apiCall.getDomains();
    timerFunc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: Get.height,
        width: Get.width,
        child: Image.asset('assets/splash.jpeg', fit: BoxFit.fitHeight,),
      ),
    );
  }
}
