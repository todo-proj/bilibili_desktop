// To parse this JSON data, do
//
//     final singleUnreadMessageModel = singleUnreadMessageModelFromJson(jsonString);

import 'dart:convert';

SingleUnreadMessageModel singleUnreadMessageModelFromJson(String str) => SingleUnreadMessageModel.fromJson(json.decode(str));

String singleUnreadMessageModelToJson(SingleUnreadMessageModel data) => json.encode(data.toJson());

class SingleUnreadMessageModel {
  final int unfollowUnread;
  final int followUnread;
  final int unfollowPushMsg;
  final int dustbinPushMsg;
  final int dustbinUnread;
  final int bizMsgUnfollowUnread;
  final int bizMsgFollowUnread;
  final int customUnread;

  SingleUnreadMessageModel({
    required this.unfollowUnread,
    required this.followUnread,
    required this.unfollowPushMsg,
    required this.dustbinPushMsg,
    required this.dustbinUnread,
    required this.bizMsgUnfollowUnread,
    required this.bizMsgFollowUnread,
    required this.customUnread,
  });

  factory SingleUnreadMessageModel.fromJson(Map<String, dynamic> json) => SingleUnreadMessageModel(
    unfollowUnread: json["unfollow_unread"],
    followUnread: json["follow_unread"],
    unfollowPushMsg: json["unfollow_push_msg"],
    dustbinPushMsg: json["dustbin_push_msg"],
    dustbinUnread: json["dustbin_unread"],
    bizMsgUnfollowUnread: json["biz_msg_unfollow_unread"],
    bizMsgFollowUnread: json["biz_msg_follow_unread"],
    customUnread: json["custom_unread"],
  );

  Map<String, dynamic> toJson() => {
    "unfollow_unread": unfollowUnread,
    "follow_unread": followUnread,
    "unfollow_push_msg": unfollowPushMsg,
    "dustbin_push_msg": dustbinPushMsg,
    "dustbin_unread": dustbinUnread,
    "biz_msg_unfollow_unread": bizMsgUnfollowUnread,
    "biz_msg_follow_unread": bizMsgFollowUnread,
    "custom_unread": customUnread,
  };
}
