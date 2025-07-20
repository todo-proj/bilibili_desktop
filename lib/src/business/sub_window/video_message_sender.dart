import 'package:bilibili_desktop/src/business/sub_window/video_window_method.dart';
import 'package:desktop_multi_window/desktop_multi_window.dart';

class VideoMessageSender {

  static void showVideoWindow(int windowId, String cid, String bvid, String mid) async {
    await _sendMessage(windowId, VideoWindowMethod.changeVideoMethod, {
      'cid': cid,
      'bvid': bvid,
      'mid': mid,
    });
  }

  static void changeTheme(int windowId, bool isDark) async {
    await _sendMessage(windowId, VideoWindowMethod.changeThemeMethod, {
      'dark': isDark
    });
  }

  static void onCloseVideoWindow() async {
    await _sendMessage(0, VideoWindowMethod.closeVideoWindowMethod, {'s':'d'});
  }

  static Future<dynamic> _sendMessage(int windowId, String method, dynamic arguments) async{
    final result =
        await DesktopMultiWindow.invokeMethod(windowId, method, arguments);
    return result;
  }
}