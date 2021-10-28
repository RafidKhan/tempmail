import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:temp_mail/Variables/account_create_data.dart';
import 'package:temp_mail/Variables/domain_data.dart';

class ApiCall {
  final domainData = Get.put(DomainData());
  final accountCreate = Get.put(AccountCreate());

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
}
