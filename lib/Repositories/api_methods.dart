import 'dart:convert';
import 'package:temp_mail/Repositories/appRoutes.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:temp_mail/Repositories/SharedPreference.dart';
import 'package:temp_mail/Variables/account_create_data.dart';
import 'package:temp_mail/Variables/create_acc_loader.dart';
import 'package:temp_mail/Variables/domain_data.dart';
import 'package:temp_mail/Variables/login_data.dart';
import 'package:temp_mail/Variables/login_loader.dart';

class ApiCall {
  final domainData = Get.put(DomainData());
  final accountCreate = Get.put(AccountCreate());
  final loginData = Get.put(LoginData());

  String base_url = "https://api.mail.tm/";

  List msgFrom = [];
  List msgSubject = [];
  List msgId = [];
  List msgTime = [];
  List msgBody = [];
  List msgEmail = [];

  var headers = {
    'accept': 'application/json',
    'Content-Type': 'application/json'
  };

  Future<dynamic> getDomains() async {
    final response = await http.get(Uri.parse(base_url + 'domains'));

    var responseData = json.decode(response.body);

    if (response.statusCode == 200) {
      print(response.body);

      // print({responseData['hydra:member']}.length);

      for (int i = 0; i < responseData['hydra:totalItems']; i++) {
        print(responseData['hydra:member'][i]['domain']);
        if (!domainData.domain
            .contains(responseData['hydra:member'][i]['domain'])) {
          domainData.domain.add(responseData['hydra:member'][i]['domain']);
        }
      }
      // print(responseData['hydra:member'][0]['domain']);
      print("Domain: " + domainData.domain.toString());
    } else {
      print(response.reasonPhrase);
      print(response.statusCode);
    }
  }

  createAccount({email, password}) async {
    CreateAccountLoader.loader = true;
    print(email + '     ' + password);
    var request = http.Request('POST', Uri.parse(base_url + "accounts"));
    request.body = json.encode({"address": email, "password": password});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 201) {
      print(await response.stream.bytesToString());
      Get.snackbar("Account Created Succesfully", email);
      Get.toNamed(AppRoutes.LOGIN);
      CreateAccountLoader.loader = false;
    } else if (response.statusCode == 422) {
      print(response.reasonPhrase);
      CreateAccountLoader.loader = false;
      Get.snackbar("This email is already taken", email);
      CreateAccountLoader.loader = false;
    } else {
      print(response.reasonPhrase);
      CreateAccountLoader.loader = false;
      Get.snackbar("Something Went Wrong", email);
    }
  }

  login({email, password}) async {
    Map data = {'address': email, 'password': password};
    print(data.toString());
    final response = await http.post(
      Uri.parse(base_url + 'token'),
      headers: {
        'accept': 'application/json',
        'Content-Type': 'application/json'
      },
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> resposne = await jsonDecode(response.body);
      Map<String, dynamic> logindata = await resposne;
      print("Token::: ${logindata['token']}");
      print("ID::: ${logindata['id']}");
      await SharedPreff.to.prefss!
          .setString("SP_Token", "${logindata['token']}");
      await SharedPreff.to.prefss!.setString("SP_ID", "${logindata['id']}");
      await SharedPreff.to.prefss!.setBool("Login_Status", true);
      await SharedPreff.to.prefss!.setString("Email", "$email");

      loginData.token = await SharedPreff.to.prefss!.getString("SP_Token");
      loginData.id = await SharedPreff.to.prefss!.getString("SP_ID");
      loginData.email = await SharedPreff.to.prefss!.getString("Email");

      Get.toNamed(AppRoutes.DASHBAORD);
      LoginLoader.loaderStatus = false;
    } else if (response.statusCode == 401) {
      LoginLoader.loaderStatus = false;
      Get.snackbar("Please Check Email and Password", '');

    } else {
      print(response.statusCode);
      print(response.reasonPhrase);
      Get.snackbar("Something Went Wrong", '');
      LoginLoader.loaderStatus = false;
    }
  }

  Future<dynamic> getEmails({token}) async {
    var header = {'Authorization': 'Bearer $token'};

    final response =
        await http.get(Uri.parse(base_url + 'messages'), headers: header);

    var responseData = json.decode(response.body);

    if (response.statusCode == 200) {
      print('Items: ' + responseData['hydra:totalItems'].toString());

      for (int i = 0; i < responseData['hydra:totalItems']; i++) {
        print("From: " +
            responseData['hydra:member'][i]['from']['name'].toString());
        print("To: " + responseData['hydra:member'][i]['to'].toString());
        print("Subject: " +
            responseData['hydra:member'][i]['subject'].toString());
        print("Intro: " + responseData['hydra:member'][i]['intro'].toString());
        print("MSG ID: " + responseData["hydra:member"][i]['msgid'].toString());
        print("******");

        msgFrom.add(await responseData['hydra:member'][i]['from']['name']);
        msgSubject.add(await responseData['hydra:member'][i]['subject']);
        msgTime.add(await responseData['hydra:member'][i]['createdAt']);
        msgBody.add(await responseData['hydra:member'][i]['intro']);
        msgEmail.add(await responseData['hydra:member'][i]['from']['address']);

      }

      print("Print List: " + msgFrom.toString());
    } else {
      print(response.reasonPhrase);
      print(response.statusCode);
    }
  }
}
