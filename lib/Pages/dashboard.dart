import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:temp_mail/Variables/login_data.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {

  final loginData = Get.put(LoginData());
  @override
  Widget build(BuildContext context) {
    print("Token: "+loginData.token.toString());
    print("Id: "+loginData.id.toString());
    return Scaffold(
      backgroundColor: Colors.white,

      body: Container(
        width: Get.width,
        height: Get.height,
      ),
    );
  }
}
