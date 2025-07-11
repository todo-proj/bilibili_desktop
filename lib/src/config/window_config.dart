import 'dart:io';

class WindowConfig {
  static const double windowWidth = 1000;
  static const double windowHeight = 800;

  static const double windowMinWidth = 800;
  static const double windowMinHeight = 650;

  static final double windowControlWidth = Platform.isMacOS ? 0 : 120;

  static const double sideBarWidth = 80;

  static const double systemTitleBarHeight = 70;
  static const double systemTitleBarPaddingHorizontal = 30;

  static const double searchPanelWidth = 200;
  static const double searchPanelExpandedWidth = 400;

  static const double searchPanelHeightPaddingHorizontal = 30;
  static final double defaultSearchPanelAlignOffset = 1 - 2 * windowControlWidth / (windowWidth - sideBarWidth - searchPanelWidth - systemTitleBarPaddingHorizontal * 2 - searchPanelHeightPaddingHorizontal);

  static double calculateSearchPanelOffset(double windowWidth) {
    return 1 - 2 * windowControlWidth / (windowWidth - sideBarWidth - searchPanelWidth - systemTitleBarPaddingHorizontal * 2 - searchPanelHeightPaddingHorizontal);
  }
}
