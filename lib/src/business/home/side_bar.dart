import 'package:bilibili_desktop/src/utils/widget_util.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SideBar extends StatelessWidget {
  const SideBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      color: Colors.grey.withAlpha(111),
      child: Column(
        spacing: 10,
        children: [
          TextButton(child: Text("Settings"),onPressed: (){},),
          TextButton(child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.home),
              Text("Home"),
            ],
          ),onPressed: (){
            context.go('/home/user');
          },),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.email_outlined),
          ),
          IconButton(
            onPressed: () {
              context.go('/home/settings');
            },
            icon: Icon(Icons.settings),
          ),
          20.hSize,
        ],
      ),
    );
  }
}
