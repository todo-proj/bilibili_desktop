// To parse this JSON data, do
//
//     final sessionModel = sessionModelFromJson(jsonString);
// 聊天列表
import 'dart:convert';

SessionModel sessionModelFromJson(String str) => SessionModel.fromJson(json.decode(str));

String sessionModelToJson(SessionModel data) => json.encode(data.toJson());

class SessionModel {
  final List<SessionList> sessionList;
  final int hasMore;
  final bool antiDisturbCleaning;
  final int isAddressListEmpty;
  final Map<String, int>? systemMsg;
  final bool showLevel;

  SessionModel({
    required this.sessionList,
    required this.hasMore,
    required this.antiDisturbCleaning,
    required this.isAddressListEmpty,
    this.systemMsg,
    required this.showLevel,
  });

  factory SessionModel.fromJson(Map<String, dynamic> json) => SessionModel(
    sessionList: List<SessionList>.from(json["session_list"].map((x) => SessionList.fromJson(x))),
    hasMore: json["has_more"],
    antiDisturbCleaning: json["anti_disturb_cleaning"],
    isAddressListEmpty: json["is_address_list_empty"],
    systemMsg: Map.from(json["system_msg"] ?? {}).map((k, v) => MapEntry<String, int>(k, v)),
    showLevel: json["show_level"],
  );

  Map<String, dynamic> toJson() => {
    "session_list": List<dynamic>.from(sessionList.map((x) => x.toJson())),
    "has_more": hasMore,
    "anti_disturb_cleaning": antiDisturbCleaning,
    "is_address_list_empty": isAddressListEmpty,
    "system_msg": Map.from(systemMsg ?? {}).map((k, v) => MapEntry<String, dynamic>(k, v)),
    "show_level": showLevel,
  };
}

class SessionList {
  final int talkerId;
  final int sessionType;
  final int atSeqno;
  final int topTs;
  final String groupName;
  final String groupCover;
  final int isFollow;
  final int isDnd;
  final int ackSeqno;
  final int ackTs;
  final int sessionTs;
  final int unreadCount;
  final LastMsg lastMsg;
  final int groupType;
  final int canFold;
  final int status;
  final int maxSeqno;
  final int newPushMsg;
  final int setting;
  final int isGuardian;
  final int isIntercept;
  final int isTrust;
  final int systemMsgType;
  final AccountInfo? accountInfo;
  final int liveStatus;
  final int bizMsgUnreadCount;
  final dynamic userLabel;

  SessionList({
    required this.talkerId,
    required this.sessionType,
    required this.atSeqno,
    required this.topTs,
    required this.groupName,
    required this.groupCover,
    required this.isFollow,
    required this.isDnd,
    required this.ackSeqno,
    required this.ackTs,
    required this.sessionTs,
    required this.unreadCount,
    required this.lastMsg,
    required this.groupType,
    required this.canFold,
    required this.status,
    required this.maxSeqno,
    required this.newPushMsg,
    required this.setting,
    required this.isGuardian,
    required this.isIntercept,
    required this.isTrust,
    required this.systemMsgType,
    this.accountInfo,
    required this.liveStatus,
    required this.bizMsgUnreadCount,
    required this.userLabel,
  });

  factory SessionList.fromJson(Map<String, dynamic> json) => SessionList(
    talkerId: json["talker_id"],
    sessionType: json["session_type"],
    atSeqno: json["at_seqno"],
    topTs: json["top_ts"],
    groupName: json["group_name"],
    groupCover: json["group_cover"],
    isFollow: json["is_follow"],
    isDnd: json["is_dnd"],
    ackSeqno: json["ack_seqno"],
    ackTs: json["ack_ts"],
    sessionTs: json["session_ts"],
    unreadCount: json["unread_count"],
    lastMsg: LastMsg.fromJson(json["last_msg"]),
    groupType: json["group_type"],
    canFold: json["can_fold"],
    status: json["status"],
    maxSeqno: json["max_seqno"],
    newPushMsg: json["new_push_msg"],
    setting: json["setting"],
    isGuardian: json["is_guardian"],
    isIntercept: json["is_intercept"],
    isTrust: json["is_trust"],
    systemMsgType: json["system_msg_type"],
    accountInfo: json["account_info"] == null ? null : AccountInfo.fromJson(json["account_info"]),
    liveStatus: json["live_status"],
    bizMsgUnreadCount: json["biz_msg_unread_count"],
    userLabel: json["user_label"],
  );

  Map<String, dynamic> toJson() => {
    "talker_id": talkerId,
    "session_type": sessionType,
    "at_seqno": atSeqno,
    "top_ts": topTs,
    "group_name": groupName,
    "group_cover": groupCover,
    "is_follow": isFollow,
    "is_dnd": isDnd,
    "ack_seqno": ackSeqno,
    "ack_ts": ackTs,
    "session_ts": sessionTs,
    "unread_count": unreadCount,
    "last_msg": lastMsg.toJson(),
    "group_type": groupType,
    "can_fold": canFold,
    "status": status,
    "max_seqno": maxSeqno,
    "new_push_msg": newPushMsg,
    "setting": setting,
    "is_guardian": isGuardian,
    "is_intercept": isIntercept,
    "is_trust": isTrust,
    "system_msg_type": systemMsgType,
    "account_info": accountInfo?.toJson(),
    "live_status": liveStatus,
    "biz_msg_unread_count": bizMsgUnreadCount,
    "user_label": userLabel,
  };
}

class AccountInfo {
  final String name;
  final String picUrl;

  AccountInfo({
    required this.name,
    required this.picUrl,
  });

  factory AccountInfo.fromJson(Map<String, dynamic> json) => AccountInfo(
    name: json["name"],
    picUrl: json["pic_url"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "pic_url": picUrl,
  };
}

class LastMsg {
  final int senderUid;
  final int receiverType;
  final int receiverId;
  final int msgType;
  final String content;
  final int msgSeqno;
  final int timestamp;
  final dynamic atUids;
  final double msgKey;
  final int msgStatus;
  final String notifyCode;
  final int? newFaceVersion;
  final int msgSource;

  LastMsg({
    required this.senderUid,
    required this.receiverType,
    required this.receiverId,
    required this.msgType,
    required this.content,
    required this.msgSeqno,
    required this.timestamp,
    required this.atUids,
    required this.msgKey,
    required this.msgStatus,
    required this.notifyCode,
    this.newFaceVersion,
    required this.msgSource,
  });

  factory LastMsg.fromJson(Map<String, dynamic> json) => LastMsg(
    senderUid: json["sender_uid"],
    receiverType: json["receiver_type"],
    receiverId: json["receiver_id"],
    msgType: json["msg_type"],
    content: json["content"],
    msgSeqno: json["msg_seqno"],
    timestamp: json["timestamp"],
    atUids: json["at_uids"],
    msgKey: json["msg_key"]?.toDouble(),
    msgStatus: json["msg_status"],
    notifyCode: json["notify_code"],
    newFaceVersion: json["new_face_version"],
    msgSource: json["msg_source"],
  );

  Map<String, dynamic> toJson() => {
    "sender_uid": senderUid,
    "receiver_type": receiverType,
    "receiver_id": receiverId,
    "msg_type": msgType,
    "content": content,
    "msg_seqno": msgSeqno,
    "timestamp": timestamp,
    "at_uids": atUids,
    "msg_key": msgKey,
    "msg_status": msgStatus,
    "notify_code": notifyCode,
    "new_face_version": newFaceVersion,
    "msg_source": msgSource,
  };
}
