import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:temp_mail/Repositories/api_methods.dart';
import 'package:temp_mail/Repositories/appRoutes.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final apiCall = Get.put(ApiCall());

  timerFunc() {
    Timer(Duration(seconds: 3), () {
      Get.toNamed(AppRoutes.LOGIN);
    });
  }

  @override
  void initState() {
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
        child: Center(
          child: Text("Splash"),
        ),
      ),
    );
  }
}
