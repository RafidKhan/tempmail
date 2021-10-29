import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:temp_mail/CustomWidgets/custom_btn.dart';
import 'package:temp_mail/Repositories/api_methods.dart';
import 'package:temp_mail/Variables/account_create_data.dart';
import 'package:temp_mail/Variables/domain_data.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({Key? key}) : super(key: key);

  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  TextEditingController emailController = new TextEditingController();
  TextEditingController passController = new TextEditingController();

  final apiCall = Get.put(ApiCall());

  final domainData = Get.put(DomainData());
  final accountCreate = Get.put(AccountCreate());

  String? initialDomain;

  setDomain() async {
    //initialDomain = await domainData.domain[0].toString();
  }

  @override
  void initState() {
    //setDomain();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
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
                            fontSize: Get.width / 30, color: Colors.black),
                        decoration: InputDecoration(
                            icon: Icon(
                              Icons.email_outlined,
                              color: Colors.black,
                            ),
                            hintStyle: TextStyle(
                                fontSize: Get.width / 40, color: Colors.black),
                            hintText: ("Enter Email"),
                            labelStyle: TextStyle(
                                fontSize: Get.width / 40, color: Colors.black),
                            labelText: ("Email")),
                      ),
                    ),
                    Container(
                      width: Get.width / 3,
                      child: DropdownButton<String>(
                        focusColor: Colors.white,
                        value: initialDomain,
                        //elevation: 5,
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
                  style:
                      TextStyle(fontSize: Get.width / 30, color: Colors.black),
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
                      labelText: ("Password")),
                ),
                SizedBox(
                  height: Get.height / 20,
                ),
                GestureDetector(
                    onTap: () => createAccount(),
                    child: CustomButton(
                      btnText: "Create Account",
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  createAccount() {
    if (emailController.text == '') {
      Get.snackbar("Plase Enter Email", "");
    } else if (passController.text == '') {
      Get.snackbar("Plase Enter Password", "");
    } else if (initialDomain == null) {
      Get.snackbar("Plase Select A Domain", "");
    } else {
      apiCall.createAccount(
          email: emailController.text.toString().trim() +
              "@" +
              initialDomain.toString().trim(),
          password: passController.text.trim());
    }
  }
}
