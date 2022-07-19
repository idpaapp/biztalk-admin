// To parse this JSON data, do
//
//     final usersHomeModel = usersHomeModelFromJson(jsonString);

import 'dart:convert';

UsersHomeModel usersHomeModelFromJson(String str) => UsersHomeModel.fromJson(json.decode(str));

String usersHomeModelToJson(UsersHomeModel data) => json.encode(data.toJson());

class UsersHomeModel {
  UsersHomeModel({
    this.ok,
    this.message,
    this.data,
  });

  bool? ok;
  String? message;
  Data? data;

  factory UsersHomeModel.fromJson(Map<String, dynamic> json) => UsersHomeModel(
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
    this.users,
    this.totalDocs,
    this.totalPages,
    this.page,
    this.hasNextPage,
    this.hasPrevPage,
  });

  List<User>? users;
  int? totalDocs;
  int? totalPages;
  int? page;
  bool? hasNextPage;
  bool? hasPrevPage;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    users: List<User>.from(json["users"].map((x) => User.fromJson(x))),
    totalDocs: json["totalDocs"],
    totalPages: json["totalPages"],
    page: json["page"],
    hasNextPage: json["hasNextPage"],
    hasPrevPage: json["hasPrevPage"],
  );

  Map<String, dynamic> toJson() => {
    "users": List<dynamic>.from(users!.map((x) => x.toJson())),
    "totalDocs": totalDocs,
    "totalPages": totalPages,
    "page": page,
    "hasNextPage": hasNextPage,
    "hasPrevPage": hasPrevPage,
  };
}

class User {
  User({
    this.id,
    this.fullName,
    this.phoneNumber,
    this.userName,
    this.profileImage,
    this.userType,
  });

  String? id;
  String? fullName;
  String? phoneNumber;
  String? userName;
  String? profileImage;
  String? userType;

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["_id"],
    fullName: json["fullName"],
    phoneNumber: json["phoneNumber"],
    userName: json["userName"],
    profileImage: json["profileImage"],
    userType: json["userType"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "fullName": fullName,
    "phoneNumber": phoneNumber,
    "userName": userName,
    "profileImage": profileImage,
    "userType": userType,
  };
}
