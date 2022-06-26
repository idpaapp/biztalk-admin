// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  LoginModel({
    this.ok,
    this.message,
    this.data,
  });

  bool? ok;
  String? message;
  Data? data;

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
    ok: json["ok"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "ok": ok,
    "message": message,
    "data": data!.toJson(),
  };
}

class Data {
  Data({
    this.fullName,
    this.phone,
    this.token,
  });

  String? fullName;
  String? phone;
  String? token;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    fullName: json["fullName"],
    phone: json["phone"],
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "fullName": fullName,
    "phone": phone,
    "token": token,
  };
}
