// To parse this JSON data, do
//
//     final homeInfoModel = homeInfoModelFromJson(jsonString);

import 'dart:convert';

HomeInfoModel homeInfoModelFromJson(String str) => HomeInfoModel.fromJson(json.decode(str));

String homeInfoModelToJson(HomeInfoModel data) => json.encode(data.toJson());

class HomeInfoModel {
  HomeInfoModel({
    this.ok,
    this.message,
    this.data,
  });

  bool? ok;
  String? message;
  Data? data;

  factory HomeInfoModel.fromJson(Map<String, dynamic> json) => HomeInfoModel(
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
    this.notVerifiedAccount,
    this.checkOutCount,
    this.reportCount,
    this.requestCount,
    this.sessionCount,
    this.tvCount,
    this.userCount,
    this.userChecking,
  });

  int? notVerifiedAccount;
  int? checkOutCount;
  int? reportCount;
  int? requestCount;
  int? sessionCount;
  int? tvCount;
  int? userCount;
  int? userChecking;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    notVerifiedAccount: json["notVerifiedAccount"],
    checkOutCount: json["checkOutCount"],
    reportCount: json["reportCount"],
    requestCount: json["requestCount"],
    sessionCount: json["sessionCount"],
    tvCount: json["tvCount"],
    userCount: json["userCount"],
    userChecking: json["userChecking"],

  );

  Map<String, dynamic> toJson() => {
    "notVerifiedAccount": notVerifiedAccount,
    "checkOutCount": checkOutCount,
    "reportCount": reportCount,
    "requestCount": requestCount,
    "sessionCount": sessionCount,
    "tvCount":tvCount,
    "userCount":userCount,
    "userChecking":userChecking
  };
}
