// To parse this JSON data, do
//
//     final documentsModel = documentsModelFromJson(jsonString);

import 'dart:convert';

DocumentsModel documentsModelFromJson(String str) => DocumentsModel.fromJson(json.decode(str));

String documentsModelToJson(DocumentsModel data) => json.encode(data.toJson());

class DocumentsModel {
  DocumentsModel({
    this.ok,
    this.message,
    this.data,
  });

  bool? ok;
  String? message;
  Data? data;

  factory DocumentsModel.fromJson(Map<String, dynamic> json) => DocumentsModel(
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
    this.works,
    this.educations,
    this.achievements,
  });

  List<Work>? works;
  List<Education>? educations;
  List<Achievement>? achievements;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    works: json["works"] == null ? null : List<Work>.from(json["works"].map((x) => Work.fromJson(x))),
    educations: json["educations"] == null ? null : List<Education>.from(json["educations"].map((x) => Education.fromJson(x))),
    achievements: json["achievements"] == null ? null : List<Achievement>.from(json["achievements"].map((x) => Achievement.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "works": works == null ? null : List<dynamic>.from(works!.map((x) => x.toJson())),
    "educations": educations == null ? null : List<dynamic>.from(educations!.map((x) => x.toJson())),
    "achievements": achievements == null ? null : List<dynamic>.from(achievements!.map((x) => x.toJson())),
  };
}

class Achievement {
  Achievement({
    this.id,
    this.title,
    this.place,
    this.year,
    this.status,
    this.statusTitle,
    this.verificationStatus,
    this.verificationStatusTitle,
    this.attachments,
  });

  String? id;
  String? title;
  String? place;
  String? year;
  bool? status;
  String? statusTitle;
  String? verificationStatus;
  String? verificationStatusTitle;
  List<Attachment>? attachments;

  factory Achievement.fromJson(Map<String, dynamic> json) => Achievement(
    id: json["id"] == null ? null : json["id"],
    title: json["title"] == null ? null : json["title"],
    place: json["place"] == null ? null : json["place"],
    year: json["year"] == null ? null : json["year"],
    status: json["status"] == null ? null : json["status"],
    statusTitle: json["statusTitle"] == null ? null : json["statusTitle"],
    verificationStatus: json["verificationStatus"] == null ? null : json["verificationStatus"],
    verificationStatusTitle: json["verificationStatusTitle"] == null ? null : json["verificationStatusTitle"],
    attachments: json["attachments"] == null ? null : List<Attachment>.from(json["attachments"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "title": title == null ? null : title,
    "place": place == null ? null : place,
    "year": year == null ? null : year,
    "status": status == null ? null : status,
    "statusTitle": statusTitle == null ? null : statusTitle,
    "verificationStatus": verificationStatus == null ? null : verificationStatus,
    "verificationStatusTitle": verificationStatusTitle == null ? null : verificationStatusTitle,
    "attachments": attachments == null ? null : List<Attachment>.from(attachments!.map((x) => x)),
  };
}

class Education {
  Education({
    this.id,
    this.school,
    this.schoolTitle,
    this.degree,
    this.startYear,
    this.endYear,
    this.activityYear,
    this.status,
    this.statusTitle,
    this.verificationStatus,
    this.verificationStatusTitle,
    this.attachments,
    this.currentCourse,
  });

  String? id;
  School? school;
  String? schoolTitle;
  String? degree;
  String? startYear;
  String? endYear;
  String? activityYear;
  bool? status;
  String? statusTitle;
  String? verificationStatus;
  String? verificationStatusTitle;
  List<Attachment>? attachments;
  bool? currentCourse;

  factory Education.fromJson(Map<String, dynamic> json) => Education(
    id: json["id"] == null ? null : json["id"],
    school: json["school"] == null ? null : School.fromJson(json["school"]),
    schoolTitle: json["schoolTitle"] == null ? null : json["schoolTitle"],
    degree: json["degree"] == null ? null : json["degree"],
    startYear: json["startYear"] == null ? null : json["startYear"],
    endYear: json["endYear"] == null ? null : json["endYear"],
    activityYear: json["activityYear"] == null ? null : json["activityYear"],
    status: json["status"] == null ? null : json["status"],
    statusTitle: json["statusTitle"] == null ? null : json["statusTitle"],
    verificationStatus: json["verificationStatus"] == null ? null : json["verificationStatus"],
    verificationStatusTitle: json["verificationStatusTitle"] == null ? null : json["verificationStatusTitle"],
    attachments: json["attachments"] == null ? null : List<Attachment>.from(json["attachments"].map((x) => x)),
    currentCourse: json["currentCourse"] == null ? null : json["currentCourse"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "school": school == null ? null : school!.toJson(),
    "schoolTitle": schoolTitle == null ? null : schoolTitle,
    "degree": degree == null ? null : degree,
    "startYear": startYear == null ? null : startYear,
    "endYear": endYear == null ? null : endYear,
    "activityYear": activityYear == null ? null : activityYear,
    "status": status == null ? null : status,
    "statusTitle": statusTitle == null ? null : statusTitle,
    "verificationStatus": verificationStatus == null ? null : verificationStatus,
    "verificationStatusTitle": verificationStatusTitle == null ? null : verificationStatusTitle,
    "attachments": attachments == null ? null : List<dynamic>.from(attachments!.map((x) => x)),
    "currentCourse": currentCourse == null ? null : currentCourse,
  };
}

class School {
  School({
    this.id,
    this.title,
    this.slug,
    this.imageUrl,
    this.type,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  String? id;
  String? title;
  String? slug;
  String? imageUrl;
  String? type;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  factory School.fromJson(Map<String, dynamic> json) => School(
    id: json["_id"] == null ? null : json["_id"],
    title: json["title"] == null ? null : json["title"],
    slug: json["slug"] == null ? null : json["slug"],
    imageUrl: json["imageUrl"] == null ? null : json["imageUrl"],
    type: json["type"] == null ? null : json["type"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"] == null ? null : json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id == null ? null : id,
    "title": title == null ? null : title,
    "slug": slug == null ? null : slug,
    "imageUrl": imageUrl == null ? null : imageUrl,
    "type": type == null ? null : type,
    "createdAt": createdAt == null ? null : createdAt!.toIso8601String(),
    "updatedAt": updatedAt == null ? null : updatedAt!.toIso8601String(),
    "__v": v == null ? null : v,
  };
}

class Work {
  Work({
    this.id,
    this.job,
    this.company,
    this.companyTitle,
    this.startYear,
    this.endYear,
    this.activityYear,
    this.status,
    this.statusTitle,
    this.verificationStatus,
    this.verificationStatusTitle,
    this.attachments,
    this.currentPosition,
  });

  String? id;
  String? job;
  School? company;
  String? companyTitle;
  String? startYear;
  String? endYear;
  String? activityYear;
  bool? status;
  String? statusTitle;
  String? verificationStatus;
  String? verificationStatusTitle;
  List<Attachment>? attachments;
  bool? currentPosition;

  factory Work.fromJson(Map<String, dynamic> json) => Work(
    id: json["id"] == null ? null : json["id"],
    job: json["job"] == null ? null : json["job"],
    company: json["company"] == null ? null : School.fromJson(json["company"]),
    companyTitle: json["companyTitle"] == null ? null : json["companyTitle"],
    startYear: json["startYear"] == null ? null : json["startYear"],
    endYear: json["endYear"] == null ? null : json["endYear"],
    activityYear: json["activityYear"] == null ? null : json["activityYear"],
    status: json["status"] == null ? null : json["status"],
    statusTitle: json["statusTitle"] == null ? null : json["statusTitle"],
    verificationStatus: json["verificationStatus"] == null ? null : json["verificationStatus"],
    verificationStatusTitle: json["verificationStatusTitle"] == null ? null : json["verificationStatusTitle"],
    attachments: json["attachments"] == null ? null : List<Attachment>.from(json["attachments"].map((x) => x)),
    currentPosition: json["currentPosition"] == null ? null : json["currentPosition"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "job": job == null ? null : job,
    "company": company == null ? null : company!.toJson(),
    "companyTitle": companyTitle == null ? null : companyTitle,
    "startYear": startYear == null ? null : startYear,
    "endYear": endYear == null ? null : endYear,
    "activityYear": activityYear == null ? null : activityYear,
    "status": status == null ? null : status,
    "statusTitle": statusTitle == null ? null : statusTitle,
    "verificationStatus": verificationStatus == null ? null : verificationStatus,
    "verificationStatusTitle": verificationStatusTitle == null ? null : verificationStatusTitle,
    "attachments": attachments == null ? null : List<dynamic>.from(attachments!.map((x) => x)),
    "currentPosition": currentPosition == null ? null : currentPosition,
  };
}
class Attachment {
  Attachment({
    this.fileUrl,
    this.id,
  });

  String? fileUrl;
  String? id;

  factory Attachment.fromJson(Map<String, dynamic> json) => Attachment(
    fileUrl: json["fileUrl"],
    id: json["_id"],
  );

  Map<String, dynamic> toJson() => {
    "fileUrl": fileUrl,
    "_id": id,
  };
}

