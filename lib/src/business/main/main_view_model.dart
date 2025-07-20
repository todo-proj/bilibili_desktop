import 'package:bilibili_desktop/src/business/main/side_bar_item.dart';
import 'package:bilibili_desktop/src/business/user/user_center.dart';
import 'package:bilibili_desktop/src/business/window/sub_window_manager.dart';
import 'package:bilibili_desktop/src/business/window/sub_window_type.dart';
import 'package:bilibili_desktop/src/business/window/window_method.dart';
import 'package:bilibili_desktop/src/providers/router/main_route.dart';
import 'package:bilibili_desktop/src/providers/theme/themes_provider.dart';
import 'package:desktop_multi_window/desktop_multi_window.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:window_manager/window_manager.dart';

part 'main_view_model.g.dart';

@riverpod
class MainViewModel extends _$MainViewModel {
  @override
  MainPageState build(){
    registerWindowMessageReceiver();
    return MainPageState(sideBarItems: _generateSideBarItems());
  }

  List<SideBarItem> _generateSideBarItems() {
    // 固定
    List<SideBarItem> sideBarItems = [
      SideBarItem(icon: Icons.home_rounded, title: '首页', tag: MainRoute.home),
      SideBarItem(icon: Icons.ondemand_video_rounded, title: '精选', tag: MainRoute.featured),
      SideBarItem(icon: Icons.home_rounded, title: '动态', tag: MainRoute.following),
      SideBarItem(icon: Icons.home_rounded, title: '我的', tag: MainRoute.user),
      SideBarItem(tag: 'empty'),
    ];
    final userInfo = ref.read(userCenterProviderProvider.select((e)=>e.userInfo));
    dynamic zoneObject;
    if (userInfo != null) {
      zoneObject = {
        'isLogin': userInfo.isLogin,
        'avatar': userInfo.face,
      };
    }
    sideBarItems.add(SideBarItem(tag: MainRoute.zone, object: zoneObject, maintainState: false));
    sideBarItems.add(SideBarItem(icon: Icons.email_outlined, tag: MainRoute.directMessage, maintainState: false));
    //夜间模式
    final themeState = ref.read(themesProvider);
    if (themeState.isDark) {
      sideBarItems.add(SideBarItem(icon: Icons.sunny, tag: MainRoute.theme, maintainState: false));
    } else {
      sideBarItems.add(SideBarItem(icon: Icons.nightlight_rounded, tag: MainRoute.theme, maintainState: false));
    }
    sideBarItems.add(SideBarItem(icon: Icons.settings, tag: MainRoute.settings));

    return sideBarItems;
  }

  void refreshSideBar() {
    state = state.copyWith(sideBarItems: _generateSideBarItems());
  }

  void registerWindowMessageReceiver() {
    DesktopMultiWindow.setMethodHandler((call, fromWindowId) async {
      final args = call.arguments;
      final method = call.method;
      debugPrint("fromWindowId: $fromWindowId, method: $method, args: $args");
      switch (method) {
        case WindowMethod.onSubWindowCloseMethod:
          final type = args["type"];
          final windowType = SubWindowType.fromString(type);
          SubWindowManager.instance.getSubWindowController(windowType)?.onCloseWindow();
          break;
        case WindowMethod.showMainWindowMethod:
          windowManager.show();
          break;
      }
    });
  }
}

class MainPageState extends Equatable{
  final List<SideBarItem> sideBarItems;
  const MainPageState({
    required this.sideBarItems,
  });

  copyWith({
    List<SideBarItem>? sideBarItems,
  })
  {
    return MainPageState(
      sideBarItems: sideBarItems ?? this.sideBarItems,
    );
  }
  @override
  List<Object?> get props => [sideBarItems];
}

