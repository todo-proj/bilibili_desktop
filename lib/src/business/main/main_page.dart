import 'dart:io';

import 'package:bilibili_desktop/src/business/home/home_page_head.dart';
import 'package:bilibili_desktop/src/business/main/main_view_model.dart';
import 'package:bilibili_desktop/src/business/main/title_search_panel.dart';
import 'package:bilibili_desktop/src/business/main/window_control_bar.dart';
import 'package:bilibili_desktop/src/config/window_config.dart';
import 'package:bilibili_desktop/src/providers/router/main_route.dart';
import 'package:bilibili_desktop/src/utils/widget_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:window_manager/window_manager.dart';

import '../common/window_control_area.dart';
import 'side_bar.dart';

class MainPage extends ConsumerStatefulWidget {
  final Widget child;
  final String? path;

  const MainPage({super.key, required this.child, this.path});

  @override
  ConsumerState<MainPage> createState() => _MainPageState();
}

class _MainPageState extends ConsumerState<MainPage> with WindowListener{

  late MainViewModel _vm;
  final GlobalKey<TitleSearchPanelState> _titleSearchPanelKey = GlobalKey();
  final GlobalKey _windowControlsKey = GlobalKey();
  final GlobalKey _maximizeAreaKey = GlobalKey();
  final ValueNotifier<double> _windowControlsOffset = ValueNotifier(WindowConfig.defaultSearchPanelAlignOffset);


  @override
  void initState() {
    super.initState();
    _vm = ref.read(mainViewModelProvider.notifier);
    windowManager.addListener(this);
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
    final showPanel = ref.watch(mainViewModelProvider.select((e)=>e.showSearchPanel));
    return Scaffold(
      body: Listener(
        behavior: HitTestBehavior.opaque,
        onPointerDown: (event) {
          final TitleSearchPanelState? widgetState = _titleSearchPanelKey.currentState;
          if (widgetState == null) {
            return;
          }
          final position = event.position;
          if (!widgetState.isClickInsideTextField(position) || !isClickInsideArea(position, _titleSearchPanelKey)) {
            _vm.hideSearchPanel();
          }
        },
        child: LayoutBuilder(builder: (context, constraints) {
          debugPrint('constraints: $constraints');
          return Row(
            children: [
              SideBar(),
              Expanded(
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
                        right:  WindowConfig.systemTitleBarPaddingHorizontal,
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
                                  Expanded(child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 300),
                                      child: showPanel ? const SizedBox.shrink() : _buildTitleHead(widget.path))),
                                  KeyedSubtree(
                                    key: _windowControlsKey,
                                    child: Platform.isMacOS ? const SizedBox.shrink() : WindowControlsBar(),)
                                ],
                              ),
                            ),
                            ValueListenableBuilder(
                              valueListenable: _windowControlsOffset,
                              builder: (context, value, child) {
                                return TitleSearchPanel(key: _titleSearchPanelKey, offset: value,);
                              }
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: widget.child,
                    ),
                  ],
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  @override
  void onWindowResize() {
    _calculateTitleSearchPanelOffset();
  }


  Widget _buildTitleHead(String? tag) {
    return switch(tag) {
      MainRoute.home => const HomePageHead(),
      _ => const SizedBox.shrink(),
    };
  }

  void _calculateTitleSearchPanelOffset() async{
    final size = await windowManager.getSize();
    _windowControlsOffset.value = WindowConfig.calculateSearchPanelOffset(size.width);
  }
}
