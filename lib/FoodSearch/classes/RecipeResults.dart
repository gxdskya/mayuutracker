import 'dart:convert';

RecipeResults recipeResultsFromJson(String str) => RecipeResults.fromJson(json.decode(str));

String recipeResultsToJson(RecipeResults data) => json.encode(data.toJson());

class RecipeResults {
  RecipeResults({
    this.results,
    this.offset,
    this.number,
    this.totalResults,
  });

  List<Result> results;
  int offset;
  int number;
  int totalResults;

  factory RecipeResults.fromJson(Map<String, dynamic> json) => RecipeResults(
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
    this.title,
    this.image,
    this.imageType,
    this.nutrition,
  });

  int id;
  String title;
  String image;
  String imageType;
  Nutrition nutrition;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"],
    title: json["title"],
    image: json["image"],
    imageType: json["imageType"],
    nutrition: Nutrition.fromJson(json["nutrition"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "image": image,
    "imageType": imageType,
    "nutrition": nutrition.toJson(),
  };
}

class Nutrition {
  Nutrition({
    this.nutrients,
  });

  List<Nutrient> nutrients;

  factory Nutrition.fromJson(Map<String, dynamic> json) => Nutrition(
    nutrients: List<Nutrient>.from(json["nutrients"].map((x) => Nutrient.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "nutrients": List<dynamic>.from(nutrients.map((x) => x.toJson())),
  };
}

class Nutrient {
  Nutrient({
    this.title,
    this.name,
    this.amount,
    this.unit,
  });

  String title;
  String name;
  double amount;
  String unit;

  factory Nutrient.fromJson(Map<String, dynamic> json) => Nutrient(
    title: json["title"],
    name: json["name"],
    amount: json["amount"].toDouble(),
    unit: json["unit"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "name": name,
    "amount": amount,
    "unit": unit,
  };
}
