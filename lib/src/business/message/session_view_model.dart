import 'dart:convert';
import 'dart:io';

import 'package:bilibili_desktop/src/business/message/direct_message_view_model.dart';
import 'package:bilibili_desktop/src/business/message/message_item.dart' show Message, MessageType;
import 'package:bilibili_desktop/src/business/user/user_center.dart';
import 'package:bilibili_desktop/src/http/network_manager.dart';
import 'package:bilibili_desktop/src/providers/api_provider.dart';
import 'package:bilibili_desktop/src/utils/logger.dart';
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

import 'message_item.dart' show Message;

part 'session_view_model.g.dart';

@riverpod
class SessionViewModel extends _$SessionViewModel {
  @override
  SessionState build(SessionData sessionData) {
    ref.onCancel((){});
    ref.onResume((){});
    requestSessionMessages();
    return SessionState.sessionData(sessionData);
  }

  void sendText(String msg) async{
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
      if (!response.isSuccess) {
        // TODO toast
      }
    }catch(e, s) {
      L.e(e, stackTrace: s);
    }
  }

  Future<bool> requestSessionMessages([int? endCursor]) async{
    final messageApi = ref.read(messageApiProvider);
    final token = await NetworkManager.instance.getToken();
    final userFace = ref.read(userCenterProviderProvider.select((value) => value.face));
    try {
      final result = await messageApi.fetchSessionMessage(state.talkerId, 1, endCursor: endCursor, size: 5).handle();
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

        dynamic content = jsonDecode(e.content);
        String text = content['content'] ?? '';
        bool isSelf = e.senderUid != state.talkerId;
        double imageAspectRatio = 1;
        if (content['width'] != null && content['height'] != null) {
          imageAspectRatio = (content['width'] as int) / (content['height'] as int);
        }
        List<(String, String)> texts = [];
        if (text.isNotEmpty) {
          if (result.eInfos.isNotEmpty) {
            int startIndex = 0;
            result.eInfos.forEachIndexed((index, info){
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
        messages.add(Message(texts: texts, type: text.isNotEmpty ? MessageType.text : MessageType.image,
            imageUrl: content['url'], imageAspectRatio: imageAspectRatio,
            face: isSelf ? userFace : state.userFace,
            messageId: e.msgSeqno, isSelf: isSelf));
      });

      state = state.copyWith(
        messages: [...state.messages, ...messages.reversed],
        hasMore: result.hasMore > 0,
      );
      return true;
    }catch(e, s) {
      L.e(e, stackTrace: s);
      return false;
    }
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
        return '${twoDigits(hour)}, ${twoDigits(minute)}';
      } else {
        // 同年不同天：显示月/日 + 时间（如 "04/05 09:05"）
        return '${twoDigits(month)}月${twoDigits(day)}日 ${twoDigits(hour)}:${twoDigits(minute)}';
      }
    } else {
      // 不同年：显示年/月/日 + 时间（如 "2023-04-05 09:05"）
      return '$year年${twoDigits(month)}月${twoDigits(day)}日 ${twoDigits(hour)}:${twoDigits(minute)}';
    }
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