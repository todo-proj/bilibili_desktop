// To parse this JSON data, do
//
//     final sessionMessageModel = sessionMessageModelFromJson(jsonString);

import 'dart:convert';

SessionMessageModel sessionMessageModelFromJson(String str) => SessionMessageModel.fromJson(json.decode(str));

String sessionMessageModelToJson(SessionMessageModel data) => json.encode(data.toJson());

class SessionMessageModel {
  final List<Message> messages;
  final int hasMore;
  final int minSeqno;
  final int maxSeqno;
  final List<EInfo> eInfos;

  SessionMessageModel({
    required this.messages,
    required this.hasMore,
    required this.minSeqno,
    required this.maxSeqno,
    required this.eInfos,
  });

  factory SessionMessageModel.fromJson(Map<String, dynamic> json) => SessionMessageModel(
    messages: List<Message>.from(json["messages"]?.map((x) => Message.fromJson(x)) ?? []),
    hasMore: json["has_more"],
    minSeqno: json["min_seqno"].toInt(),
    maxSeqno: json["max_seqno"],
    eInfos: List<EInfo>.from(json["e_infos"]?.map((x) => EInfo.fromJson(x)) ?? []),
  );

  Map<String, dynamic> toJson() => {
    "messages": List<dynamic>.from(messages.map((x) => x.toJson())),
    "has_more": hasMore,
    "min_seqno": minSeqno,
    "max_seqno": maxSeqno,
    "e_infos": List<dynamic>.from(eInfos.map((x) => x.toJson())),
  };
}

class EInfo {
  final String text;
  final String url;
  final int size;

  EInfo({
    required this.text,
    required this.url,
    required this.size,
  });

  factory EInfo.fromJson(Map<String, dynamic> json) => EInfo(
    text: json["text"],
    url: json["url"],
    size: json["size"],
  );

  Map<String, dynamic> toJson() => {
    "text": text,
    "url": url,
    "size": size,
  };
}

class Message {
  final int senderUid;
  final int receiverType;
  final int receiverId;
  final int msgType;
  final String content;
  final int msgSeqno;
  final int timestamp;
  final List<int> atUids;
  final double msgKey;
  final int msgStatus;
  final String notifyCode;
  final int? newFaceVersion;
  final int msgSource;

  Message({
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

  factory Message.fromJson(Map<String, dynamic> json) => Message(
    senderUid: json["sender_uid"],
    receiverType: json["receiver_type"],
    receiverId: json["receiver_id"],
    msgType: json["msg_type"],
    content: json["content"],
    msgSeqno: json["msg_seqno"],
    timestamp: json["timestamp"],
    atUids: List<int>.from(json["at_uids"].map((x) => x)),
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
    "at_uids": List<dynamic>.from(atUids.map((x) => x)),
    "msg_key": msgKey,
    "msg_status": msgStatus,
    "notify_code": notifyCode,
    "new_face_version": newFaceVersion,
    "msg_source": msgSource,
  };
}
