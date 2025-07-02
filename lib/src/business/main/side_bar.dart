import 'package:bilibili_desktop/src/router/main_route.dart';
import 'package:bilibili_desktop/src/router/root_route.dart';
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
              Icon(Icons.home, size: 30,),
              Text("Home"),
            ],
          ),onPressed: (){
            context.go(MainRoute.home);
          },),
          IconButton(
            onPressed: () {
              context.push(MainRoute.directMessage);
            },
            icon: Icon(Icons.email_outlined),
          ),
          IconButton(
            onPressed: () {
              context.go(MainRoute.settings);
            },
            icon: Icon(Icons.settings),
          ),
          20.hSize,
        ],
      ),
    );
  }
}

// 我调用 context.go('/main/user');却重定向到了 /main，中文回答下
