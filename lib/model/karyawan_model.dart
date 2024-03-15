import 'dart:convert';

ModelKaryawan modelKaryawanFromJson(String str) => ModelKaryawan.fromJson(json.decode(str));

String modelKaryawanToJson(ModelKaryawan data) => json.encode(data.toJson());

class ModelKaryawan {
  String message;
  List<Datum> result;

  ModelKaryawan({
    required this.message,
    required this.result,
  });

  factory ModelKaryawan.fromJson(Map<String, dynamic> json) => ModelKaryawan(
    message: json["message"],
    result: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "result": List<dynamic>.from(result.map((x) => x.toJson())),
  };


}

class Datum {
  String name;
  String no_bp;
  String no_hp;
  String email;
  DateTime input_date;

  Datum({
    required this.name,
    required this.no_bp,
    required this.no_hp,
    required this.email,
    required this.input_date,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    name: json["name"],
    no_bp: json["no_bp"],
    no_hp: json["no_hp"],
    email: json["email"],
    input_date: DateTime.parse(json["input_date"]),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "no_bp": no_bp,
    "no_hp": no_hp,
    "email": email,
    "input_date": input_date.toIso8601String(),
  };
}





