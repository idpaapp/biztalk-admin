// To parse this JSON data, do
//
//     final changeProfileModel = changeProfileModelFromJson(jsonString);

import 'dart:convert';

ChangeProfileModel changeProfileModelFromJson(String str) => ChangeProfileModel.fromJson(json.decode(str));

String changeProfileModelToJson(ChangeProfileModel data) => json.encode(data.toJson());

class ChangeProfileModel {
  ChangeProfileModel({
    this.ok,
    this.message,
    this.data,
  });

  bool? ok;
  String? message;
  List<Datum>? data;

  factory ChangeProfileModel.fromJson(Map<String, dynamic> json) => ChangeProfileModel(
    ok: json["ok"] == null ? null : json["ok"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "ok": ok == null ? null : ok,
    "message": message == null ? null : message,
    "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    this.aboutMe,
    this.id,
    this.fullName,
    this.userName,
  });

  AboutMe? aboutMe;
  String? id;
  String? fullName;
  String? userName;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    aboutMe: json["aboutMe"] == null ? null : AboutMe.fromJson(json["aboutMe"]),
    id: json["_id"] == null ? null : json["_id"],
    fullName: json["fullName"] == null ? null : json["fullName"],
    userName: json["userName"] == null ? null : json["userName"],
  );

  Map<String, dynamic> toJson() => {
    "aboutMe": aboutMe == null ? null : aboutMe!.toJson(),
    "_id": id == null ? null : id,
    "fullName": fullName == null ? null : fullName,
    "userName": userName == null ? null : userName,
  };
}

class AboutMe {
  AboutMe({
    this.videoUrl,
    this.videoStatus,
    this.description,
    this.descriptionStatus,
  });

  dynamic videoUrl;
  bool? videoStatus;
  String? description;
  bool? descriptionStatus;

  factory AboutMe.fromJson(Map<String, dynamic> json) => AboutMe(
    videoUrl: json["videoUrl"],
    videoStatus: json["videoStatus"] == null ? null : json["videoStatus"],
    description: json["description"] == null ? null : json["description"],
    descriptionStatus: json["descriptionStatus"] == null ? null : json["descriptionStatus"],
  );

  Map<String, dynamic> toJson() => {
    "videoUrl": videoUrl,
    "videoStatus": videoStatus == null ? null : videoStatus,
    "description": description == null ? null : description,
    "descriptionStatus": descriptionStatus == null ? null : descriptionStatus,
  };
}
