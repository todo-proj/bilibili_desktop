// To parse this JSON data, do
//
//     final relationStatModel = relationStatModelFromJson(jsonString);

import 'dart:convert';

RelationStatModel relationStatModelFromJson(String str) => RelationStatModel.fromJson(json.decode(str));

String relationStatModelToJson(RelationStatModel data) => json.encode(data.toJson());

class RelationStatModel {
  String mid;
  String following;
  String whisper;
  String black;
  String follower;

  RelationStatModel({
    required this.mid,
    required this.following,
    required this.whisper,
    required this.black,
    required this.follower,
  });

  factory RelationStatModel.fromJson(Map<String, dynamic> json) => RelationStatModel(
    mid: json["mid"].toString(),
    following: json["following"].toString(),
    whisper: json["whisper"].toString(),
    black: json["black"].toString(),
    follower: json["follower"].toString(),
  );

  Map<String, dynamic> toJson() => {
    "mid": mid,
    "following": following,
    "whisper": whisper,
    "black": black,
    "follower": follower,
  };
}
