// To parse this JSON data, do
//
//     final ibanInquiryModel = ibanInquiryModelFromJson(jsonString);

import 'dart:convert';

IbanInquiryModel ibanInquiryModelFromJson(String str) => IbanInquiryModel.fromJson(json.decode(str));

String ibanInquiryModelToJson(IbanInquiryModel data) => json.encode(data.toJson());

class IbanInquiryModel {
  IbanInquiryModel({
    this.result,
    this.message,
    this.data,
  });

  int? result;
  String? message;
  Data? data;

  factory IbanInquiryModel.fromJson(Map<String, dynamic> json) => IbanInquiryModel(
    result: json["result"] == null ? null : json["result"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "result": result == null ? null : result,
    "message": message == null ? null : message,
    "data": data == null ? null : data!.toJson(),
  };
}

class Data {
  Data({
    this.name,
    this.bankAccount,
    this.bankName,
    this.deposit,
    this.isTransferable,
  });

  String? name;
  String? bankAccount;
  String? bankName;
  String? deposit;
  bool? isTransferable;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    name: json["name"] == null ? null : json["name"],
    bankAccount: json["bankAccount"] == null ? null : json["bankAccount"],
    bankName: json["bankName"] == null ? null : json["bankName"],
    deposit: json["deposit"] == null ? null : json["deposit"],
    isTransferable: json["isTransferable"] == null ? null : json["isTransferable"],
  );

  Map<String, dynamic> toJson() => {
    "name": name == null ? null : name,
    "bankAccount": bankAccount == null ? null : bankAccount,
    "bankName": bankName == null ? null : bankName,
    "deposit": deposit == null ? null : deposit,
    "isTransferable": isTransferable == null ? null : isTransferable,
  };
}
