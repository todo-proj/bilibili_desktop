import 'package:bilibili_desktop/src/business/common/system_titlebar.dart';
import 'package:bilibili_desktop/src/business/home/side_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../common/window_control_area.dart';

class HomePage extends StatefulWidget {
  final Widget child;
  const HomePage({super.key, required this.child});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    super.initState();
  }

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
                    color: Colors.blue,
                    child: DoubleTapMaximizeArea(child: SystemTitleBar())),
                Expanded(child: widget.child)
              ],
            ),
          ),
        ],
      ),
    );
  }

}
