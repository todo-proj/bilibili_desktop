import 'package:bilibili_desktop/src/business/main/side_bar_item.dart';
import 'package:bilibili_desktop/src/business/user/user_center.dart';
import 'package:bilibili_desktop/src/providers/api_provider.dart';
import 'package:bilibili_desktop/src/providers/router/main_route.dart';
import 'package:bilibili_desktop/src/providers/theme/themes_provider.dart';
import 'package:bilibili_desktop/src/utils/wbi_check_util.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'main_view_model.g.dart';

@riverpod
class MainViewModel extends _$MainViewModel {
  @override
  MainPageState build(){
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

  void enterSearchState() {
    state = state.copyWith(showSearchPanel: true, isSearchState: true);
  }

  void exitSearchState() {
    state = state.copyWith(showSearchPanel: false, isSearchState: false);
  }

  void hideSearchPanel() {
    state = state.copyWith(showSearchPanel: false);
  }

  void showSearchPanel() {
    state = state.copyWith(showSearchPanel: true);
  }
}

class MainPageState extends Equatable{
  final List<SideBarItem> sideBarItems;
  // 搜索框移动到中间
  final bool isSearchState;
  // 搜索历史和热搜 panel
  final bool showSearchPanel;
  const MainPageState({
    required this.sideBarItems,
    this.isSearchState = false,
    this.showSearchPanel = false,
  });

  copyWith({
    List<SideBarItem>? sideBarItems,
    bool? showSearchPanel,
    bool? isSearchState,
  })
  {
    return MainPageState(
      sideBarItems: sideBarItems ?? this.sideBarItems,
      showSearchPanel: showSearchPanel ?? this.showSearchPanel,
      isSearchState: isSearchState ?? this.isSearchState,
    );
  }
  @override
  List<Object?> get props => [sideBarItems, showSearchPanel, isSearchState];
}

