import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:temp_mail/CustomWidgets/custom_btn.dart';
import 'package:temp_mail/Repositories/api_methods.dart';
import 'package:temp_mail/Repositories/appRoutes.dart';
import 'package:temp_mail/Variables/login_data.dart';
import 'package:temp_mail/Variables/login_loader.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  TextEditingController emailController = new TextEditingController();
  TextEditingController passController = new TextEditingController();

  final apiCall = Get.put(ApiCall());
  final loginData = Get.put(LoginData());

  appClose() {
    SystemNavigator.pop();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => appClose(),
      child: Scaffold(
        backgroundColor: Colors.white,
        bottomNavigationBar: Container(
          width: Get.width,
          height: Get.height/15,
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Do not have an account? "),
                GestureDetector(
                  onTap: (){
                    Get.toNamed(AppRoutes.CREATEACCOUNT);
                  },
                  child: Text("Create Account!",style: TextStyle(
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                  ),),
                ),
              ],
            ),
          ),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Login",style: TextStyle(
                    fontSize: Get.width/12,
                    color: Colors.black,
                    fontWeight: FontWeight.w400
                  ),),
                  Text("Please login to continue",style: TextStyle(
                      fontSize: Get.width/30,
                      color: Colors.black,
                      fontWeight: FontWeight.w300
                  ),),
                  SizedBox(height: Get.height/40,),
                  Container(
                    // decoration: BoxDecoration(
                    //   border: Border.all(color: Colors.black),
                    //   borderRadius: BorderRadius.circular(10),
                    //   //color: Colors.yellow
                    // ),
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            TextFormField(
                              controller: emailController,
                              keyboardType: TextInputType.emailAddress,

                              style: TextStyle(
                                  fontSize: Get.width / 30, color: Colors.black),
                              decoration: InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black),
                                  ),
                                  icon: Icon(
                                    Icons.email,
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
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black),
                                  ),
                                  icon: Icon(
                                    Icons.lock,
                                    color: Colors.black,
                                  ),
                                  hintStyle: TextStyle(
                                      fontSize: Get.width / 40, color: Colors.black),
                                  hintText: ("Enter Password"),
                                  labelStyle: TextStyle(
                                      fontSize: Get.width / 40, color: Colors.black),
                                  labelText: ("Password")),
                            ),
                            // SizedBox(
                            //   height: Get.height / 20,
                            // ),
                            // LoginLoader.loaderStatus == false
                            //     ? Align(
                            //   alignment: Alignment.topRight,
                            //       child: GestureDetector(
                            //           onTap: () => login(),
                            //           child: CustomButton(
                            //             btnText: "Login",
                            //           )),
                            //     )
                            //     : SpinKitWanderingCubes(
                            //   color: Colors.black,
                            //   size: Get.width/10,
                            // )
                          ],

                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: Get.height/20,),
                  LoginLoader.loaderStatus == false
                      ? Align(
                    alignment: Alignment.topRight,
                    child: GestureDetector(
                        onTap: () => login(),
                        child: CustomButton(
                          btnText: "Login",
                        )),
                  )
                      : SpinKitWanderingCubes(
                    color: Colors.black,
                    size: Get.width/10,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  login() async {
    setState(() {
      LoginLoader.loaderStatus = true;
    });
    if (emailController.text == '') {
      Get.snackbar("Please Enter Email", "");
      setState(() {
        LoginLoader.loaderStatus = false;
      });
    } else if (passController.text == '') {
      Get.snackbar("Please Enter Password", "");
      setState(() {
        LoginLoader.loaderStatus = false;
      });
    } else {
      print("Login");
      await apiCall.login(
          email: emailController.text.trim(),
          password: passController.text.trim());
      setState(() {
        LoginLoader.loaderStatus = false;
      });
    }
  }
}
