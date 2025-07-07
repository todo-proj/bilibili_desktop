import 'dart:io';

import 'package:bilibili_desktop/src/business/main/main_view_model.dart';
import 'package:bilibili_desktop/src/business/main/title_search_panel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'system_titlebar.dart';
import '../common/window_control_area.dart';
import 'side_bar.dart';

class MainPage extends ConsumerStatefulWidget {
  final Widget child;

  const MainPage({super.key, required this.child});

  @override
  ConsumerState<MainPage> createState() => _MainPageState();
}

class _MainPageState extends ConsumerState<MainPage> {

  late MainViewModel _vm;

  @override
  void initState() {
    super.initState();
    _vm = ref.read(mainViewModelProvider.notifier);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: (){
          // _vm.hideSearchPanel();
        },
        child: Row(
          children: [
            SideBar(),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    width: double.infinity,
                    height: 80,
                    color: Colors.white,
                    padding: EdgeInsets.only(
                      top: 20,
                      bottom: 20,
                      left: 30,
                      right: 30,
                    ),
                    child: DoubleTapMaximizeArea(
                      child: Stack(
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                'assets/images/bilibili_logo.png',
                                width: 80,
                                color: Colors.pinkAccent,
                              ),
                              const Spacer(),
                              Platform.isMacOS ? const SizedBox() : SystemTitleBar(),
                            ],
                          ),
                          TitleSearchPanel(rightMargin: 120,)
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
        ),
      ),
    );
  }
}
