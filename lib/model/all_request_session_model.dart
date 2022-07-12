// To parse this JSON data, do
//
//     final allRequestSessionModel = allRequestSessionModelFromJson(jsonString);

import 'dart:convert';

AllRequestSessionModel allRequestSessionModelFromJson(String str) => AllRequestSessionModel.fromJson(json.decode(str));

String allRequestSessionModelToJson(AllRequestSessionModel data) => json.encode(data.toJson());

class AllRequestSessionModel {
  AllRequestSessionModel({
    this.ok,
    this.message,
    this.data,
  });

  bool? ok;
  String? message;
  Data? data;

  factory AllRequestSessionModel.fromJson(Map<String, dynamic> json) => AllRequestSessionModel(
    ok: json["ok"] == null ? null : json["ok"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "ok": ok == null ? null : ok,
    "message": message == null ? null : message,
    "data": data == null ? null : data!.toJson(),
  };
}

class Data {
  Data({
    this.docs,
    this.totalDocs,
    this.limit,
    this.totalPages,
    this.page,
  });

  List<Doc>? docs;
  int? totalDocs;
  int? limit;
  int? totalPages;
  int? page;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    docs: json["docs"] == null ? null : List<Doc>.from(json["docs"].map((x) => Doc.fromJson(x))),
    totalDocs: json["totalDocs"] == null ? null : json["totalDocs"],
    limit: json["limit"] == null ? null : json["limit"],
    totalPages: json["totalPages"] == null ? null : json["totalPages"],
    page: json["page"] == null ? null : json["page"],
  );

  Map<String, dynamic> toJson() => {
    "docs": docs == null ? null : List<dynamic>.from(docs!.map((x) => x.toJson())),
    "totalDocs": totalDocs == null ? null : totalDocs,
    "limit": limit == null ? null : limit,
    "totalPages": totalPages == null ? null : totalPages,
    "page": page == null ? null : page,
  };
}

class Doc {
  Doc({
    this.id,
    this.subject,
    this.description,
    this.times,
    this.user,
    this.mentor,
    this.status,
    this.hasChanged,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.activeChatRoom,
    this.sessionLink,
    this.isCheckout,
    this.time,
    this.request,
  });

  String? id;
  Subject? subject;
  String? description;
  List<dynamic>? times;
  Mentor? user;
  Mentor? mentor;
  String? status;
  bool? hasChanged;
  String? createdAt;
  String? updatedAt;
  int? v;
  dynamic activeChatRoom;
  dynamic sessionLink;
  bool? isCheckout;
  TimeTime ? time;
  String? request;

  factory Doc.fromJson(Map<String, dynamic> json) => Doc(
    id: json["_id"] == null ? null : json["_id"],
    subject: json["subject"] == null ? null : Subject.fromJson(json["subject"]),
    description: json["description"] == null ? null : json["description"],
    times: json["times"] == null ? null : List<dynamic>.from(json["times"].map((x) => x)),
    user: json["user"] == null ? null : Mentor.fromJson(json["user"]),
    mentor: json["mentor"] == null ? null : Mentor.fromJson(json["mentor"]),
    status: json["status"] == null ? null : json["status"],
    hasChanged: json["hasChanged"] == null ? null : json["hasChanged"],
    createdAt: json["createdAt"] == null ? null : json["createdAt"],
    updatedAt: json["updatedAt"] == null ? null : json["updatedAt"],
    v: json["__v"] == null ? null : json["__v"],
    activeChatRoom: json["activeChatRoom"],
    sessionLink: json["sessionLink"],
    isCheckout: json["isCheckout"] == null ? null : json["isCheckout"],
    time: json["time"] == null ? null : TimeTime.fromJson(json["subject"]),
    request: json["request"] == null ? null : json["request"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id == null ? null : id,
    "subject": subject == null ? null : subject!.toJson(),
    "description": description == null ? null : description,
    "times": times == null ? null : List<dynamic>.from(times!.map((x) => x)),
    "user": user == null ? null : user!.toJson(),
    "mentor": mentor == null ? null : mentor!.toJson(),
    "status": status == null ? null : status,
    "hasChanged": hasChanged == null ? null : hasChanged,
    "createdAt": createdAt == null ? null : createdAt!,
    "updatedAt": updatedAt == null ? null : updatedAt!,
    "__v": v == null ? null : v,
    "activeChatRoom": activeChatRoom,
    "sessionLink": sessionLink,
    "isCheckout": isCheckout == null ? null : isCheckout,
    "time": time == null ? null : time!,
    "request": request == null ? null : request,
  };
}

class Mentor {
  Mentor({
    this.id,
    this.fullName,
    this.profileImageUrl,
    this.jobTitle,
    this.grade,
    this.userType,
  });

  String? id;
  String? fullName;
  String? profileImageUrl;
  String? jobTitle;
  String? grade;
  String? userType;

  factory Mentor.fromJson(Map<String, dynamic> json) => Mentor(
    id: json["_id"] == null ? null : json["_id"],
    fullName: json["fullName"] == null ? null : json["fullName"],
    profileImageUrl: json["profileImageUrl"] == null ? null : json["profileImageUrl"],
    jobTitle: json["jobTitle"] == null ? null : json["jobTitle"],
    grade: json["grade"] == null ? null : json["grade"],
    userType: json["userType"] == null ? null : json["userType"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id == null ? null : id,
    "fullName": fullName == null ? null : fullName,
    "profileImageUrl": profileImageUrl == null ? null : profileImageUrl,
    "jobTitle": jobTitle == null ? null : jobTitle,
    "grade": grade == null ? null : grade,
    "userType": userType == null ? null : userType,
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
    id: json["_id"] == null ? null : json["_id"],
    title: json["title"] == null ? null : json["title"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id == null ? null : id,
    "title": title == null ? null : title,
  };
}

class DocTime {
  DocTime({
    this.time,
    this.id,
    this.date,
    this.mentor,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.request,
  });

  TimeTime? time;
  String? id;
  String? date;
  String? mentor;
  String? createdAt;
  String? updatedAt;
  int? v;
  String? request;

  factory DocTime.fromJson(Map<String, dynamic> json) => DocTime(
    time: json["time"] == null ? null : TimeTime.fromJson(json["time"]),
    id: json["_id"] == null ? null : json["_id"],
    date: json["date"] == null ? null : json["date"],
    mentor: json["mentor"] == null ? null : json["mentor"],
    createdAt: json["createdAt"] == null ? null : json["createdAt"],
    updatedAt: json["updatedAt"] == null ? null : json["updatedAt"],
    v: json["__v"] == null ? null : json["__v"],
    request: json["request"] == null ? null : json["request"],
  );

  Map<String, dynamic> toJson() => {
    "time": time == null ? null : time!.toJson(),
    "_id": id == null ? null : id,
    "date": date == null ? null : date,
    "mentor": mentor == null ? null : mentor,
    "createdAt": createdAt == null ? null : createdAt,
    "updatedAt": updatedAt == null ? null : updatedAt,
    "__v": v == null ? null : v,
    "request": request == null ? null : request,
  };
}

class TimeTime {
  TimeTime({
    this.start,
    this.end,
    this.price,
    this.inReservation,
    this.formattedPrice,
    this.status,
  });

  String? start;
  String? end;
  int? price;
  String? inReservation;
  String? formattedPrice;
  String? status;

  factory TimeTime.fromJson(Map<String, dynamic> json) => TimeTime(
    start: json["start"] == null ? null : json["start"],
    end: json["end"] == null ? null : json["end"],
    price: json["price"] == null ? null : json["price"],
    inReservation: json["inReservation"] == null ? null : json["inReservation"],
    formattedPrice: json["formattedPrice"] == null ? null : json["formattedPrice"],
    status: json["status"] == null ? null : json["status"],
  );

  Map<String, dynamic> toJson() => {
    "start": start == null ? null : start,
    "end": end == null ? null : end,
    "price": price == null ? null : price,
    "inReservation": inReservation == null ? null : inReservation,
    "formattedPrice": formattedPrice == null ? null : formattedPrice,
    "status": status == null ? null : status,
  };
}
