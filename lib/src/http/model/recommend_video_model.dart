// To parse this JSON data, do
//
//     final recommendVideoModel = recommendVideoModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

RecommendVideoModel recommendVideoModelFromJson(String str) => RecommendVideoModel.fromJson(json.decode(str));

String recommendVideoModelToJson(RecommendVideoModel data) => json.encode(data.toJson());

class RecommendVideoModel {
  List<Item> item;
  dynamic businessCard;
  dynamic floorInfo;
  dynamic userFeature;
  double preloadExposePct;
  double preloadFloorExposePct;
  int mid;

  RecommendVideoModel({
    required this.item,
    required this.businessCard,
    required this.floorInfo,
    required this.userFeature,
    required this.preloadExposePct,
    required this.preloadFloorExposePct,
    required this.mid,
  });

  factory RecommendVideoModel.fromJson(Map<String, dynamic> json) => RecommendVideoModel(
    item: List<Item>.from(json["item"].map((x) => Item.fromJson(x))),
    businessCard: json["business_card"],
    floorInfo: json["floor_info"],
    userFeature: json["user_feature"],
    preloadExposePct: json["preload_expose_pct"],
    preloadFloorExposePct: json["preload_floor_expose_pct"],
    mid: json["mid"],
  );

  Map<String, dynamic> toJson() => {
    "item": List<dynamic>.from(item.map((x) => x.toJson())),
    "business_card": businessCard,
    "floor_info": floorInfo,
    "user_feature": userFeature,
    "preload_expose_pct": preloadExposePct,
    "preload_floor_expose_pct": preloadFloorExposePct,
    "mid": mid,
  };
}

class Item {
  int id;
  String bvid;
  String cid;
  String uri;
  String pic;
  String title;
  int duration;
  int pubdate;
  Owner owner;
  Stat stat;
  dynamic avFeature;
  dynamic rcmdReason;
  String trackId;
  int pos;
  dynamic roomInfo;
  dynamic ogvInfo;
  dynamic businessInfo;
  int isStock;
  int enableVt;

  Item({
    required this.id,
    required this.bvid,
    required this.cid,
    required this.uri,
    required this.pic,
    required this.title,
    required this.duration,
    required this.pubdate,
    required this.owner,
    required this.stat,
    required this.avFeature,
    required this.rcmdReason,
    required this.trackId,
    required this.pos,
    required this.roomInfo,
    required this.ogvInfo,
    required this.businessInfo,
    required this.isStock,
    required this.enableVt,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    id: json["id"] ?? 0,
    bvid: json["bvid"],
    cid: json["cid"].toString(),
    uri: json["uri"] ?? "",
    pic: json["pic"],
    title: json["title"],
    duration: json["duration"],
    pubdate: json["pubdate"],
    owner: Owner.fromJson(json["owner"]),
    stat: Stat.fromJson(json["stat"]),
    avFeature: json["av_feature"],
    rcmdReason: json["rcmd_reason"],
    trackId: json["track_id"] ?? "",
    pos: json["pos"] ?? 0,
    roomInfo: json["room_info"],
    ogvInfo: json["ogv_info"],
    businessInfo: json["business_info"],
    isStock: json["is_stock"] ?? 0,
    enableVt: json["enable_vt"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "bvid": bvid,
    "cid": cid,
    "uri": uri,
    "pic": pic,
    "title": title,
    "duration": duration,
    "pubdate": pubdate,
    "owner": owner.toJson(),
    "stat": stat.toJson(),
    "av_feature": avFeature,
    "rcmd_reason": rcmdReason,
    "track_id": trackId,
    "pos": pos,
    "room_info": roomInfo,
    "ogv_info": ogvInfo,
    "business_info": businessInfo,
    "is_stock": isStock,
    "enable_vt": enableVt,
  };
}


class Owner {
  String mid;
  String name;
  String face;

  Owner({
    required this.mid,
    required this.name,
    required this.face,
  });

  factory Owner.fromJson(Map<String, dynamic> json) => Owner(
    mid: json["mid"].toString(),
    name: json["name"],
    face: json["face"],
  );

  Map<String, dynamic> toJson() => {
    "mid": mid,
    "name": name,
    "face": face,
  };
}

class Stat {
  int view;
  int like;
  int danmaku;
  int vt;

  Stat({
    required this.view,
    required this.like,
    required this.danmaku,
    required this.vt,
  });

  factory Stat.fromJson(Map<String, dynamic> json) => Stat(
    view: json["view"],
    like: json["like"],
    danmaku: json["danmaku"],
    vt: json["vt"],
  );

  Map<String, dynamic> toJson() => {
    "view": view,
    "like": like,
    "danmaku": danmaku,
    "vt": vt,
  };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
