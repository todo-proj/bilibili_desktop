import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:bilibili_desktop/src/business/message/direct_message_view_model.dart';
import 'package:bilibili_desktop/src/business/message/message_item.dart' show Message, MessageType, MessageText, MessageImage, MessageLink;
import 'package:bilibili_desktop/src/business/user/user_center.dart';
import 'package:bilibili_desktop/src/http/api_response.dart';
import 'package:bilibili_desktop/src/http/model/message_content_info.dart' show Archive;
import 'package:bilibili_desktop/src/http/model/session_message_model.dart' as session_model;
import 'package:bilibili_desktop/src/http/model/video_info_model.dart';
import 'package:bilibili_desktop/src/http/network_manager.dart';
import 'package:bilibili_desktop/src/providers/api_provider.dart';
import 'package:bilibili_desktop/src/utils/logger.dart';
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

part 'session_view_model.g.dart';

@riverpod
class SessionViewModel extends _$SessionViewModel {

  Timer? _fetchMessageTimer;
  int _maxSeqno = 0;

  @override
  SessionState build(SessionData sessionData) {
    ref.onCancel((){
      _cancelFetchMessageTimer();
    });
    refresh(true);
    return SessionState.sessionData(sessionData);
  }

  void sendText(String msg) async{
    if (msg.isEmpty) return;
    final content = jsonEncode({
      'content': msg,
    });
    _sendPrivateMessage(content);
  }

  void sentImage() async{
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'png', 'gif'],
    );
    if(result != null) {
      final path = result.files.single.path!;
      final api = ref.read(apiProvider);
      final token = await NetworkManager.instance.getToken();
      final uploadRes = await api.uploadBfs(File(path), 'daily', token).handle();
      final content = jsonEncode({
        "url": uploadRes.imageUrl,
        "original": 1,
      });
      _sendPrivateMessage(content, msgType: 2);
    }
  }

  void _sendPrivateMessage(String content, {int msgType = 1}) async{
    final messageApi = ref.read(messageApiProvider);
    final user = ref.read(userCenterProviderProvider);
    final token = await NetworkManager.instance.getToken();
    final uuid = Uuid();
    try {
      final response = await messageApi.sendPrivateMsg(int.parse(user.mid), state.talkerId, 1, msgType, uuid.v4(), DateTime.now().millisecondsSinceEpoch, content, token, token);
      if (response.isSuccess) {
        requestSessionMessages(beginCursor: _maxSeqno);
      }else {
        SmartDialog.showToast(response.message, alignment: Alignment.center);
      }
    }catch(e, s) {
      L.e(e, stackTrace: s);
    }
  }

  Future<bool> refresh([bool refresh = false]) async{
    _cancelFetchMessageTimer();
    final res = await requestSessionMessages(endCursor: refresh ? 0 : _findValidMessage(state.messages).messageId);
    _createFetchMessageTimer();
    return res;
  }

  Future<bool> requestSessionMessages({int? endCursor, int? beginCursor}) async{
    final messageApi = ref.read(messageApiProvider);
    final api = ref.read(apiProvider);
    final token = await NetworkManager.instance.getToken();
    final userFace = ref.read(userCenterProviderProvider.select((value) => value.face));
    try {
      final result = await messageApi.fetchSessionMessage(state.talkerId, 1,
          endCursor: endCursor, size: 5, beginCursor: beginCursor).handle();
      if(result.maxSeqno > _maxSeqno) {
        _maxSeqno = result.maxSeqno;
      }
      //找出整个列表中的msg_type == 7的元素
      final linkMessages = result.messages.where((e)=>e.msgType == 7);
      final ids = linkMessages
          .map((e) => jsonDecode(e.content)['id'])
          .where((e)=> e != null)
          .join(',');

      List<Archive> videoResults = [];
      if (ids.isNotEmpty) {
        final videoResponse = await messageApi.getMessageContentInfo(aids: ids).handle();
        videoResults = videoResponse.archive ?? [];
      }
      final List<Message> messages = [];
      int lastMessageTime = 0;
      result.messages.reversed.forEachIndexed((index, e){

        if (index == 0) {
          messages.add(Message.time(content: _formatTimestamp(e.timestamp)));
          lastMessageTime = e.timestamp;
        }else {
          if ((lastMessageTime - e.timestamp).abs() > 300) {
            messages.add(Message.time(content:  _formatTimestamp(e.timestamp)));
            lastMessageTime = e.timestamp;
          }
        }
        final message = _buildMessageItem(e, result.eInfos, userFace, videoResults);
        if (message != null) {
          messages.add(message);
        }
      });
      if (messages.isEmpty) {
        return true;
      }
      if (endCursor != null) {
        state = state.copyWith(
          messages: [...state.messages, ...messages.reversed],
          hasMore: result.hasMore > 0,
        );
      }else {
        state = state.copyWith(
          messages: [...messages.reversed, ...state.messages],
          hasMore: result.hasMore > 0,
        );
      }

      return true;
    }catch(e, s) {
      L.e(e, stackTrace: s);
      return false;
    }
  }

  void _createFetchMessageTimer() {
    _fetchMessageTimer = Timer.periodic(const Duration(seconds: 20), (timer) {
      requestSessionMessages(beginCursor: _maxSeqno);
    });
  }

  void _cancelFetchMessageTimer() {
    _fetchMessageTimer?.cancel();
    _fetchMessageTimer = null;
  }

  Message _findValidMessage(List<Message> messages) {
    for(int i = messages.length - 1; i >= 0; i--) {
      final message = messages[i];
      if (message.isValid) {
        return message;
      }
    }
    throw Exception('No valid message found');
  }

  String _formatTimestamp(int timestamp) {
    final time = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    String twoDigits(int n) => n.toString().padLeft(2, '0');

    final int year = time.year;
    final int month = time.month;
    final int day = time.day;
    final int hour = time.hour;
    final int minute = time.minute;

    if (year == DateTime.now().year) {
      if (day == DateTime.now().day) {
        // 今天的消息：只显示时间（如 "09:05"）
        return '${twoDigits(hour)}:${twoDigits(minute)}';
      } else {
        // 同年不同天：显示月/日 + 时间（如 "04/05 09:05"）
        return '${twoDigits(month)}月${twoDigits(day)}日 ${twoDigits(hour)}:${twoDigits(minute)}';
      }
    } else {
      // 不同年：显示年/月/日 + 时间（如 "2023-04-05 09:05"）
      return '$year年${twoDigits(month)}月${twoDigits(day)}日 ${twoDigits(hour)}:${twoDigits(minute)}';
    }
  }

  Message? _buildMessageItem(session_model.Message e, List<session_model.EInfo> eInfos, String userFace, List<Archive> videoList) {
    final msgType = e.msgType;
    dynamic content = jsonDecode(e.content);
    bool isSelf = e.senderUid != state.talkerId;

    switch (msgType) {
      //文字
      case 1:
        String text = content['content'] ?? '';
        List<(String, String)> texts = [];
        if (text.isNotEmpty) {
          if (eInfos.isNotEmpty) {
            int startIndex = 0;
            eInfos.forEachIndexed((index, info){
              int emojiIndex = text.indexOf(info.text, startIndex);
              if (emojiIndex >= 0) {
                texts.add((text.substring(startIndex, emojiIndex), ''));
                texts.add(('', info.url));
                startIndex = emojiIndex + info.text.length;
              }
            });
          }else {
            texts.add((text, ''));
          }
        }
        return Message(data: MessageText(texts: texts), type: MessageType.text,
            face: isSelf ? userFace : state.userFace,
            messageId: e.msgSeqno, isSelf: isSelf);
        //图片
      case 2:
        double imageAspectRatio = 1;
        if (content['width'] != null && content['height'] != null) {
          imageAspectRatio = (content['width'] as int) / (content['height'] as int);
        }
        return Message(data: MessageImage(imageUrl: content['url'], imageAspectRatio: imageAspectRatio,), type: MessageType.image,
            face: isSelf ? userFace : state.userFace,
            messageId: e.msgSeqno, isSelf: isSelf);
        //链接
      case 7:
        final id = content['id'];
        final thumb = content['thumb'];
        final title = content['title'];
        final video = videoList.firstWhereOrNull((e) => e.aid == id);
        return Message(data: MessageLink(title: video?.title ?? title, id: id, thumb: video?.pic ?? thumb, bvid: video?.bvid ?? '',
            duration: video?.duration ?? 0, reply: video?.danmaku ?? 0),
            type: MessageType.link,
            face: isSelf ? userFace : state.userFace,
            messageId: e.msgSeqno, isSelf: isSelf);
    }
    return null;
  }
}


class SessionState extends Equatable{
  final int talkerId;
  final String userName;
  final String userFace;
  final List<Message> messages;
  final bool hasMore;

  const SessionState({
    required this.talkerId,
    required this.userName,
    required this.userFace,
    this.messages = const [],
    this.hasMore = true,
  });

  factory SessionState.sessionData(SessionData sessionData) {
    return SessionState(
      talkerId: sessionData.sessionTakerId,
      userName: sessionData.userName,
      userFace: sessionData.userFace,
    );
  }

  SessionState copyWith({
    int? talkerId,
    String? userName,
    String? userFace,
    List<Message>? messages,
    bool? hasMore,
  }) {
    return SessionState(
      talkerId: talkerId ?? this.talkerId,
      userName: userName ?? this.userName,
      userFace: userFace ?? this.userFace,
      messages: messages ?? this.messages,
      hasMore: hasMore ?? this.hasMore,
    );
  }

  @override
  List<Object?> get props => [talkerId, userName, userFace, messages, hasMore];
}