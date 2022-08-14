// To parse this JSON data, do
//
//     final sessionListModel = sessionListModelFromJson(jsonString);

import 'dart:convert';

SessionListModel sessionListModelFromJson(String str) =>
    SessionListModel.fromJson(json.decode(str));

String sessionListModelToJson(SessionListModel data) =>
    json.encode(data.toJson());

class SessionListModel {
  SessionListModel({
    this.ok,
    this.message,
    this.data,
  });

  bool? ok;
  String? message;
  Data? data;

  factory SessionListModel.fromJson(Map<String, dynamic> json) =>
      SessionListModel(
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
    this.session,
    this.totalDocs,
    this.totalPages,
    this.page,
    this.hasNextPage,
    this.hasPrevPage,
  });

  List<Session>? session;
  int? totalDocs;
  int? totalPages;
  int? page;
  bool? hasNextPage;
  bool? hasPrevPage;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        session:
            List<Session>.from(json["session"].map((x) => Session.fromJson(x))),
        totalDocs: json["totalDocs"],
        totalPages: json["totalPages"],
        page: json["page"],
        hasNextPage: json["hasNextPage"],
        hasPrevPage: json["hasPrevPage"],
      );

  Map<String, dynamic> toJson() => {
        "session": List<dynamic>.from(session!.map((x) => x.toJson())),
        "totalDocs": totalDocs,
        "totalPages": totalPages,
        "page": page,
        "hasNextPage": hasNextPage,
        "hasPrevPage": hasPrevPage,
      };
}

class Session {
  Session(
      {this.id,
      this.subject,
      this.user,
      this.mentor,
      this.date,
      this.startTime,
      this.price,
      this.formattedPrice,
      this.description,
      this.fromNow,
      this.status,
      this.timeId,
      this.statusTitle});

  String? id;
  SubjectSingle? subject;
  Mentor? user;
  Mentor? mentor;
  String? date;
  String? startTime;
  int? price;
  String? formattedPrice;
  String? description;
  String? fromNow;
  String? status;
  String? statusTitle;
  String? timeId;

  factory Session.fromJson(Map<String, dynamic> json) => Session(
        id: json["_id"],
        timeId: json["timeId"],
        subject: SubjectSingle.fromJson(json["subject"]),
        user: Mentor.fromJson(json["user"]),
        mentor: Mentor.fromJson(json["mentor"]),
        date: json["date"],
        startTime: json["startTime"],
        price: json["price"],
        formattedPrice: json["formattedPrice"],
        description: json["description"],
        fromNow: json["fromNow"],
        status: json["status"],
        statusTitle: json["statusTitle"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "timeId": timeId,
        "subject": subject!.toJson(),
        "user": user!.toJson(),
        "mentor": mentor!.toJson(),
        "date": date,
        "startTime": startTime,
        "price": price,
        "formattedPrice": formattedPrice,
        "description": description,
        "fromNow": fromNow,
        "statusTitle": statusTitle,
        "status": status
      };
}

class Mentor {
  Mentor({this.id, this.fullName, this.phoneNumber, this.profileImageUrl});

  String? id;
  String? fullName;
  String? phoneNumber;
  String? profileImageUrl;

  factory Mentor.fromJson(Map<String, dynamic> json) => Mentor(
        id: json["_id"],
        fullName: json["fullName"],
        phoneNumber: json["phoneNumber"],
        profileImageUrl: json["profileImageUrl"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "fullName": fullName,
        "phoneNumber": phoneNumber,
        "profileImageUrl": profileImageUrl
      };
}

class SubjectSingle {
  SubjectSingle({
    this.id,
    this.title,
  });

  String? id;
  String? title;

  factory SubjectSingle.fromJson(Map<String, dynamic> json) => SubjectSingle(
        id: json["_id"],
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
      };
}
