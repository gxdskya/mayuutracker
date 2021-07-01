import 'dart:convert';
//instant endpoint file

InstantEndpoint welcomeFromJson(String str) => InstantEndpoint.fromJson(json.decode(str));

String welcomeToJson(InstantEndpoint data) => json.encode(data.toJson());

class InstantEndpoint {
  InstantEndpoint({
    this.results,
    this.offset,
    this.number,
    this.totalResults,
  });

  List<Result> results;
  int offset;
  int number;
  int totalResults;

  factory InstantEndpoint.fromJson(Map<String, dynamic> json) => InstantEndpoint(
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
