import 'package:bilibili_desktop/src/business/window/sub_window_controller.dart';
import 'package:bilibili_desktop/src/business/window/window_method.dart';
import 'package:bilibili_desktop/src/utils/wbi_check_util.dart';

class VideoWindowController extends SubWindowController{

  void openVideo(String bvid) async{
    if (await checkIfWindowExist()) {
      showVideoWindow(bvid);
    } else {
      openVideoWindow(bvid);
    }
  }

  void openVideoWindow(String bvid) async {
    final arguments = {
      'bvid': bvid,
      'img': WbiCheckUtil.imgKey,
      'sub': WbiCheckUtil.subKey,
      'dark': true,
    };
    openWindow(arguments);
  }

  showVideoWindow(String bvid) async {
    if (!await checkIfWindowExist()) return;
    showWindow();
    await sendMessage(WindowMethod.changeVideoMethod, arguments: {
      'bvid': bvid,
    });
  }

}
