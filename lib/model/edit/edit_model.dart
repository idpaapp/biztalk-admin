// To parse this JSON data, do
//
//     final editModel = editModelFromJson(jsonString);

import 'dart:convert';

EditModel editModelFromJson(String str) => EditModel.fromJson(json.decode(str));

String editModelToJson(EditModel data) => json.encode(data.toJson());

class EditModel {
  EditModel({
    this.ok,
    this.message,
  });

  bool? ok;
  String? message;

  factory EditModel.fromJson(Map<String, dynamic> json) => EditModel(
    ok: json["ok"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "ok": ok,
    "message": message,
  };
}
