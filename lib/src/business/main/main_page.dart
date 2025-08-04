import 'dart:io';

import 'package:bilibili_desktop/src/business/home/home_page_head.dart';
import 'package:bilibili_desktop/src/business/main/main_view_model.dart';
import 'package:bilibili_desktop/src/business/main/search/search_view_model.dart';
import 'package:bilibili_desktop/src/business/main/search/title_search_panel.dart';
import 'package:bilibili_desktop/src/business/main/window_control_bar.dart';
import 'package:bilibili_desktop/src/business/message/direct_message_container_page.dart';
import 'package:bilibili_desktop/src/business/message/direct_message_page.dart';
import 'package:bilibili_desktop/src/config/window_config.dart';
import 'package:bilibili_desktop/src/providers/router/main_route.dart';
import 'package:bilibili_desktop/src/providers/router/router_history.dart';
import 'package:bilibili_desktop/src/utils/widget_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:window_manager/window_manager.dart';

import '../common/window_control_area.dart';
import 'side_bar.dart';

class MainPage extends ConsumerStatefulWidget {
  final StatefulNavigationShell child;
  final String? path;

  const MainPage({super.key, required this.child, this.path});

  @override
  ConsumerState<MainPage> createState() => _MainPageState();
}

class _MainPageState extends ConsumerState<MainPage> with WindowListener {
  late MainViewModel _vm;
  late SearchViewModel _searchVM;
  final GlobalKey<TitleSearchPanelState> _titleSearchPanelKey = GlobalKey();
  final GlobalKey _windowControlsKey = GlobalKey();
  final GlobalKey _maximizeAreaKey = GlobalKey();
  final GlobalKey _sideBarAreaKey = GlobalKey();
  final ValueNotifier<double> _windowControlsOffset = ValueNotifier(
    WindowConfig.defaultSearchPanelAlignOffset,
  );

  @override
  void initState() {
    super.initState();
    _vm = ref.read(mainViewModelProvider.notifier);
    _searchVM = ref.read(searchViewModelProvider.notifier);
    windowManager.addListener(this);
    if (widget.path != MainRoute.search) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _searchVM.exitSearchState();
      });
    }
  }

  @override
  void dispose() {
    _windowControlsOffset.dispose();
    windowManager.removeListener(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    debugPaintSizeEnabled = true;
    final isSearchState = ref.watch(
      searchViewModelProvider.select((e) => e.isSearchState),
    );
    final routerHistory = ref.read(routerHistoryProvider);
    final showDirectMessage = ref.watch(
      mainViewModelProvider.select((e) => e.showDirectMessage),
    );
    return Scaffold(
      body: RouterHistoryScope(
        notifier: routerHistory,
        child: Listener(
          behavior: HitTestBehavior.opaque,
          onPointerDown: (event) {
            final TitleSearchPanelState? widgetState =
                _titleSearchPanelKey.currentState;
            final showSearchPage = widget.path == MainRoute.search;
            if (widgetState == null) {
              return;
            }
            final position = event.position;
            if (isClickInsideArea(position, _sideBarAreaKey)) {
              _searchVM.exitSearchState();
              return;
            }
            if (!widgetState.isClickInsideTextField(position) ||
                !isClickInsideArea(position, _titleSearchPanelKey)) {
              if (showSearchPage) {
                _searchVM.hideSearchPanel();
              } else {
                _searchVM.exitSearchState();
              }
            }
          },
          child: LayoutBuilder(
            builder: (context, constraints) {
              debugPrint('constraints: $constraints');
              return Stack(
                children: [
                  Positioned(
                    left: WindowConfig.sideBarWidth,
                    top: 0,
                    right: 0,
                    bottom: 0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          key: _maximizeAreaKey,
                          width: double.infinity,
                          height: WindowConfig.systemTitleBarHeight,
                          color: Theme.of(context).colorScheme.surface,
                          padding: EdgeInsets.only(
                            top: 10,
                            bottom: 10,
                            left: WindowConfig.systemTitleBarPaddingHorizontal,
                            right: WindowConfig.systemTitleBarPaddingHorizontal,
                          ),
                          child: DoubleTapMaximizeArea(
                            child: Stack(
                              children: [
                                Align(
                                  alignment: Alignment.center,
                                  child: Row(
                                    spacing: 40,
                                    children: [
                                      Image.asset(
                                        'assets/images/bilibili_logo.png',
                                        width: 70,
                                        color: Colors.pinkAccent,
                                      ),
                                      Expanded(
                                        child: AnimatedContainer(
                                          duration: const Duration(
                                            milliseconds: 300,
                                          ),
                                          child: isSearchState
                                              ? const SizedBox.shrink()
                                              : _buildTitleHead(widget.path),
                                        ),
                                      ),
                                      KeyedSubtree(
                                        key: _windowControlsKey,
                                        child: Platform.isMacOS
                                            ? const SizedBox.shrink()
                                            : WindowControlsBar(),
                                      ),
                                    ],
                                  ),
                                ),
                                ValueListenableBuilder(
                                  valueListenable: _windowControlsOffset,
                                  builder: (context, value, child) {
                                    return TitleSearchPanel(
                                      key: _titleSearchPanelKey,
                                      offset: value,
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                        Divider(height: 0.1, color: Colors.grey, thickness: 0.1),
                        Expanded(child: widget.child),
                      ],
                    ),
                  ),
                  if (showDirectMessage)
                    Positioned(
                      left: WindowConfig.sideBarWidth,
                        top: WindowConfig.systemTitleBarHeight + 1,
                        bottom: 0,
                        width: WindowConfig.directMessageWidth,
                        child: DirectMessageContainerPage(onClose: _vm.closeDirectMessage,)),
                  Positioned(
                    left: 0,
                    top: 0,
                    bottom: 0,
                    width: WindowConfig.sideBarWidth,
                    child: SideBar(key: _sideBarAreaKey),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  void onWindowResize() {
    _calculateTitleSearchPanelOffset();
  }

  Widget _buildTitleHead(String? tag) {
    return switch (tag) {
      MainRoute.home => const HomePageHead(),
      _ => const SizedBox.shrink(),
    };
  }

  void _calculateTitleSearchPanelOffset() async {
    final size = await windowManager.getSize();
    _windowControlsOffset.value = WindowConfig.calculateSearchPanelOffset(
      size.width,
    );
  }
}
