// To parse this JSON data, do
//
//     final replyMessageModel = replyMessageModelFromJson(jsonString);

import 'dart:convert';

ReplyMessageModel replyMessageModelFromJson(String str) => ReplyMessageModel.fromJson(json.decode(str));

String replyMessageModelToJson(ReplyMessageModel data) => json.encode(data.toJson());

class ReplyMessageModel {
  final Cursor cursor;
  final List<ItemElement> items;
  final int lastViewAt;

  ReplyMessageModel({
    required this.cursor,
    required this.items,
    required this.lastViewAt,
  });

  factory ReplyMessageModel.fromJson(Map<String, dynamic> json) => ReplyMessageModel(
    cursor: Cursor.fromJson(json["cursor"]),
    items: List<ItemElement>.from(json["items"].map((x) => ItemElement.fromJson(x))),
    lastViewAt: json["last_view_at"],
  );

  Map<String, dynamic> toJson() => {
    "cursor": cursor.toJson(),
    "items": List<dynamic>.from(items.map((x) => x.toJson())),
    "last_view_at": lastViewAt,
  };
}

class Cursor {
  final bool isEnd;
  final int id;
  final int time;

  Cursor({
    required this.isEnd,
    required this.id,
    required this.time,
  });

  factory Cursor.fromJson(Map<String, dynamic> json) => Cursor(
    isEnd: json["is_end"],
    id: json["id"],
    time: json["time"],
  );

  Map<String, dynamic> toJson() => {
    "is_end": isEnd,
    "id": id,
    "time": time,
  };
}

class ItemElement {
  final int id;
  final User user;
  final ItemItem item;
  final int counts;
  final int isMulti;
  final int replyTime;

  ItemElement({
    required this.id,
    required this.user,
    required this.item,
    required this.counts,
    required this.isMulti,
    required this.replyTime,
  });

  factory ItemElement.fromJson(Map<String, dynamic> json) => ItemElement(
    id: json["id"],
    user: User.fromJson(json["user"]),
    item: ItemItem.fromJson(json["item"]),
    counts: json["counts"],
    isMulti: json["is_multi"],
    replyTime: json["reply_time"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user": user.toJson(),
    "item": item.toJson(),
    "counts": counts,
    "is_multi": isMulti,
    "reply_time": replyTime,
  };
}

class ItemItem {
  final double subjectId;
  final int rootId;
  final int sourceId;
  final int targetId;
  final String type;
  final int businessId;
  final String business;
  final String title;
  final String desc;
  final String image;
  final String uri;
  final String nativeUri;
  final String detailTitle;
  final String rootReplyContent;
  final String sourceContent;
  final String targetReplyContent;
  final List<dynamic> atDetails;
  final List<dynamic> topicDetails;
  final bool hideReplyButton;
  final bool hideLikeButton;
  final int likeState;
  final dynamic danmu;
  final String message;

  ItemItem({
    required this.subjectId,
    required this.rootId,
    required this.sourceId,
    required this.targetId,
    required this.type,
    required this.businessId,
    required this.business,
    required this.title,
    required this.desc,
    required this.image,
    required this.uri,
    required this.nativeUri,
    required this.detailTitle,
    required this.rootReplyContent,
    required this.sourceContent,
    required this.targetReplyContent,
    required this.atDetails,
    required this.topicDetails,
    required this.hideReplyButton,
    required this.hideLikeButton,
    required this.likeState,
    required this.danmu,
    required this.message,
  });

  factory ItemItem.fromJson(Map<String, dynamic> json) => ItemItem(
    subjectId: json["subject_id"]?.toDouble(),
    rootId: json["root_id"],
    sourceId: json["source_id"],
    targetId: json["target_id"],
    type: json["type"],
    businessId: json["business_id"],
    business: json["business"],
    title: json["title"],
    desc: json["desc"],
    image: json["image"],
    uri: json["uri"],
    nativeUri: json["native_uri"],
    detailTitle: json["detail_title"],
    rootReplyContent: json["root_reply_content"],
    sourceContent: json["source_content"],
    targetReplyContent: json["target_reply_content"],
    atDetails: List<dynamic>.from(json["at_details"].map((x) => x)),
    topicDetails: List<dynamic>.from(json["topic_details"].map((x) => x)),
    hideReplyButton: json["hide_reply_button"],
    hideLikeButton: json["hide_like_button"],
    likeState: json["like_state"],
    danmu: json["danmu"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "subject_id": subjectId,
    "root_id": rootId,
    "source_id": sourceId,
    "target_id": targetId,
    "type": type,
    "business_id": businessId,
    "business": business,
    "title": title,
    "desc": desc,
    "image": image,
    "uri": uri,
    "native_uri": nativeUri,
    "detail_title": detailTitle,
    "root_reply_content": rootReplyContent,
    "source_content": sourceContent,
    "target_reply_content": targetReplyContent,
    "at_details": List<dynamic>.from(atDetails.map((x) => x)),
    "topic_details": List<dynamic>.from(topicDetails.map((x) => x)),
    "hide_reply_button": hideReplyButton,
    "hide_like_button": hideLikeButton,
    "like_state": likeState,
    "danmu": danmu,
    "message": message,
  };
}

class User {
  final int mid;
  final int fans;
  final String nickname;
  final String avatar;
  final String midLink;
  final bool follow;

  User({
    required this.mid,
    required this.fans,
    required this.nickname,
    required this.avatar,
    required this.midLink,
    required this.follow,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    mid: json["mid"],
    fans: json["fans"],
    nickname: json["nickname"],
    avatar: json["avatar"],
    midLink: json["mid_link"],
    follow: json["follow"],
  );

  Map<String, dynamic> toJson() => {
    "mid": mid,
    "fans": fans,
    "nickname": nickname,
    "avatar": avatar,
    "mid_link": midLink,
    "follow": follow,
  };
}
