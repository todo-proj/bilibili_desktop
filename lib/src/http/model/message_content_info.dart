// To parse this JSON data, do
//
//     final messageContentInfo = messageContentInfoFromJson(jsonString);

import 'dart:convert';

MessageContentInfo messageContentInfoFromJson(String str) => MessageContentInfo.fromJson(json.decode(str));

String messageContentInfoToJson(MessageContentInfo data) => json.encode(data.toJson());

class MessageContentInfo {
  final List<Archive>? archive;
  final List<Article>? article;
  final List<Pgc>? pgc;

  MessageContentInfo({
    this.archive,
    this.article,
    this.pgc,
  });

  factory MessageContentInfo.fromJson(Map<String, dynamic> json) => MessageContentInfo(
    archive: json["archive"] == null
        ? []
        : List<Archive>.from(json["archive"].map((x) => Archive.fromJson(x))),
    article: json["article"] == null
        ? []
        : List<Article>.from(json["article"].map((x) => Article.fromJson(x))),
    pgc: json["pgc"] == null
        ? []
        : List<Pgc>.from(json["pgc"].map((x) => Pgc.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "archive": archive == null
        ? []
        : List<dynamic>.from(archive!.map((x) => x.toJson())),
    "article": article == null
        ? []
        : List<dynamic>.from(article!.map((x) => x.toJson())),
    "pgc": pgc == null
        ? []
        : List<dynamic>.from(pgc!.map((x) => x.toJson())),
  };
}

class Archive {
  final String bvid;
  final int aid;
  final String title;
  final String pic;
  final String param;
  final String uri;
  final String goto;
  final int duration;
  final String upName;
  final int view;
  final int danmaku;
  final int status;
  final int isStarted;

  Archive({
    required this.bvid,
    required this.aid,
    required this.title,
    required this.pic,
    required this.param,
    required this.uri,
    required this.goto,
    required this.duration,
    required this.upName,
    required this.view,
    required this.danmaku,
    required this.status,
    required this.isStarted,
  });

  factory Archive.fromJson(Map<String, dynamic> json) => Archive(
    bvid: json["bvid"],
    aid: json["aid"],
    title: json["title"],
    pic: json["pic"],
    param: json["param"],
    uri: json["uri"],
    goto: json["goto"],
    duration: json["duration"],
    upName: json["up_name"],
    view: json["view"],
    danmaku: json["danmaku"],
    status: json["status"],
    isStarted: json["is_started"],
  );

  Map<String, dynamic> toJson() => {
    "bvid": bvid,
    "aid": aid,
    "title": title,
    "pic": pic,
    "param": param,
    "uri": uri,
    "goto": goto,
    "duration": duration,
    "up_name": upName,
    "view": view,
    "danmaku": danmaku,
    "status": status,
    "is_started": isStarted,
  };
}

class Article {
  final int id;
  final String title;
  final String summary;
  final int templateId;
  final String upName;
  final List<String> imageUrls;
  final int viewNum;
  final int likeNum;
  final int replyNum;
  final int status;

  Article({
    required this.id,
    required this.title,
    required this.summary,
    required this.templateId,
    required this.upName,
    required this.imageUrls,
    required this.viewNum,
    required this.likeNum,
    required this.replyNum,
    required this.status,
  });

  factory Article.fromJson(Map<String, dynamic> json) => Article(
    id: json["id"],
    title: json["title"],
    summary: json["summary"],
    templateId: json["template_id"],
    upName: json["up_name"],
    imageUrls: List<String>.from(json["image_urls"].map((x) => x)),
    viewNum: json["view_num"],
    likeNum: json["like_num"],
    replyNum: json["reply_num"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "summary": summary,
    "template_id": templateId,
    "up_name": upName,
    "image_urls": List<dynamic>.from(imageUrls.map((x) => x)),
    "view_num": viewNum,
    "like_num": likeNum,
    "reply_num": replyNum,
    "status": status,
  };
}

class Pgc {
  final int epId;
  final String cover;
  final String title;
  final int duration;
  final int view;
  final int danmaku;
  final String url;

  Pgc({
    required this.epId,
    required this.cover,
    required this.title,
    required this.duration,
    required this.view,
    required this.danmaku,
    required this.url,
  });

  factory Pgc.fromJson(Map<String, dynamic> json) => Pgc(
    epId: json["ep_id"],
    cover: json["cover"],
    title: json["title"],
    duration: json["duration"],
    view: json["view"],
    danmaku: json["danmaku"],
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "ep_id": epId,
    "cover": cover,
    "title": title,
    "duration": duration,
    "view": view,
    "danmaku": danmaku,
    "url": url,
  };
}
