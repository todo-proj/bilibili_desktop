import 'dart:convert';

import 'package:bilibili_desktop/src/business/common/widget/common_tab_bar.dart';
import 'package:bilibili_desktop/src/business/message/page_data_request.dart';
import 'package:bilibili_desktop/src/http/network_manager.dart';
import 'package:bilibili_desktop/src/providers/api_provider.dart';
import 'package:bilibili_desktop/src/utils/logger.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'direct_message_view_model.g.dart';

@Riverpod(keepAlive: true)
class DirectMessageViewModel extends _$DirectMessageViewModel {
  static const String chat = 'chat';
  static const String reply = 'reply';
  static const String at = 'at';
  static const String like = 'like';

  final Map<String, PageDataRequest> _pageDataRequest = {
    chat: PageDataRequest(),
    reply: PageDataRequest(),
    at: PageDataRequest(),
    like: PageDataRequest(),
  };

  @override
  DirectMessageState build() {
    getMessageUnread();
    getSessions();
    return DirectMessageState(items: _generateTabBarItems(), currentTab: chat);
  }

  List<TabBarItem> _generateTabBarItems() {
    return [
      TabBarItem('聊天列表', chat),
      TabBarItem('回复我的', reply),
      TabBarItem('@我的', at),
      TabBarItem('收到的赞', like),
    ];
  }

  void changeTab(int index) {
    if (index == 0) {
      getSessions();
    }
  }

  void enterSessionSection(SessionData session) {
    debugPrint('进入会话, ${identityHashCode(session)}, ${state.pageIndex}');
    state = state.copyWith(currentSession: session, pageIndex: 1);
  }

  void exitSessionSection() {
    state = state.copyWith(currentSession: null, pageIndex: 0);
  }

  void getMessageUnread() async {
    try {
      final messageApi = ref.read(messageApiProvider);
      final unreadModel = await messageApi.getUnreadMsg().handle();
      final singleUnreadModel = await messageApi.getSingleUnreadMsg().handle();
      final items = state.items;
      final unreadCount =
          unreadModel.sysMsg +
          singleUnreadModel.unfollowUnread +
          singleUnreadModel.followUnread;
      state = state.copyWith(
        items: [
          items.first.copyWith(num: unreadCount.toString()),
          ...items.sublist(1),
        ],
      );
    } catch (e, s) {
      L.e(e, stackTrace: s);
    }
  }

  void getSessions() async {
    try {
      final sessions = await getSessionsRequest();
      state = state.copyWith(sessions: sessions);
    } catch (e, s) {
      L.e(e, stackTrace: s);
    }
  }

  Future<List<SessionData>> getSessionsRequest() async {
    final messageApi = ref.read(messageApiProvider);
    final api = ref.read(apiProvider);
    final sessions = await messageApi.getSessions().handle();
    final uids = sessions.sessionList.map((e) => e.talkerId).toList().join(',');
    final simpleUsers = await api.getMultiUserCards(uids).handle();
    List<SessionData> sessionDataList = [];
    for (var index = 0; index < sessions.sessionList.length; index++) {
      final session = sessions.sessionList[index];
      final simpleUser = simpleUsers.users[session.talkerId.toString()];
      final msgObj = jsonDecode(session.lastMsg.content);
      final lastMessage = msgObj['title'] ?? msgObj['content'] ?? msgObj['reply_content'];
      sessionDataList.add(
        SessionData(
          sessionTakerId: session.talkerId,
          sessionType: session.sessionType,
          unreadCount: session.unreadCount,
          lastMsg: lastMessage.replaceAll('\n', ' '),
          timestamp: session.lastMsg.timestamp,
          userFace: simpleUser?.face ?? session.accountInfo?.picUrl ?? '',
          userName: simpleUser?.name ?? session.accountInfo?.name ?? '',
          topTime: session.topTs
        ),
      );
    }
    sessionDataList.sort((a, b) => b.topTime.compareTo(a.topTime));
    return sessionDataList;
  }

  void getPageData() {
    final type = state.currentTab;
    switch (type) {
      case chat:
        getSessions();
        break;
    }
  }

  void topSession(int index, SessionData session) async{
    final messageApi = ref.read(messageApiProvider);
    final token = await NetworkManager.instance.getToken();
    final opType = session.isTop ? 1 : 0;
    try {
      await messageApi.setSessionTop(session.sessionTakerId, session.sessionType, opType, token, token).handle();
      final sessions = state.sessions.toList();
      sessions.remove(session);
      if (opType == 0) {
        final topTime = DateTime.now().microsecondsSinceEpoch;
        sessions.insert(0, session.copyWith(topTime: topTime));
      }else {
        final newSession = session.copyWith(topTime: 0);
        final firstNotTopSessionIndex = sessions.indexWhere((element) => element.topTime == 0);
        if (firstNotTopSessionIndex < 0) {
          sessions.add(newSession);
        }else {
          sessions.insert(firstNotTopSessionIndex, newSession);
        }
      }
      state = state.copyWith(sessions: sessions);
    }catch(e, s) {
      L.e(e, stackTrace: s);
    }
  }

  void updateSession(int index, SessionData session) async{
    final messageApi = ref.read(messageApiProvider);
    final token = await NetworkManager.instance.getToken();
    try {
      await messageApi.updateSessionRead(session.sessionTakerId, session.sessionType, token, token).handle();
      final sessions = state.sessions.toList();
      sessions[index] = session.copyWith(unreadCount: 0);
      state = state.copyWith(sessions: sessions);
      getMessageUnread();
    }catch(e, s) {
      L.e('updateSession: $e', stackTrace: s);
    }
  }

  void removeSession(int index, SessionData session) async{
    final messageApi = ref.read(messageApiProvider);
    final token = await NetworkManager.instance.getToken();
    try {
      await messageApi.removeSession(session.sessionTakerId, session.sessionType, token, token).handle();
      final sessions = state.sessions.toList();
      sessions.remove(session);
      state = state.copyWith(sessions: sessions);
      getMessageUnread();
    }catch(e, s) {
      L.e('removeSession: $e', stackTrace: s);
    }
  }

}

class DirectMessageState extends Equatable {
  final List<TabBarItem> items;
  final List<SessionData> sessions;
  final String currentTab;
  final int pageIndex;
  final SessionData? currentSession;

  const DirectMessageState({
    required this.items,
    this.sessions = const [],
    this.pageIndex = 0,
    required this.currentTab,
    this.currentSession
  });

  copyWith({
    List<TabBarItem>? items,
    List<SessionData>? sessions,
    String? currentTab,
    int? pageIndex,
    SessionData? currentSession,
  }) {
    return DirectMessageState(
      items: items ?? this.items,
      sessions: sessions ?? this.sessions,
      currentTab: currentTab ?? this.currentTab,
      pageIndex: pageIndex ?? this.pageIndex,
      currentSession: currentSession ?? this.currentSession,
    );
  }

  @override
  List<Object?> get props => [items, sessions, currentTab, pageIndex, currentSession];
}

class SessionData extends Equatable{
  final int sessionTakerId;
  final int sessionType;
  final int unreadCount;
  final String lastMsg;
  final String userName;
  final String userFace;
  final int timestamp;
  //置顶时间
  final int topTime;

  bool get isTop {
    return topTime > 0;
  }

  SessionData({
    required this.unreadCount,
    required this.sessionTakerId,
    required this.sessionType,
    required this.lastMsg,
    required this.userName,
    required this.userFace,
    required this.timestamp,
    required this.topTime,
  });

  SessionData copyWith({
    int? unreadCount,
    int? sessionTakerId,
    int? sessionType,
    String? lastMsg,
    String? userName,
    String? userFace,
    int? timestamp,
    int? topTime,
  }) {
    return SessionData(
      unreadCount: unreadCount ?? this.unreadCount,
      sessionTakerId: sessionTakerId ?? this.sessionTakerId,
      sessionType: sessionType ?? this.sessionType,
      lastMsg: lastMsg ?? this.lastMsg,
      userName: userName ?? this.userName,
      userFace: userFace ?? this.userFace,
      timestamp: timestamp ?? this.timestamp,
      topTime: topTime ?? this.topTime,
    );
  }

  toJson() {
    return {
      'sessionTakerId': sessionTakerId,
      'sessionType': sessionType,
      'unreadCount': unreadCount,
      'lastMsg': lastMsg,
      'userName': userName,
      'userFace': userFace,
      'timestamp': timestamp,
      'topTime': topTime,
    };
  }

  @override
  List<Object?> get props => [topTime, timestamp, lastMsg, userFace, userName, unreadCount, sessionType, sessionTakerId];
}
