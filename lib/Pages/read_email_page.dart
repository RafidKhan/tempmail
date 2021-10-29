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
                  child: Text(
                    "${emailData.subject}",
                    style: TextStyle(
                        fontSize: Get.width / 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  )),
              SizedBox(
                height: Get.height / 30,
              ),
              Container(
                  width: Get.width,
                  child: Text(
                    "${emailData.name}",
                    style: TextStyle(
                        fontSize: Get.width / 30, fontWeight: FontWeight.w400),
                  )),
              Container(
                  width: Get.width,
                  child: Text(
                    "${emailData.email}",
                    style: TextStyle(
                        fontSize: Get.width / 30,
                        fontWeight: FontWeight.w400,
                        color: Colors.blue[800]),
                  )),
              Container(
                width: Get.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "${emailData.date}",
                      style: TextStyle(color: Colors.blue[800]),
                    ),
                    Text(
                      "${emailData.time}",
                      style: TextStyle(color: Colors.blue[800]),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: Get.height / 10,
              ),
              Container(
                  width: Get.width,
                  child: Text(
                    "${emailData.body}",
                    style: TextStyle(fontSize: Get.width / 20),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
