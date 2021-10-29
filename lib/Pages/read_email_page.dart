import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:temp_mail/Repositories/appRoutes.dart';
import 'package:temp_mail/Variables/email_data.dart';

class ReadEmailPage extends StatefulWidget {
  const ReadEmailPage({Key? key}) : super(key: key);

  @override
  _ReadEmailPageState createState() => _ReadEmailPageState();
}

class _ReadEmailPageState extends State<ReadEmailPage> {
  final emailData = Get.put(EmailData());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Text(
          "${emailData.email}",
          style: TextStyle(color: Colors.black),
        ),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10.0, 50, 10.0, 10.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  width: Get.width,
                  child: Row(
                    children: [
                      Text(
                        "${emailData.subject}",
                        style: TextStyle(
                            fontSize: Get.width / 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      SizedBox(
                        width: Get.width / 60,
                      ),
                      Container(
                        width: Get.width / 4,
                        height: Get.height / 30,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.grey[300]),
                        child: Center(
                          child: Text(
                            "Subject",
                            style: TextStyle(
                                fontSize: Get.width / 30, color: Colors.black),
                          ),
                        ),
                      ),
                    ],
                  )),
              SizedBox(
                height: Get.height / 30,
              ),
              Container(
                width: Get.width,
                decoration: BoxDecoration(
                    color: Colors.blue[100],
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.black)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${emailData.name}",
                        style: TextStyle(
                            fontSize: Get.width / 30,
                            fontWeight: FontWeight.w400),
                      ),
                      Text(
                        "${emailData.email}",
                        style: TextStyle(
                            fontSize: Get.width / 30,
                            fontWeight: FontWeight.w400,
                            color: Colors.blue[800]),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: Get.height / 50,
              ),
              Container(
                width: Get.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "${emailData.date}",
                      style: TextStyle(
                        color: Colors.blue[800],
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    Text(
                      "${emailData.time}",
                      style: TextStyle(
                        color: Colors.blue[800],
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: Get.height / 40,
              ),
              Container(
                width: Get.width,
                height: Get.height / 2,
                // color: Colors.blue[100],
                // decoration: BoxDecoration(
                //     //color: Colors.blue[100],
                //     // border: Border.all(color: Colors.black),
                //     //borderRadius: BorderRadius.circular(20)
                //     ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(0),
                    child: Text(
                      "${emailData.body}",
                      style: TextStyle(fontSize: Get.width / 20),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: Get.height / 40,
              ),
              // Align(
              //   alignment: Alignment.topRight,
              //   child: Container(
              //     width: Get.width / 2.5,
              //     height: Get.height / 20,
              //     decoration: BoxDecoration(
              //         borderRadius: BorderRadius.circular(10),
              //         color: Colors.grey[300]),
              //     child: IconButton(
              //       onPressed: () {},
              //       icon: Icon(Icons.delete_forever),
              //     ),
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
