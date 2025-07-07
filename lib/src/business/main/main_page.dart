import 'dart:io';

import 'package:bilibili_desktop/src/business/main/title_search_panel.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'system_titlebar.dart';
import '../common/window_control_area.dart';
import 'side_bar.dart';

class MainPage extends StatefulWidget {
  final Widget child;

  const MainPage({super.key, required this.child});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          SideBar(),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  width: double.infinity,
                  color: Colors.white,
                  padding: EdgeInsets.only(
                    top: 20,
                    bottom: 20,
                    left: 30,
                    right: 30,
                  ),
                  child: DoubleTapMaximizeArea(
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => const TitleSearchPanelTest()));
                          },
                          child: Image.asset(
                            'assets/images/bilibili_logo.png',
                            width: 80,
                            color: Colors.pinkAccent,
                          ),
                        ),
                        const Spacer(),
                        Expanded(child: Stack(
                          children: [
                            TitleSearchPanel()
                          ],
                        )),
                        Platform.isMacOS ? const SizedBox() : SystemTitleBar(),
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
    );
  }
}
