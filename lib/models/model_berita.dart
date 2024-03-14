import 'dart:convert';

ModelBerita modelBeritaFromJson(String str) {
  try {
    return ModelBerita.fromJson(json.decode(str));
  } catch (e) {
    print('Error parsing JSON: $e');
    rethrow;
  }
}

String modelBeritaToJson(ModelBerita result) => json.encode(result.toJson());

class ModelBerita {
  // bool isSuccess;
  String message;
  List<Datum> result;

  ModelBerita({
    // required this.isSuccess,
    required this.message,
    required this.result,
  });

  factory ModelBerita.fromJson(Map<String, dynamic> json) {
    try {
      return ModelBerita(
        // // isSuccess: json["isSuccess"],
        message: json["message"],
        result: List<Datum>.from(json["result"].map((x) => Datum.fromJson(x))),
      );
    } catch (e) {
      print('Error creating ModelBerita from JSON: $e');
      rethrow;
    }
  }

  Map<String, dynamic> toJson() => {
        // // "isSuccess": isSuccess,
        "message": message,
        "result": List<dynamic>.from(result.map((x) => x.toJson())),
      };
}

class Datum {
  String title;
  String content;
  String image;

  Datum({
    required this.title,
    required this.content,
    required this.image,
  });

  factory Datum.fromJson(Map<String, dynamic> json) {
    try {
      return Datum(
        title: json["title"],
        content: json["content"],
        image: json["image"],
      );
    } catch (e) {
      print('Error creating Datum from JSON: $e');
      rethrow;
    }
  }

  Map<String, dynamic> toJson() => {
        "title": title,
        "content": content,
        "image": image,
      };
}
