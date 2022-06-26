// To parse this JSON data, do
//
//     final requestListModel = requestListModelFromJson(jsonString);

import 'dart:convert';

RequestListModel requestListModelFromJson(String str) => RequestListModel.fromJson(json.decode(str));

String requestListModelToJson(RequestListModel data) => json.encode(data.toJson());

class RequestListModel {
  RequestListModel({
    this.ok,
    this.message,
    this.data,
  });

  bool? ok;
  String? message;
  Data? data;

  factory RequestListModel.fromJson(Map<String, dynamic> json) => RequestListModel(
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
    this.request,
    this.totalDocs,
    this.totalPages,
    this.page,
    this.hasNextPage,
    this.hasPrevPage,
  });

  List<Request>? request;
  int? totalDocs;
  int? totalPages;
  int? page;
  bool? hasNextPage;
  bool? hasPrevPage;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    request: List<Request>.from(json["request"].map((x) => Request.fromJson(x))),
    totalDocs: json["totalDocs"],
    totalPages: json["totalPages"],
    page: json["page"],
    hasNextPage: json["hasNextPage"],
    hasPrevPage: json["hasPrevPage"],
  );

  Map<String, dynamic> toJson() => {
    "request": List<dynamic>.from(request!.map((x) => x.toJson())),
    "totalDocs": totalDocs,
    "totalPages": totalPages,
    "page": page,
    "hasNextPage": hasNextPage,
    "hasPrevPage": hasPrevPage,
  };
}

class Request {
  Request({
    this.id,
    this.user,
    this.mentor,
    this.createdAt,
    this.subject,
    this.status,
    this.statusTitle,
    this.description,
  });

  String? id;
  Mentor? user;
  Mentor? mentor;
  String? createdAt;
  Subject? subject;
  String? status;
  String? statusTitle;
  String? description;

  factory Request.fromJson(Map<String, dynamic> json) => Request(
    id: json["_id"],
    description: json["description"],
    user: Mentor.fromJson(json["user"]),
    mentor: Mentor.fromJson(json["mentor"]),
    createdAt: json["createdAt"],
    subject: Subject.fromJson(json["subject"]),
    status: json["status"],
    statusTitle: json["statusTitle"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "user": user!.toJson(),
    "mentor": mentor!.toJson(),
    "createdAt": createdAt,
    "subject": subject!.toJson(),
    "status": status,
    "statusTitle": statusTitle,
    "description": description,
  };
}

class Mentor {
  Mentor({
    this.id,
    this.fullName,
    this.phoneNumber,
    this.profileImageUrl,
  });

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
    "profileImageUrl": profileImageUrl,
  };
}

class Subject {
  Subject({
    this.id,
    this.title,
  });

  String? id;
  String? title;

  factory Subject.fromJson(Map<String, dynamic> json) => Subject(
    id: json["_id"],
    title: json["title"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "title": title,
  };
}
