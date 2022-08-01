// To parse this JSON data, do
//
//     final getMentorForAskModel = getMentorForAskModelFromJson(jsonString);

import 'dart:convert';

GetMentorForAskModel getMentorForAskModelFromJson(String str) => GetMentorForAskModel.fromJson(json.decode(str));

String getMentorForAskModelToJson(GetMentorForAskModel data) => json.encode(data.toJson());

class GetMentorForAskModel {
  GetMentorForAskModel({
    this.ok,
    this.message,
    this.data,
  });

  bool? ok;
  String? message;
  List<MentroAsk>? data;

  factory GetMentorForAskModel.fromJson(Map<String, dynamic> json) => GetMentorForAskModel(
    ok: json["ok"] == null ? null : json["ok"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : List<MentroAsk>.from(json["data"].map((x) => MentroAsk.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "ok": ok == null ? null : ok,
    "message": message == null ? null : message,
    "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class MentroAsk {
  MentroAsk({
    this.id,
    this.fullName,
  });

  String? id;
  String? fullName;

  factory MentroAsk.fromJson(Map<String, dynamic> json) => MentroAsk(
    id: json["_id"] == null ? null : json["_id"],
    fullName: json["fullName"] == null ? null : json["fullName"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id == null ? null : id,
    "fullName": fullName == null ? null : fullName,
  };
}
