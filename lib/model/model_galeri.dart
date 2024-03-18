
import 'dart:convert';

ListGaleri listGaleriFromJson(String str) => ListGaleri.fromJson(json.decode(str));

String listGaleriToJson(ListGaleri data) => json.encode(data.toJson());

class ListGaleri {
  String message;
  List<Result> result;

  ListGaleri({
    required this.message,
    required this.result,
  });

  factory ListGaleri.fromJson(Map<String, dynamic> json) => ListGaleri(
    message: json["message"],
    result: List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "result": List<dynamic>.from(result.map((x) => x.toJson())),
  };
}

class Result {
  String title;
  String image;

  Result({
    required this.title,
    required this.image,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    title: json["title"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "image": image,
  };
}
