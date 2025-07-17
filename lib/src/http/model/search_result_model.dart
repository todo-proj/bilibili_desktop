// To parse this JSON data, do
//
//     final searchAllModel = searchAllModelFromJson(jsonString);

import 'dart:convert';

SearchResultModel searchAllModelFromJson(String str) => SearchResultModel.fromJson(json.decode(str));

String searchAllModelToJson(SearchResultModel data) => json.encode(data.toJson());

class SearchResultModel {
  final String seid;
  final int page;
  final int pageSize;
  final int numResults;
  final int numPages;
  final Map<String, PageInfo> pageInfo;
  final Map<String, int> topTlist;
  final List<String> showModuleList;
  final List<Result> result;

  SearchResultModel({
    required this.seid,
    required this.page,
    required this.pageSize,
    required this.numResults,
    required this.numPages,
    required this.pageInfo,
    required this.topTlist,
    required this.showModuleList,
    required this.result,
  });

  factory SearchResultModel.fromJson(Map<String, dynamic> json) => SearchResultModel(
    seid: json["seid"],
    page: json["page"],
    pageSize: json["pagesize"],
    numResults: json["numResults"],
    numPages: json["numPages"],
    pageInfo: Map.from(json["pageinfo"]).map((k, v) => MapEntry<String, PageInfo>(k, PageInfo.fromJson(v))),
    topTlist: Map.from(json["top_tlist"]).map((k, v) => MapEntry<String, int>(k, v)),
    showModuleList: List<String>.from(json["show_module_list"].map((x) => x)),
    result: List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "seid": seid,
    "page": page,
    "pagesize": pageSize,
    "numResults": numResults,
    "numPages": numPages,
    "pageinfo": Map.from(pageInfo).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
    "top_tlist": Map.from(topTlist).map((k, v) => MapEntry<String, dynamic>(k, v)),
    "show_module_list": List<dynamic>.from(showModuleList.map((x) => x)),
    "result": List<dynamic>.from(result.map((x) => x.toJson())),
  };
}

class PageInfo {
  final int numResults;
  final int total;
  final int pages;

  PageInfo({
    required this.numResults,
    required this.total,
    required this.pages,
  });

  factory PageInfo.fromJson(Map<String, dynamic> json) => PageInfo(
    numResults: json["numResults"],
    total: json["total"],
    pages: json["pages"],
  );

  Map<String, dynamic> toJson() => {
    "numResults": numResults,
    "total": total,
    "pages": pages,
  };
}

class Result {
  final String resultType;
  final List<Datum> data;

  Result({
    required this.resultType,
    required this.data,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    resultType: json["result_type"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "result_type": resultType,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  final String type;
  final int mid;
  final String? uname;
  final String? usign;
  final int? fans;
  final int? videos;
  final String? upic;
  final String? verifyInfo;
  final int? level;
  final int? gender;
  final int? isUpuser;
  final int? isLive;
  final int? roomId;
  final List<Re>? res;
  final OfficialVerify? officialVerify;
  final List<String> hitColumns;
  final int? id;
  final String? author;
  final String? typeid;
  final String? typename;
  final String? arcurl;
  final int? aid;
  final String? bvid;
  final String? title;
  final String? description;
  final String? arcrank;
  final String? pic;
  final int? play;
  final int? videoReview;
  final int? favorites;
  final String? tag;
  final int? review;
  final int? pubdate;
  final int? senddate;
  final String? duration;
  final bool? badgepay;
  final String? viewType;
  final int? isPay;
  final int? isUnionVideo;
  final dynamic recTags;
  final List<dynamic>? newRecTags;
  final int? rankScore;

  Datum({
    required this.type,
    required this.mid,
    this.uname,
    this.usign,
    this.fans,
    this.videos,
    this.upic,
    this.verifyInfo,
    this.level,
    this.gender,
    this.isUpuser,
    this.isLive,
    this.roomId,
    this.res,
    this.officialVerify,
    required this.hitColumns,
    this.id,
    this.author,
    this.typeid,
    this.typename,
    this.arcurl,
    this.aid,
    this.bvid,
    this.title,
    this.description,
    this.arcrank,
    this.pic,
    this.play,
    this.videoReview,
    this.favorites,
    this.tag,
    this.review,
    this.pubdate,
    this.senddate,
    this.duration,
    this.badgepay,
    this.viewType,
    this.isPay,
    this.isUnionVideo,
    this.recTags,
    this.newRecTags,
    this.rankScore,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    type: json["type"],
    mid: json["mid"] ?? 0,
    uname: json["uname"],
    usign: json["usign"],
    fans: json["fans"],
    videos: json["videos"],
    upic: json["upic"],
    verifyInfo: json["verify_info"],
    level: json["level"],
    gender: json["gender"],
    isUpuser: json["is_upuser"],
    isLive: json["is_live"],
    roomId: json["room_id"],
    res: json["res"] == null ? [] : List<Re>.from(json["res"]!.map((x) => Re.fromJson(x))),
    officialVerify: json["official_verify"] == null ? null : OfficialVerify.fromJson(json["official_verify"]),
    hitColumns: List<String>.from((json["hit_columns"] ?? []).map((x) => x)),
    id: json["id"],
    author: json["author"],
    typeid: json["typeid"],
    typename: json["typename"],
    arcurl: json["arcurl"],
    aid: json["aid"],
    bvid: json["bvid"],
    title: json["title"],
    description: json["description"],
    arcrank: json["arcrank"],
    pic: json["pic"],
    play: json["play"],
    videoReview: json["video_review"],
    favorites: json["favorites"],
    tag: json["tag"],
    review: json["review"],
    pubdate: json["pubdate"],
    senddate: json["senddate"],
    duration: json["duration"],
    badgepay: json["badgepay"],
    viewType: json["view_type"],
    isPay: json["is_pay"],
    isUnionVideo: json["is_union_video"],
    recTags: json["rec_tags"],
    newRecTags: json["new_rec_tags"] == null ? [] : List<dynamic>.from(json["new_rec_tags"]!.map((x) => x)),
    rankScore: json["rank_score"],
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "mid": mid,
    "uname": uname,
    "usign": usign,
    "fans": fans,
    "videos": videos,
    "upic": upic,
    "verify_info": verifyInfo,
    "level": level,
    "gender": gender,
    "is_upuser": isUpuser,
    "is_live": isLive,
    "room_id": roomId,
    "res": res == null ? [] : List<dynamic>.from(res!.map((x) => x.toJson())),
    "official_verify": officialVerify?.toJson(),
    "hit_columns": List<dynamic>.from(hitColumns.map((x) => x)),
    "id": id,
    "author": author,
    "typeid": typeid,
    "typename": typename,
    "arcurl": arcurl,
    "aid": aid,
    "bvid": bvid,
    "title": title,
    "description": description,
    "arcrank": arcrank,
    "pic": pic,
    "play": play,
    "video_review": videoReview,
    "favorites": favorites,
    "tag": tag,
    "review": review,
    "pubdate": pubdate,
    "senddate": senddate,
    "duration": duration,
    "badgepay": badgepay,
    "view_type": viewType,
    "is_pay": isPay,
    "is_union_video": isUnionVideo,
    "rec_tags": recTags,
    "new_rec_tags": newRecTags == null ? [] : List<dynamic>.from(newRecTags!.map((x) => x)),
    "rank_score": rankScore,
  };
}

class OfficialVerify {
  final int type;
  final String desc;

  OfficialVerify({
    required this.type,
    required this.desc,
  });

  factory OfficialVerify.fromJson(Map<String, dynamic> json) => OfficialVerify(
    type: json["type"],
    desc: json["desc"],
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "desc": desc,
  };
}

class Re {
  final int aid;
  final String bvid;
  final String title;
  final int pubdate;
  final String arcurl;
  final String pic;
  final String play;
  final int dm;
  final int coin;
  final int fav;
  final String desc;
  final String duration;
  final int isPay;
  final int isUnionVideo;

  Re({
    required this.aid,
    required this.bvid,
    required this.title,
    required this.pubdate,
    required this.arcurl,
    required this.pic,
    required this.play,
    required this.dm,
    required this.coin,
    required this.fav,
    required this.desc,
    required this.duration,
    required this.isPay,
    required this.isUnionVideo,
  });

  factory Re.fromJson(Map<String, dynamic> json) => Re(
    aid: json["aid"],
    bvid: json["bvid"],
    title: json["title"],
    pubdate: json["pubdate"],
    arcurl: json["arcurl"],
    pic: json["pic"],
    play: json["play"],
    dm: json["dm"],
    coin: json["coin"],
    fav: json["fav"],
    desc: json["desc"],
    duration: json["duration"],
    isPay: json["is_pay"],
    isUnionVideo: json["is_union_video"],
  );

  Map<String, dynamic> toJson() => {
    "aid": aid,
    "bvid": bvid,
    "title": title,
    "pubdate": pubdate,
    "arcurl": arcurl,
    "pic": pic,
    "play": play,
    "dm": dm,
    "coin": coin,
    "fav": fav,
    "desc": desc,
    "duration": duration,
    "is_pay": isPay,
    "is_union_video": isUnionVideo,
  };
}
