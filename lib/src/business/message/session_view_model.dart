import 'package:bilibili_desktop/src/business/message/direct_message_view_model.dart';
import 'package:equatable/equatable.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'session_view_model.g.dart';

@riverpod
class SessionViewModel extends _$SessionViewModel {
  @override
  SessionState build(SessionData sessionData) {
    return SessionState.sessionData(sessionData);
  }
}


class SessionState extends Equatable{
  final int talkerId;
  final String userName;
  final String userFace;

  const SessionState({
    required this.talkerId,
    required this.userName,
    required this.userFace,
  });

  factory SessionState.sessionData(SessionData sessionData) {
    return SessionState(
      talkerId: sessionData.sessionTakerId,
      userName: sessionData.userName,
      userFace: sessionData.userFace,
    );
  }

  @override
  List<Object?> get props => [talkerId, userName, userFace];
}