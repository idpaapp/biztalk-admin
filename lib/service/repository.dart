import 'dart:convert';

import 'package:biztalk_panel_admin/failure/data_connection_checker.dart';
import 'package:get/get.dart';

import '../model/login/login_model.dart';
import '../resources/global_info.dart';
import '../resources/my_alert.dart';
import 'http_service.dart';

class Repository{


  //*********************** login
  static Future login(String number,String password) async {
    try {
      if (!await DataConnectionChecker.hasConnection) {
        return "1";
      } else {
        var response = await HttpServices.request(
            RequestType.post, '${GlobalInfo.baseURL}login',
            body: {
              "phone": number,
              "password":password
            },needAuth: false);
        print(response);
        if (response == null) {
          return null;
        } else if (response["ok"] == false ) {
          Get.back();
          MyAlert.mySnakbarRed(text: response["message"]);
          return;
        } else {
          var encode = jsonEncode(response);
          return loginModelFromJson(encode);
        }
      }
    } catch (e) {}
  }

}