// To parse this JSON data, do
//
//     final allBannerModel = allBannerModelFromJson(jsonString);

import 'dart:convert';

AllBannerModel allBannerModelFromJson(String str) => AllBannerModel.fromJson(json.decode(str));

String allBannerModelToJson(AllBannerModel data) => json.encode(data.toJson());

class AllBannerModel {
  AllBannerModel({
    this.ok,
    this.message,
    this.data,
  });

  bool? ok;
  String? message;
  Data? data;

  factory AllBannerModel.fromJson(Map<String, dynamic> json) => AllBannerModel(
    ok: json["ok"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "ok": ok,
    "message": message,
    "data": data == null ? null : data!.toJson(),
  };
}

class Data {
  Data({
    this.carousel,
    this.middle1,
    this.middle2,
    this.middle3,
    this.list1,
    this.list2,
    this.list3,
  });

  List<Middle1>? carousel;
  Middle1? middle1;
  Middle1? middle2;
  Middle1? middle3;
  List<Middle1>? list1;
  List<Middle1>? list2;
  List<Middle1>? list3;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    carousel: json["carousel"] == null ? null : List<Middle1>.from(json["carousel"].map((x) => Middle1.fromJson(x))),
    middle1: json["middle1"] == null ? null : Middle1.fromJson(json["middle1"]),
    middle2: json["middle2"] == null ? null : Middle1.fromJson(json["middle2"]),
    middle3: json["middle3"] == null ? null : Middle1.fromJson(json["middle3"]),
    list1: json["list1"] == null ? null : List<Middle1>.from(json["list1"].map((x) => Middle1.fromJson(x))),
    list2: json["list2"] == null ? null : List<Middle1>.from(json["list2"].map((x) => Middle1.fromJson(x))),
    list3: json["list3"] == null ? null : List<Middle1>.from(json["list3"].map((x) => Middle1.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "carousel": carousel == null ? null : List<dynamic>.from(carousel!.map((x) => x.toJson())),
    "middle1": middle1 == null ? null : middle1!.toJson(),
    "middle2": middle2 == null ? null : middle2!.toJson(),
    "middle3": middle3 == null ? null : middle3!.toJson(),
    "list1": list1 == null ? null : List<dynamic>.from(list1!.map((x) => x.toJson())),
    "list2": list2 == null ? null : List<dynamic>.from(list2!.map((x) => x.toJson())),
    "list3": list3 == null ? null : List<dynamic>.from(list3!.map((x) => x.toJson())),
  };
}

class Middle1 {
  Middle1({
    this.id,
    this.bannerGroup,
    this.bannerType,
    this.logo,
    this.bannerTitle,
    this.bannerDescription,
    this.link,
    this.mentors,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  String? id;
  String? bannerGroup;
  String? bannerType;
  String? logo;
  String? bannerTitle;
  String? bannerDescription;
  String? link;
  List<Mentor>? mentors;
  bool? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  factory Middle1.fromJson(Map<String, dynamic> json) => Middle1(
    id: json["_id"],
    bannerGroup: json["bannerGroup"],
    bannerType: json["bannerType"],
    logo: json["logo"],
    bannerTitle: json["bannerTitle"],
    bannerDescription: json["bannerDescription"],
    link: json["link"],
    mentors: json["mentors"] == null ? null : List<Mentor>.from(json["mentors"].map((x) => Mentor.fromJson(x))),
    status: json["status"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "bannerGroup": bannerGroup,
    "bannerType": bannerType,
    "logo": logo,
    "bannerTitle": bannerTitle,
    "bannerDescription": bannerDescription,
    "link": link,
    "mentors": mentors == null ? null : List<dynamic>.from(mentors!.map((x) => x.toJson())),
    "status": status,
    "createdAt": createdAt == null ? null : createdAt!.toIso8601String(),
    "updatedAt": updatedAt == null ? null : updatedAt!.toIso8601String(),
    "__v": v,
  };
}

class Mentor {
  Mentor({
    this.id,
    this.fullName,
    this.userName,
    this.phoneNumber,
  });

  String? id;
  String? fullName;
  String? userName;
  String? phoneNumber;

  factory Mentor.fromJson(Map<String, dynamic> json) => Mentor(
    id: json["_id"],
    fullName: json["fullName"],
    userName: json["userName"],
    phoneNumber: json["phoneNumber"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "fullName": fullName,
    "userName": userName,
    "phoneNumber": phoneNumber,
  };
}
