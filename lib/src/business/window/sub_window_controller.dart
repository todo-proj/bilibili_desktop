import 'dart:convert';
import 'dart:ui';

import 'package:bilibili_desktop/src/utils/logger.dart';
import 'package:desktop_multi_window/desktop_multi_window.dart';


abstract mixin class SubWindowController {

  static const int emptyWindowId = -1;
  int _windowId = emptyWindowId;
  WindowController? _windowController;

  int get windowId => _windowId;


  Future<bool> checkIfWindowExist() async {
    List<int> windowIds = await DesktopMultiWindow.getAllSubWindowIds();
    if (!windowIds.contains(windowId)) {
      onCloseWindow();
      return false;
    }
    return true;
  }


  void openWindow(dynamic arguments) async {
    final window = await DesktopMultiWindow.createWindow(
      jsonEncode(arguments),
    );
    window
      ..setFrame(const Offset(0, 0) & const Size(1280, 720))
      ..center()
      ..setTitle('')
      ..show();
    _windowId = window.windowId;
    _windowController = window;
  }

  void onCloseWindow() {
    _windowId = emptyWindowId;
    _windowController = null;
  }

  Future<dynamic> sendMessage(String method, {dynamic arguments, int? windowId}) async{
    if (!await checkIfWindowExist()) {
      L.e('windowId is -1');
      return;
    }
    final result = await DesktopMultiWindow.invokeMethod(windowId ?? _windowId, method, arguments);
    return result;
  }

  void showWindow() {
    _windowController?.show();
  }

  void hideWindow() {
    _windowController?.hide();
  }

  void closeWindow() {
    _windowController?.close();
  }
}