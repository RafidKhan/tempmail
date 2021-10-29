import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:temp_mail/CustomWidgets/custom_btn.dart';
import 'package:temp_mail/Repositories/api_methods.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = new TextEditingController();
  TextEditingController passController = new TextEditingController();

  final apiCall = Get.put(ApiCall());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  style: TextStyle(
                      fontSize: Get.width / 30, color: Colors.black),
                  decoration: InputDecoration(
                      icon: Icon(
                        Icons.person,
                        color: Colors.black,
                      ),
                      hintStyle: TextStyle(
                          fontSize: Get.width / 40, color: Colors.black),
                      hintText: ("Enter Email"),
                      labelStyle: TextStyle(
                          fontSize: Get.width / 40, color: Colors.black),
                      labelText: ("Email")),
                ),
                SizedBox(
                  height: Get.height / 20,
                ),
                TextFormField(
                  obscureText: true,
                  controller: passController,
                  style: TextStyle(
                      fontSize: Get.width / 30, color: Colors.black),
                  decoration: InputDecoration(
                      icon: Icon(
                        Icons.lock,
                        color: Colors.black,
                      ),
                      hintStyle: TextStyle(
                          fontSize: Get.width / 40, color: Colors.black),
                      hintText: ("Enter Password"),
                      labelStyle: TextStyle(
                          fontSize: Get.width / 40, color: Colors.black),
                      labelText: ("Pasword")),
                ),
                SizedBox(
                  height: Get.height / 20,
                ),
                GestureDetector(
                    onTap: () => login(),
                    child: CustomButton(
                      btnText: "Login",
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
  login()async{
    if(emailController.text==''){
      Get.snackbar("Plase Enter Email", "");
    }
    else if(passController.text==''){
      Get.snackbar("Plase Enter Password", "");
    }
    else{
      print("Login");
      apiCall.login(email: emailController.text.trim(),password: passController.text.trim());
    }
  }
}
