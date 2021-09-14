// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

Welcome welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));

String welcomeToJson(Welcome data) => json.encode(data.toJson());

class Welcome {
  Welcome({
    this.id,
    this.original,
    this.originalName,
    this.name,
    this.amount,
    this.unit,
    this.unitShort,
    this.unitLong,
    this.possibleUnits,
    this.estimatedCost,
    this.consistency,
    this.shoppingListUnits,
    this.aisle,
    this.image,
    this.meta,
    this.nutrition,
    this.categoryPath,
  });

  int id;
  String original;
  String originalName;
  String name;
  int amount;
  String unit;
  String unitShort;
  String unitLong;
  List<String> possibleUnits;
  EstimatedCost estimatedCost;
  String consistency;
  List<String> shoppingListUnits;
  String aisle;
  String image;
  List<dynamic> meta;
  Nutrition nutrition;
  List<String> categoryPath;

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
    id: json["id"],
    original: json["original"],
    originalName: json["originalName"],
    name: json["name"],
    amount: json["amount"],
    unit: json["unit"],
    unitShort: json["unitShort"],
    unitLong: json["unitLong"],
    possibleUnits: List<String>.from(json["possibleUnits"].map((x) => x)),
    estimatedCost: EstimatedCost.fromJson(json["estimatedCost"]),
    consistency: json["consistency"],
    shoppingListUnits: List<String>.from(json["shoppingListUnits"].map((x) => x)),
    aisle: json["aisle"],
    image: json["image"],
    meta: List<dynamic>.from(json["meta"].map((x) => x)),
    nutrition: Nutrition.fromJson(json["nutrition"]),
    categoryPath: List<String>.from(json["categoryPath"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "original": original,
    "originalName": originalName,
    "name": name,
    "amount": amount,
    "unit": unit,
    "unitShort": unitShort,
    "unitLong": unitLong,
    "possibleUnits": List<dynamic>.from(possibleUnits.map((x) => x)),
    "estimatedCost": estimatedCost.toJson(),
    "consistency": consistency,
    "shoppingListUnits": List<dynamic>.from(shoppingListUnits.map((x) => x)),
    "aisle": aisle,
    "image": image,
    "meta": List<dynamic>.from(meta.map((x) => x)),
    "nutrition": nutrition.toJson(),
    "categoryPath": List<dynamic>.from(categoryPath.map((x) => x)),
  };
}

class EstimatedCost {
  EstimatedCost({
    this.value,
    this.unit,
  });

  int value;
  String unit;

  factory EstimatedCost.fromJson(Map<String, dynamic> json) => EstimatedCost(
    value: json["value"],
    unit: json["unit"],
  );

  Map<String, dynamic> toJson() => {
    "value": value,
    "unit": unit,
  };
}

class Nutrition {
  Nutrition({
    this.nutrients,
    this.properties,
    this.flavanoids,
    this.caloricBreakdown,
    this.weightPerServing,
  });

  List<Flavanoid> nutrients;
  List<Flavanoid> properties;
  List<Flavanoid> flavanoids;
  CaloricBreakdown caloricBreakdown;
  WeightPerServing weightPerServing;

  factory Nutrition.fromJson(Map<String, dynamic> json) => Nutrition(
    nutrients: List<Flavanoid>.from(json["nutrients"].map((x) => Flavanoid.fromJson(x))),
    properties: List<Flavanoid>.from(json["properties"].map((x) => Flavanoid.fromJson(x))),
    flavanoids: List<Flavanoid>.from(json["flavanoids"].map((x) => Flavanoid.fromJson(x))),
    caloricBreakdown: CaloricBreakdown.fromJson(json["caloricBreakdown"]),
    weightPerServing: WeightPerServing.fromJson(json["weightPerServing"]),
  );

  Map<String, dynamic> toJson() => {
    "nutrients": List<dynamic>.from(nutrients.map((x) => x.toJson())),
    "properties": List<dynamic>.from(properties.map((x) => x.toJson())),
    "flavanoids": List<dynamic>.from(flavanoids.map((x) => x.toJson())),
    "caloricBreakdown": caloricBreakdown.toJson(),
    "weightPerServing": weightPerServing.toJson(),
  };
}

class CaloricBreakdown {
  CaloricBreakdown({
    this.percentProtein,
    this.percentFat,
    this.percentCarbs,
  });

  double percentProtein;
  double percentFat;
  double percentCarbs;

  factory CaloricBreakdown.fromJson(Map<String, dynamic> json) => CaloricBreakdown(
    percentProtein: json["percentProtein"].toDouble(),
    percentFat: json["percentFat"].toDouble(),
    percentCarbs: json["percentCarbs"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "percentProtein": percentProtein,
    "percentFat": percentFat,
    "percentCarbs": percentCarbs,
  };
}

class Flavanoid {
  Flavanoid({
    this.name,
    this.title,
    this.amount,
    this.unit,
  });

  String name;
  String title;
  double amount;
  Unit unit;

  factory Flavanoid.fromJson(Map<String, dynamic> json) => Flavanoid(
    name: json["name"],
    title: json["title"],
    amount: json["amount"].toDouble(),
    unit: unitValues.map[json["unit"]],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "title": title,
    "amount": amount,
    "unit": unitValues.reverse[unit],
  };
}

enum Unit { MG, EMPTY, G, UNIT_G, IU, KCAL }

final unitValues = EnumValues({
  "": Unit.EMPTY,
  "g": Unit.G,
  "IU": Unit.IU,
  "kcal": Unit.KCAL,
  "mg": Unit.MG,
  "µg": Unit.UNIT_G
});

class WeightPerServing {
  WeightPerServing({
    this.amount,
    this.unit,
  });

  int amount;
  Unit unit;

  factory WeightPerServing.fromJson(Map<String, dynamic> json) => WeightPerServing(
    amount: json["amount"],
    unit: unitValues.map[json["unit"]],
  );

  Map<String, dynamic> toJson() => {
    "amount": amount,
    "unit": unitValues.reverse[unit],
  };
}

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
