// To parse this JSON data, do
//
//     final transactionModel = transactionModelFromJson(jsonString);

import 'dart:convert';

TransactionModel transactionModelFromJson(String str) => TransactionModel.fromJson(json.decode(str));

String transactionModelToJson(TransactionModel data) => json.encode(data.toJson());

class TransactionModel {
  TransactionModel({
    this.ok,
    this.message,
    this.data,
  });

  bool? ok;
  String? message;
  Data? data;

  factory TransactionModel.fromJson(Map<String, dynamic> json) => TransactionModel(
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
    this.walletInfo,
    this.checkOutInfo,
    this.transData,
  });

  WalletInfo? walletInfo;
  CheckOutInfo? checkOutInfo;
  TransData? transData;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    walletInfo: WalletInfo.fromJson(json["walletInfo"]),
    checkOutInfo: CheckOutInfo.fromJson(json["checkOutInfo"]),
    transData: TransData.fromJson(json["transData"]),
  );

  Map<String, dynamic> toJson() => {
    "walletInfo": walletInfo!.toJson(),
    "checkOutInfo": checkOutInfo!.toJson(),
    "transData": transData!.toJson(),
  };
}

class CheckOutInfo {
  CheckOutInfo({
    this.amount,
    this.amountFormat,
  });

  int? amount;
  String? amountFormat;

  factory CheckOutInfo.fromJson(Map<String, dynamic> json) => CheckOutInfo(
    amount: json["amount"],
    amountFormat: json["amountFormat"],
  );

  Map<String, dynamic> toJson() => {
    "amount": amount,
    "amountFormat": amountFormat,
  };
}

class TransData {
  TransData({
    this.trans,
    this.totalDocs,
    this.totalPages,
    this.page,
    this.hasNextPage,
    this.hasPrevPage,
  });

  List<Tran>? trans;
  int? totalDocs;
  int? totalPages;
  int? page;
  bool? hasNextPage;
  bool? hasPrevPage;

  factory TransData.fromJson(Map<String, dynamic> json) => TransData(
    trans: List<Tran>.from(json["trans"].map((x) => Tran.fromJson(x))),
    totalDocs: json["totalDocs"],
    totalPages: json["totalPages"],
    page: json["page"],
    hasNextPage: json["hasNextPage"],
    hasPrevPage: json["hasPrevPage"],
  );

  Map<String, dynamic> toJson() => {
    "trans": List<dynamic>.from(trans!.map((x) => x.toJson())),
    "totalDocs": totalDocs,
    "totalPages": totalPages,
    "page": page,
    "hasNextPage": hasNextPage,
    "hasPrevPage": hasPrevPage,
  };
}

class Tran {
  Tran({
    this.id,
    this.transactionDate,
    this.type,
    this.typeTitle,
    this.status,
    this.statusTitle,
    this.trackId,
    this.amount,
    this.amountFormat,
    this.description,
  });

  String? id;
  String? transactionDate;
  String? type;
  String? typeTitle;
  String? status;
  String? statusTitle;
  String? trackId;
  String? amount;
  String? amountFormat;
  String? description;

  factory Tran.fromJson(Map<String, dynamic> json) => Tran(
    id: json["_id"],
    transactionDate: json["transactionDate"],
    type: json["type"],
    typeTitle: json["typeTitle"],
    status: json["status"],
    statusTitle: json["statusTitle"],
    trackId: json["trackId"],
    amount: json["amount"],
    amountFormat: json["amountFormat"],
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "transactionDate": transactionDate,
    "type": type,
    "typeTitle": typeTitle,
    "status": status,
    "statusTitle": statusTitle,
    "trackId": trackId,
    "amount": amount,
    "amountFormat": amountFormat,
    "description": description,
  };
}

class WalletInfo {
  WalletInfo({
    this.balance,
    this.formattedBalance,
  });

  int? balance;
  String? formattedBalance;

  factory WalletInfo.fromJson(Map<String, dynamic> json) => WalletInfo(
    balance: json["balance"],
    formattedBalance: json["formattedBalance"],
  );

  Map<String, dynamic> toJson() => {
    "balance": balance,
    "formattedBalance": formattedBalance,
  };
}
