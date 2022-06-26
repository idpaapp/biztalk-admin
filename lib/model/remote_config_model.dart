// To parse this JSON data, do
//
//     final remoteConfigModel = remoteConfigModelFromJson(jsonString);

import 'dart:convert';

RemoteConfigModel remoteConfigModelFromJson(String str) =>
    RemoteConfigModel.fromJson(json.decode(str));

String remoteConfigModelToJson(RemoteConfigModel data) =>
    json.encode(data.toJson());

class RemoteConfigModel {
  RemoteConfigModel({
    this.results,
  });

  List<Result>? results;

  factory RemoteConfigModel.fromJson(Map<String, dynamic> json) =>
      RemoteConfigModel(
        results: json["results"] == null
            ? null
            : List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "results": results == null
            ? null
            : List<dynamic>.from(results!.map((x) => x.toJson())),
      };
}

class Result {
  Result({
    this.objectId,
    this.createdAt,
    this.updatedAt,
    this.maintenanceBreak,
    this.maintenanceBreakMessage,
    this.baseUrl,
  });

  String? objectId;
  DateTime? createdAt;
  DateTime? updatedAt;
  bool? maintenanceBreak;
  String? maintenanceBreakMessage;
  String? baseUrl;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        objectId: json["objectId"] == null ? null : json["objectId"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        maintenanceBreak:
            json["maintenanceBreak"] == null ? null : json["maintenanceBreak"],
        maintenanceBreakMessage: json["maintenanceBreakMessage"] == null
            ? null
            : json["maintenanceBreakMessage"],
        baseUrl: json["baseUrl"] == null ? null : json["baseUrl"],
      );

  Map<String, dynamic> toJson() => {
        "objectId": objectId == null ? null : objectId,
        "createdAt": createdAt == null ? null : createdAt!.toIso8601String(),
        "updatedAt": updatedAt == null ? null : updatedAt!.toIso8601String(),
        "maintenanceBreak": maintenanceBreak == null ? null : maintenanceBreak,
        "maintenanceBreakMessage":
            maintenanceBreakMessage == null ? null : maintenanceBreakMessage,
        "baseUrl": baseUrl == null ? null : baseUrl,
      };
}
