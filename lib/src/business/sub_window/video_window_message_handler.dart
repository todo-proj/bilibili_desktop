import 'package:desktop_multi_window/desktop_multi_window.dart';
import 'package:flutter/material.dart';

class VideoWindowMessageHandler {

  void register() {
    DesktopMultiWindow.setMethodHandler((call, fromWindowId) async {
      debugPrint('${call.method} ${call.arguments} $fromWindowId');
      return "result";
    });
  }


  Future<dynamic> sendMessage(int windowId, String method, dynamic argument) async{
    final result =  DesktopMultiWindow.invokeMethod(windowId, method, argument);
    return result;
  }
}