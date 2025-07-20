import 'video_window/video_window_controller.dart';
import 'sub_window_controller.dart';
import 'sub_window_type.dart';

/// 管理sub window
class SubWindowManager {

  SubWindowManager._internal();
  static final SubWindowManager instance = SubWindowManager._internal();

  final Map<SubWindowType, SubWindowController> _subWindowMap = {};

  SubWindowController? getSubWindowController(SubWindowType type) {
    return _subWindowMap[type];
  }

  void createVideoWindowController(SubWindowType type) {
    if (_subWindowMap.containsKey(type)) {
      return;
    }
    _subWindowMap[type] = VideoWindowController();
  }

  VideoWindowController getVideoWindowController() {
    createVideoWindowController(SubWindowType.video);
    return _subWindowMap[SubWindowType.video] as VideoWindowController;
  }

  void onSubWindowClose(SubWindowType type) {
    _subWindowMap.remove(type);
  }
}