// To parse this JSON data, do
//
//     final relationStatModel = relationStatModelFromJson(jsonString);

import 'dart:convert';

RelationStatModel relationStatModelFromJson(String str) => RelationStatModel.fromJson(json.decode(str));

String relationStatModelToJson(RelationStatModel data) => json.encode(data.toJson());

class RelationStatModel {
  int mid;
  int following;
  int whisper;
  int black;
  int follower;

  RelationStatModel({
    required this.mid,
    required this.following,
    required this.whisper,
    required this.black,
    required this.follower,
  });

  factory RelationStatModel.fromJson(Map<String, dynamic> json) => RelationStatModel(
    mid: json["mid"],
    following: json["following"],
    whisper: json["whisper"],
    black: json["black"],
    follower: json["follower"],
  );

  Map<String, dynamic> toJson() => {
    "mid": mid,
    "following": following,
    "whisper": whisper,
    "black": black,
    "follower": follower,
  };
}
