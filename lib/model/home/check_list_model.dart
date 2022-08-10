// To parse this JSON data, do
//
//     final checkListModel = checkListModelFromJson(jsonString);

import 'dart:convert';

CheckListModel checkListModelFromJson(String str) => CheckListModel.fromJson(json.decode(str));

String checkListModelToJson(CheckListModel data) => json.encode(data.toJson());

class CheckListModel {
  CheckListModel({
    this.ok,
    this.message,
    this.data,
  });

  bool? ok;
  String? message;
  Data? data;

  factory CheckListModel.fromJson(Map<String, dynamic> json) => CheckListModel(
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
    this.checkOut,
    this.totalDocs,
    this.totalPages,
    this.page,
    this.hasNextPage,
    this.hasPrevPage,
  });

  List<CheckOut>? checkOut;
  int? totalDocs;
  int? totalPages;
  int? page;
  bool? hasNextPage;
  bool? hasPrevPage;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    checkOut: List<CheckOut>.from(json["checkOut"].map((x) => CheckOut.fromJson(x))),
    totalDocs: json["totalDocs"],
    totalPages: json["totalPages"],
    page: json["page"],
    hasNextPage: json["hasNextPage"],
    hasPrevPage: json["hasPrevPage"],
  );

  Map<String, dynamic> toJson() => {
    "checkOut": List<dynamic>.from(checkOut!.map((x) => x.toJson())),
    "totalDocs": totalDocs,
    "totalPages": totalPages,
    "page": page,
    "hasNextPage": hasNextPage,
    "hasPrevPage": hasPrevPage,
  };
}

class CheckOut {
  CheckOut({
    this.id,
    this.fullName,
    this.walletBalance,
    this.checkOutPrice,
    this.checkOutPriceFormat,
    this.status,
    this.statusTitle,
    this.createdAt,
    this.userId,
  });

  String? id;
  String? fullName;
  String? walletBalance;
  String? checkOutPrice;
  String? checkOutPriceFormat;
  String? status;
  String? statusTitle;
  String? createdAt;
  String? userId;

  factory CheckOut.fromJson(Map<String, dynamic> json) => CheckOut(
    id: json["_id"],
    userId: json["userId"],
    fullName: json["fullName"],
    walletBalance: json["walletBalance"],
    checkOutPrice: json["checkOutPrice"],
    checkOutPriceFormat: json["checkOutPriceFormat"],
    status: json["status"],
    statusTitle: json["statusTitle"],
    createdAt: json["createdAt"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "userId": userId,
    "fullName": fullName,
    "walletBalance": walletBalance,
    "checkOutPrice": checkOutPrice,
    "checkOutPriceFormat": checkOutPriceFormat,
    "status": status,
    "statusTitle": statusTitle,
    "createdAt": createdAt,
  };
}
