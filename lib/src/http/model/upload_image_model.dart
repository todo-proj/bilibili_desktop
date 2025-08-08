// To parse this JSON data, do
//
//     final uploadImageModel = uploadImageModelFromJson(jsonString);

import 'dart:convert';

UploadImageModel uploadImageModelFromJson(String str) => UploadImageModel.fromJson(json.decode(str));

String uploadImageModelToJson(UploadImageModel data) => json.encode(data.toJson());

class UploadImageModel {
  final String imageUrl;
  final int imageWidth;
  final int imageHeight;

  UploadImageModel({
    required this.imageUrl,
    required this.imageWidth,
    required this.imageHeight,
  });

  factory UploadImageModel.fromJson(Map<String, dynamic> json) => UploadImageModel(
    imageUrl: json["image_url"],
    imageWidth: json["image_width"],
    imageHeight: json["image_height"],
  );

  Map<String, dynamic> toJson() => {
    "image_url": imageUrl,
    "image_width": imageWidth,
    "image_height": imageHeight,
  };
}
