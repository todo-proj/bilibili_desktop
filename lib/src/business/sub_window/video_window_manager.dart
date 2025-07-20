import 'dart:convert';
import 'dart:ui';

import 'package:bilibili_desktop/src/business/sub_window/video_message_sender.dart';
import 'package:bilibili_desktop/src/providers/theme/themes_provider.dart';
import 'package:bilibili_desktop/src/utils/wbi_check_util.dart';
import 'package:desktop_multi_window/desktop_multi_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'video_window_method.dart';

class VideoWindowManager {

  static const int emptyWindowId = -1;
  static int _windowId = emptyWindowId;

  static void init() async {
    debugPrint("VideoWindowManager init");
    // DesktopMultiWindow.setMethodHandler((call, fromWindowId) async {
    //   final args = call.arguments;
    //   final method = call.method;
    //   debugPrint("fromWindowId: $fromWindowId, method: $method, args: $args");
    //   return "result";
    // });
    DesktopMultiWindow.setMethodHandler((call, fromWindowId) async {
      final args = call.arguments;
      final method = call.method;
      debugPrint("fromWindowId: $fromWindowId, method: $method, args: $args");
      switch (method) {
        case VideoWindowMethod.changeThemeMethod:
          final dark = args["dark"];
          break;
        case VideoWindowMethod.changeVideoMethod:
          final cid = args["cid"];
          final bvid = args["bvid"];
          final mid = args["mid"];
          break;
      }
      return "result";
    });
  }

  static void openVideo(WidgetRef ref, String cid, String bvid, String mid) {
    if (_windowId == emptyWindowId) {
      openVideoWindow(ref, cid, bvid, mid);
    }else {
      showVideoWindow(ref, cid, bvid, mid);
    }
  }

  static openVideoWindow(WidgetRef ref, String cid, String bvid, String mid) async {
    final window =
    await DesktopMultiWindow.createWindow(jsonEncode({
      'cid': cid,
      'bvid': bvid,
      'mid': mid,
      'img': WbiCheckUtil.imgKey,
      'sub': WbiCheckUtil.subKey,
      'dark': true,
    }));
    window
      ..setFrame(const Offset(0, 0) & const Size(1280, 720))
      ..center()
      ..setTitle('Another window')
      ..show();
    _windowId = window.windowId;
  }

  static showVideoWindow(WidgetRef ref, String cid, String bvid, String mid) async {
    if (!await checkWindow()) return;
    VideoMessageSender.showVideoWindow(_windowId, cid, bvid, mid);
  }


  static Future<bool> checkWindow() async{
    List<int> windowIds = await DesktopMultiWindow.getAllSubWindowIds();
    if (!windowIds.contains(_windowId)) {
      _windowId = emptyWindowId;
      return false;
    }
    return true;
  }
}

