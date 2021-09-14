
import 'dart:convert';

FoodQuery foodQueryFromJson(String str) => FoodQuery.fromJson(json.decode(str));

String foodQueryToJson(FoodQuery data) => json.encode(data.toJson());

class FoodQuery {
  FoodQuery({
    this.results,
    this.offset,
    this.number,
    this.totalResults,
  });

  List<Result> results;
  int offset;
  int number;
  int totalResults;

  factory FoodQuery.fromJson(Map<String, dynamic> json) => FoodQuery(
    results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
    offset: json["offset"],
    number: json["number"],
    totalResults: json["totalResults"],
  );

  Map<String, dynamic> toJson() => {
    "results": List<dynamic>.from(results.map((x) => x.toJson())),
    "offset": offset,
    "number": number,
    "totalResults": totalResults,
  };
}

class Result {
  Result({
    this.id,
    this.name,
    this.image,
  });

  int id;
  String name;
  String image;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"],
    name: json["name"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "image": image,
  };
}
