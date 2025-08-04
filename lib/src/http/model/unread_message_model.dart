// To parse this JSON data, do
//
//     final unreadMessageModel = unreadMessageModelFromJson(jsonString);

import 'dart:convert';

UnreadMessageModel unreadMessageModelFromJson(String str) => UnreadMessageModel.fromJson(json.decode(str));

String unreadMessageModelToJson(UnreadMessageModel data) => json.encode(data.toJson());

class UnreadMessageModel {
  final int at;
  final int coin;
  final int danmu;
  final int favorite;
  final int like;
  final int recvLike;
  final int recvReply;
  final int reply;
  final int sysMsg;
  final int sysMsgStyle;
  final int up;

  UnreadMessageModel({
    required this.at,
    required this.coin,
    required this.danmu,
    required this.favorite,
    required this.like,
    required this.recvLike,
    required this.recvReply,
    required this.reply,
    required this.sysMsg,
    required this.sysMsgStyle,
    required this.up,
  });

  factory UnreadMessageModel.fromJson(Map<String, dynamic> json) => UnreadMessageModel(
    at: json["at"],
    coin: json["coin"],
    danmu: json["danmu"],
    favorite: json["favorite"],
    like: json["like"],
    recvLike: json["recv_like"],
    recvReply: json["recv_reply"],
    reply: json["reply"],
    sysMsg: json["sys_msg"],
    sysMsgStyle: json["sys_msg_style"],
    up: json["up"],
  );

  Map<String, dynamic> toJson() => {
    "at": at,
    "coin": coin,
    "danmu": danmu,
    "favorite": favorite,
    "like": like,
    "recv_like": recvLike,
    "recv_reply": recvReply,
    "reply": reply,
    "sys_msg": sysMsg,
    "sys_msg_style": sysMsgStyle,
    "up": up,
  };
}
