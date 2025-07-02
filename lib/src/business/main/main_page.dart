import 'package:flutter/material.dart';

import '../common/system_titlebar.dart';
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
