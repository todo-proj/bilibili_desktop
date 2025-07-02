import 'package:bilibili_desktop/src/business/home/home_page.dart';
import 'package:bilibili_desktop/src/business/user/user_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../business/setting/setting_page.dart';

final RouteBase homeRouter = ShellRoute(
  builder: (context, state, child) {
    return HomePage(child: child,); // 统一布局
  },
  routes: [
    GoRoute(
      path: '/home',
      builder: (context, state) => Text('Home'),
    ),
    GoRoute(
      path: '/home/settings',
      builder: (context, state) => const SettingPage(),
    ),
    GoRoute(
      path: '/home/user',
      builder: (context, state) => const UserPage(),
    ),
  ],
);
