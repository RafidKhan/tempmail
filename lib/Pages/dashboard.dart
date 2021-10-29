import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:temp_mail/Repositories/SharedPreference.dart';
import 'package:temp_mail/Repositories/api_methods.dart';
import 'package:temp_mail/Variables/email_data.dart';
import 'package:temp_mail/Variables/login_data.dart';
import 'package:temp_mail/Repositories/appRoutes.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  final loginData = Get.put(LoginData());
  final apiCall = Get.put(ApiCall());
  final emailData = Get.put(EmailData());

  logout() async {
    await SharedPreff.to.prefss!.setString("SP_Token", "NULL");
    await SharedPreff.to.prefss!.setString("SP_ID", "NULL");
    await SharedPreff.to.prefss!.setBool("Login_Status", false);
    // apiCall.msgFrom.clear();
    // apiCall.msgSubject.clear();
    // apiCall.msgTime.clear();
    // apiCall.msgBody.clear();
    // apiCall.msgEmail.clear();
    // apiCall.msgId.clear();
    clearList();

    Get.toNamed(AppRoutes.LOGIN);
  }

  appClose() {
    // apiCall.msgFrom.clear();
    // apiCall.msgSubject.clear();
    // apiCall.msgTime.clear();
    // apiCall.msgBody.clear();
    // apiCall.msgEmail.clear();
    // apiCall.msgId.clear();
    clearList();
    SystemNavigator.pop();
  }

  List name = [];
  List subject = [];
  List time = [];
  List email = [];
  List body = [];

  getEmailData() async {
    await apiCall.getEmails(token: loginData.token.toString().trim());
    setState(() {
      name = apiCall.msgFrom;
      subject = apiCall.msgSubject;
      time = apiCall.msgTime;
      email = apiCall.msgEmail;
      body = apiCall.msgBody;
    });
    print("Length of list: " + name.length.toString());
  }

  clearList() {
    apiCall.msgFrom.clear();
    apiCall.msgSubject.clear();
    apiCall.msgTime.clear();
    apiCall.msgBody.clear();
    apiCall.msgEmail.clear();
    apiCall.msgId.clear();
  }

  @override
  void initState() {
    getEmailData();
    name = [];
    subject = [];
    time = [];
    email = [];
    body = [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("Token: " + loginData.token.toString());
    print("Id: " + loginData.id.toString());
    print("Email: " + loginData.email.toString());
    return WillPopScope(
      onWillPop: () => appClose(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: Colors.white,
          title: Text(
            loginData.email.toString(),
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w300,
                fontSize: Get.width / 25),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  logout();
                },
                icon: Icon(
                  Icons.logout,
                  color: Colors.black,
                ))
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white,
          onPressed: () {
            clearList();
            Navigator.push(context,
                new MaterialPageRoute(builder: (context) => DashBoard()));
          },
          child: Icon(
            Icons.refresh,
            color: Colors.black,
          ),
        ),
        body: ListView.builder(
            shrinkWrap: true,
            primary: false,
            itemCount: name.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: GestureDetector(
                  onTap: () async {
                    emailData.name = await name[index].toString() == ''
                        ? 'Name Not Found'
                        : name[index].toString();
                    emailData.email = await email[index].toString() == ''
                        ? 'Email Not Found'
                        : email[index].toString();
                    emailData.subject = await subject[index].toString() == ''
                        ? 'No Subject'
                        : subject[index].toString();
                    emailData.body = await body[index].toString() == 'null'
                        ? 'Body Not Found'
                        : body[index].toString();
                    emailData.date = await DateFormat('dd/MM/yyy')
                        .format(DateTime.parse(time[index].toString()));
                    emailData.time = await DateFormat('kk:mm a')
                        .format(DateTime.parse(time[index].toString()));
                    Get.toNamed(AppRoutes.READEMAIL);
                  },
                  child: Container(
                    width: Get.width,
                    height: Get.height / 10,
                    decoration: BoxDecoration(
                        color: Colors.blue[700],
                        borderRadius: BorderRadius.circular(10)),
                    child: ListTile(
                      leading: Icon(
                        Icons.email,
                        color: Colors.white,
                      ),
                      title: Text(
                        name[index].toString(),
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        apiCall.msgSubject[index].toString() == ''
                            ? "No Subject"
                            : apiCall.msgSubject[index].toString(),
                        style: TextStyle(color: Colors.white),
                      ),
                      trailing: Column(
                        children: [
                          Text(
                            DateFormat('dd/MM/yyy')
                                .format(DateTime.parse(time[index].toString())),
                            style: TextStyle(color: Colors.white),
                          ),
                          SizedBox(
                            height: Get.height / 60,
                          ),
                          Text(
                            DateFormat('kk:mm a')
                                .format(DateTime.parse(time[index].toString())),
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
