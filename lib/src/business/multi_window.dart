import 'dart:convert';
import 'dart:ui';

import 'package:desktop_multi_window/desktop_multi_window.dart';


showSubWindow() async {
  final window =
  await DesktopMultiWindow.createWindow(jsonEncode({
    'args1': 'Sub window',
    'args2': 100,
    'args3': true,
    'business': 'business_test',
  }));
  window
    ..setFrame(const Offset(0, 0) & const Size(1280, 720))
    ..center()
    ..setTitle('Another window')
    ..show();
}