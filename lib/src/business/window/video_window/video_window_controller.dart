import 'package:bilibili_desktop/src/business/window/sub_window_controller.dart';
import 'package:bilibili_desktop/src/business/window/window_method.dart';
import 'package:bilibili_desktop/src/utils/wbi_check_util.dart';

class VideoWindowController extends SubWindowController{

  void openVideo(String cid, String bvid, String mid) async{
    if (await checkIfWindowExist()) {
      showVideoWindow(cid, bvid, mid);
    } else {
      openVideoWindow(cid, bvid, mid);
    }
  }

  void openVideoWindow(String cid, String bvid, String mid) async {
    final arguments = {
      'cid': cid,
      'bvid': bvid,
      'mid': mid,
      'img': WbiCheckUtil.imgKey,
      'sub': WbiCheckUtil.subKey,
      'dark': true,
    };
    openWindow(arguments);
  }

  showVideoWindow(String cid, String bvid, String mid) async {
    if (!await checkIfWindowExist()) return;
    showWindow();
    await sendMessage(WindowMethod.changeVideoMethod, arguments: {
      'cid': cid,
      'bvid': bvid,
      'mid': mid,
    });
  }

}
