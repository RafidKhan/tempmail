import 'dart:convert';
import 'package:temp_mail/Repositories/appRoutes.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:temp_mail/Repositories/SharedPreference.dart';
import 'package:temp_mail/Variables/account_create_data.dart';
import 'package:temp_mail/Variables/domain_data.dart';
import 'package:temp_mail/Variables/login_data.dart';

class ApiCall {
  final domainData = Get.put(DomainData());
  final accountCreate = Get.put(AccountCreate());
  final loginData = Get.put(LoginData());

  String base_url = "https://api.mail.tm/";

  var headers = {
    'accept': 'application/json',
    'Content-Type': 'application/json'
  };

  Future<dynamic> getDomains() async {
    final response = await http.get(Uri.parse(base_url + 'domains'));

    var responseData = json.decode(response.body);

    if (response.statusCode == 200) {
      print(response.body);

      print({responseData['hydra:member']}.length);

      for (int i = 0; i < {responseData['hydra:member']}.length; i++) {
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
    print(email + '     ' + password);
    var request = http.Request('POST', Uri.parse(base_url + "accounts"));
    request.body = json.encode({"address": email, "password": password});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 201) {
      print(await response.stream.bytesToString());
      Get.snackbar("Account Created Succesfully", email);
    } else {
      print(response.reasonPhrase);
      Get.snackbar("Something Went Wrong", email);
    }
  }

  // login({email, password}) async {
  //   var response = await http.post(Uri.parse(base_url + "token"),
  //       headers: headers, body: {"address": email, "password": password});
  //   if (response.statusCode == 200) {
  //     var result = json.decode(response.body);
  //     print("$result");
  //
  //     var token = result['token'];
  //     print("$token");
  //   }else{
  //     print("PROBLEM");
  //   }
  // }

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

      loginData.token = await SharedPreff.to.prefss!.getString("SP_Token");
      loginData.id = await SharedPreff.to.prefss!.getString("SP_ID");

      Get.toNamed(AppRoutes.DASHBAORD);
    } else {
      print(response.statusCode);
      print(response.reasonPhrase);
    }
  }
}
