import 'package:bilibili_desktop/src/business/window/video_window/video/video_view_model.dart';
import 'package:bilibili_desktop/src/business/window/window_method.dart';
import 'package:desktop_multi_window/desktop_multi_window.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'video_message_receiver.g.dart';

@riverpod
class VideoMessageReceiver extends _$VideoMessageReceiver {
  @override
  VideoMessageReceiverState build(ThemeMode mode) {
    ref.onDispose(() {
      DesktopMultiWindow.setMethodHandler(null);
    });
    register();
    return VideoMessageReceiverState(mode: mode);
  }

  void test() {
    debugPrint('test');
  }

  void register() {
    DesktopMultiWindow.setMethodHandler((call, fromWindowId) async {
      final args = call.arguments;
      final method = call.method;
      debugPrint("fromWindowId: $fromWindowId, method: $method, args: $args");
      switch (method) {
        case WindowMethod.changeThemeMethod:
          final dark = args["dark"];
          state = state.copyWith(mode: dark ? ThemeMode.dark : ThemeMode.light);
          break;
        case WindowMethod.changeVideoMethod:
          final cid = args["cid"];
          final bvid = args["bvid"];
          final mid = args["mid"];
          ref.read(videoViewModelProvider.notifier).getVideoInfo(bvid, cid, mid);
          break;
      }
      return "result";
    });
  }
}


class VideoMessageReceiverState extends Equatable {
  final ThemeMode mode;

  const VideoMessageReceiverState({required this.mode});

  @override
  List<Object?> get props => [mode];

  copyWith({
    ThemeMode? mode,
  }) {
    return VideoMessageReceiverState(
      mode: mode ?? this.mode,
    );
  }
}