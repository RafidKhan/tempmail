import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:temp_mail/CustomWidgets/custom_btn.dart';
import 'package:temp_mail/Repositories/api_methods.dart';
import 'package:temp_mail/Repositories/appRoutes.dart';
import 'package:temp_mail/Variables/account_create_data.dart';
import 'package:temp_mail/Variables/create_acc_loader.dart';
import 'package:temp_mail/Variables/domain_data.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({Key? key}) : super(key: key);

  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  TextEditingController emailController = new TextEditingController();
  TextEditingController passController = new TextEditingController();
  TextEditingController confirmPassController = new TextEditingController();

  final apiCall = Get.put(ApiCall());

  final domainData = Get.put(DomainData());
  final accountCreate = Get.put(AccountCreate());

  String? initialDomain;
  bool loaderStatus = false;

  @override
  void initState() {
    loaderStatus = false;
    super.initState();
  }

  getBack() {
    Get.toNamed(AppRoutes.LOGIN);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => getBack(),
      child: Scaffold(
        backgroundColor: Colors.white,
        bottomNavigationBar: Container(
          width: Get.width,
          height: Get.height / 15,
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Already a user? "),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(AppRoutes.LOGIN);
                  },
                  child: Text(
                    "Login!",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                    ),
                  ),
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
                  Text(
                    "Create Account",
                    style: TextStyle(
                        fontSize: Get.width / 12,
                        color: Colors.black,
                        fontWeight: FontWeight.w400),
                  ),
                  SizedBox(
                    height: Get.height / 40,
                  ),
                  Container(
                    // decoration: BoxDecoration(
                    //   border: Border.all(color: Colors.black),
                    //   borderRadius: BorderRadius.circular(10),
                    //   //color: Colors.yellow
                    // ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: Get.width / 2,
                                  child: TextFormField(
                                    controller: emailController,
                                    style: TextStyle(
                                        fontSize: Get.width / 30,
                                        color: Colors.black),
                                    decoration: InputDecoration(
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.black),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.black),
                                        ),
                                        icon: Icon(
                                          Icons.email,
                                          color: Colors.black,
                                        ),
                                        hintStyle: TextStyle(
                                            fontSize: Get.width / 40,
                                            color: Colors.black),
                                        hintText: ("Enter Email"),
                                        labelStyle: TextStyle(
                                            fontSize: Get.width / 40,
                                            color: Colors.black),
                                        labelText: ("Email")),
                                  ),
                                ),
                                Container(
                                  width: Get.width / 3,
                                  child: DropdownButton<String>(
                                    focusColor: Colors.white,
                                    value: initialDomain,
                                    elevation: 0,
                                    style: TextStyle(color: Colors.white),
                                    //iconEnabledColor:Colors.black,
                                    items: domainData.domain
                                        .map<DropdownMenuItem<String>>((value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(
                                          "@" + value,
                                          style: TextStyle(
                                              fontSize: Get.width / 35,
                                              color: Colors.black),
                                        ),
                                      );
                                    }).toList(),
                                    hint: Text(
                                      "Select A Domain",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: Get.width / 40,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    onChanged: (value) {
                                      setState(() {
                                        initialDomain = value;
                                      });
                                      print(initialDomain);
                                    },
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: Get.height / 20,
                            ),
                            TextFormField(
                              controller: passController,
                              obscureText: true,
                              style: TextStyle(
                                  fontSize: Get.width / 30,
                                  color: Colors.black),
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
                                      fontSize: Get.width / 40,
                                      color: Colors.black),
                                  hintText: ("Enter Password"),
                                  labelStyle: TextStyle(
                                      fontSize: Get.width / 40,
                                      color: Colors.black),
                                  labelText: ("Password")),
                            ),
                            SizedBox(
                              height: Get.height / 20,
                            ),
                            TextFormField(
                              controller: confirmPassController,
                              obscureText: true,
                              style: TextStyle(
                                  fontSize: Get.width / 30,
                                  color: Colors.black),
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
                                      fontSize: Get.width / 40,
                                      color: Colors.black),
                                  hintText: ("Confirm Password"),
                                  labelStyle: TextStyle(
                                      fontSize: Get.width / 40,
                                      color: Colors.black),
                                  labelText: ("Confirm Password")),
                            ),
                            // SizedBox(
                            //   height: Get.height / 20,
                            // ),
                            // CreateAccountLoader.loader == false
                            //     ? Align(
                            //   alignment: Alignment.topRight,
                            //       child: GestureDetector(
                            //           onTap: () => createAccount(),
                            //           child: CustomButton(
                            //             btnText: "Create Account",
                            //           )),
                            //     )
                            //     : SpinKitWanderingCubes(
                            //         color: Colors.black,
                            //         size: Get.width / 10,
                            //       )
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Get.height / 20,
                  ),
                  CreateAccountLoader.loader == false
                      ? Align(
                          alignment: Alignment.topRight,
                          child: GestureDetector(
                              onTap: () => createAccount(),
                              child: CustomButton(
                                btnText: "Create Account",
                              )),
                        )
                      : SpinKitWanderingCubes(
                          color: Colors.black,
                          size: Get.width / 10,
                        )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  createAccount() async {
    setState(() {
      CreateAccountLoader.loader = true;
    });
    if (emailController.text == '') {
      Get.snackbar("Please Enter Email", "");
      setState(() {
        CreateAccountLoader.loader = false;
      });
    } else if (passController.text == '') {
      Get.snackbar("Please Enter Password", "");
      setState(() {
        CreateAccountLoader.loader = false;
      });
    } else if (initialDomain == null) {
      Get.snackbar("Please Select A Domain", "");
      setState(() {
        CreateAccountLoader.loader = false;
      });
    } else if (confirmPassController.text.trim() !=
        passController.text.trim()) {
      Get.snackbar("Password Does Not Match", "");
      setState(() {
        CreateAccountLoader.loader = false;
      });
    } else {
      await apiCall.createAccount(
          email: emailController.text.toString().trim() +
              "@" +
              initialDomain.toString().trim(),
          password: passController.text.trim());
      setState(() {
        CreateAccountLoader.loader = false;
      });
    }
  }
}
