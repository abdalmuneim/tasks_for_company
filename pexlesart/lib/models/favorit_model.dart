// To parse this JSON data, do
//
//     final favoritModel = favoritModelFromJson(jsonString);

import 'dart:convert';

FavoriteModel favoriteModelFromJson(String str) => FavoriteModel.fromJson(json.decode(str));

String favoriteModelToJson(FavoriteModel data) => json.encode(data.toJson());

class FavoriteModel {
  FavoriteModel({
    required this.id,
    required this.width,
    required this.height,
    required this.photographer,
    required this.photographerUrl,
    required this.photographerId,
    required this.avgColor,
    required this.original,
    required this.alt,
  });

  final int id;
  final int width;
  final int height;
  final String photographer;
  final String photographerUrl;
  final int photographerId;
  final String avgColor;
  final String original;
  final String alt;

  factory FavoriteModel.fromJson(Map<String, dynamic> json) => FavoriteModel(
    id: json["id"],
    width: json["width"],
    height: json["height"],
    photographerId: json["photographerId"],
    photographer: json["photographer"],
    photographerUrl: json["photographerUrl"],
    avgColor: json["avgColor"],
    original: json["original"],
    alt: json["alt"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "width": width,
    "height": height,
    "photographerId": photographerId,
    "photographer": photographer,
    "photographerUrl": photographerUrl,
    "avgColor": avgColor,
    "original": original,
    "alt": alt,
  };
}
