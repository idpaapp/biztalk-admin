// To parse this JSON data, do
//
//     final notVerifyAccountModel = notVerifyAccountModelFromJson(jsonString);

import 'dart:convert';

NotVerifyAccountModel notVerifyAccountModelFromJson(String str) => NotVerifyAccountModel.fromJson(json.decode(str));

String notVerifyAccountModelToJson(NotVerifyAccountModel data) => json.encode(data.toJson());

class NotVerifyAccountModel {
  NotVerifyAccountModel({
    this.ok,
    this.message,
    this.data,
  });

  bool? ok;
  String? message;
  Data? data;

  factory NotVerifyAccountModel.fromJson(Map<String, dynamic> json) => NotVerifyAccountModel(
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
    this.accountData,
    this.totalDocs,
    this.totalPages,
    this.page,
    this.hasNextPage,
    this.hasPrevPage,
  });

  List<AccountDatum>? accountData;
  int? totalDocs;
  int? totalPages;
  int? page;
  bool? hasNextPage;
  bool? hasPrevPage;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    accountData: List<AccountDatum>.from(json["accountData"].map((x) => AccountDatum.fromJson(x))),
    totalDocs: json["totalDocs"],
    totalPages: json["totalPages"],
    page: json["page"],
    hasNextPage: json["hasNextPage"],
    hasPrevPage: json["hasPrevPage"],
  );

  Map<String, dynamic> toJson() => {
    "accountData": List<dynamic>.from(accountData!.map((x) => x.toJson())),
    "totalDocs": totalDocs,
    "totalPages": totalPages,
    "page": page,
    "hasNextPage": hasNextPage,
    "hasPrevPage": hasPrevPage,
  };
}

class AccountDatum {
  AccountDatum({
    this.userId,
    this.fullName,
    this.userType,
    this.userName,
    this.phone,
    this.iban,
    this.bank,
    this.verified,
    this.verifiedTitle,
    this.profileImageUrl,
    this.nameInBank
  });

  String? userId;
  String? fullName;
  String? userType;
  String? userName;
  String? nameInBank;
  String? profileImageUrl;
  String? phone;
  String? iban;
  Bank? bank;
  bool? verified;
  String? verifiedTitle;

  factory AccountDatum.fromJson(Map<String, dynamic> json) => AccountDatum(
    userId: json["userId"],
    nameInBank: json["nameInBank"],
    profileImageUrl: json["profileImageUrl"],
    fullName: json["fullName"],
    userType: json["userType"],
    userName: json["userName"],
    phone: json["phone"],
    iban: json["IBAN"],
    bank: Bank.fromJson(json["bank"]),
    verified: json["verified"],
    verifiedTitle: json["verifiedTitle"],
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "nameInBank": nameInBank,
    "fullName": fullName,
    "userType": userType,
    "userName": userName,
    "profileImageUrl": profileImageUrl,
    "phone": phone,
    "IBAN": iban,
    "bank": bank!.toJson(),
    "verified": verified,
    "verifiedTitle": verifiedTitle,
  };
}

class Bank {
  Bank({
    this.name,
    this.logo,
  });

  String? name;
  String? logo;

  factory Bank.fromJson(Map<String, dynamic> json) => Bank(
    name: json["name"],
    logo: json["logo"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "logo": logo,
  };
}
