// To parse this JSON data, do
//
//     final listKaryawan = listKaryawanFromJson(jsonString);

import 'dart:convert';

ListKaryawan listKaryawanFromJson(String str) => ListKaryawan.fromJson(json.decode(str));

String listKaryawanToJson(ListKaryawan data) => json.encode(data.toJson());

class ListKaryawan {
  String message;
  List<Result> result;

  ListKaryawan({
    required this.message,
    required this.result,
  });

  factory ListKaryawan.fromJson(Map<String, dynamic> json) => ListKaryawan(
    message: json["message"],
    result: List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "result": List<dynamic>.from(result.map((x) => x.toJson())),
  };
}

class Result {
  int id;
  String name;
  String noBp;
  String noHp;
  String email;
  DateTime inputDate;

  Result({
    required this.id,
    required this.name,
    required this.noBp,
    required this.noHp,
    required this.email,
    required this.inputDate,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"],
    name: json["name"],
    noBp: json["no_bp"],
    noHp: json["no_hp"],
    email: json["email"],
    inputDate: DateTime.parse(json["input_date"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "no_bp": noBp,
    "no_hp": noHp,
    "email": email,
    "input_date": inputDate.toIso8601String(),
  };
}
