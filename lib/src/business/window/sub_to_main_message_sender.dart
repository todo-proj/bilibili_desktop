import 'package:bilibili_desktop/src/business/window/sub_window_type.dart';
import 'package:bilibili_desktop/src/business/window/window_method.dart';
import 'package:desktop_multi_window/desktop_multi_window.dart';

class SubWindowToMainWindowMessageSender {

  static void showMainWindow() async {
    await _sendMessage(WindowMethod.showMainWindowMethod);
  }

  static Future<dynamic> _sendMessage(String method, {dynamic arguments}) async{
    final result = await DesktopMultiWindow.invokeMethod(0, method, arguments);
    return result;
  }


}