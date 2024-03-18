
import 'dart:convert';

ListUser listUserFromJson(String str) => ListUser.fromJson(json.decode(str));

String listUserToJson(ListUser data) => json.encode(data.toJson());

class ListUser {
  String message;
  List<Result> result;

  ListUser({
    required this.message,
    required this.result,
  });

  factory ListUser.fromJson(Map<String, dynamic> json) => ListUser(
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
  String email;
  String password;

  Result({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    password: json["password"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "password": password,
  };
}
