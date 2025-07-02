import 'package:bilibili_desktop/src/business/home/home_page.dart';
import 'package:bilibili_desktop/src/business/main/main_page.dart';
import 'package:bilibili_desktop/src/business/splash_page.dart';
import 'package:bilibili_desktop/src/business/user/user_page.dart';
import 'package:bilibili_desktop/src/router/root_route.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../business/message/direct_message_page.dart';
import '../business/setting/setting_page.dart';


class MainRoute {
  static final String main = '/main';
  static final String home = '/main/home';
  static final String settings = '/main/settings';
  static final String user = '/main/user';
  static final String directMessage = '/main/message';
}

// Main Shell Route
// 这个 ShellRoute 会包裹 /main 下的所有子路由
final RouteBase mainRoute = ShellRoute(
  builder: (BuildContext context, GoRouterState state, Widget child) {
    // 这个 child 是 ShellRoute.routes 中匹配到的页面
    return MainPage(child: child);
  },
  routes: [
    // 当访问 /main (或者 /main/ 被重定向) 时，会默认重定向到 /main/home
    GoRoute(
      path: MainRoute.main,
      redirect: (_, state) {
        return MainRoute.home;
      },),
    GoRoute(
      path: MainRoute.home,
      name: 'home',
      builder: (BuildContext context, GoRouterState state) {
        return const HomePage();
      },
    ),
    GoRoute(
      path: MainRoute.settings,
      name: 'settings',
      builder: (BuildContext context, GoRouterState state) {
        return const SettingPage();
      },
    ),
    GoRoute(
      path: MainRoute.user,
      name: 'user',
      builder: (BuildContext context, GoRouterState state) {
        return const UserPage();
      },
    ),
    GoRoute(
      path: MainRoute.directMessage,
      redirect: (_, state) {
        return RootRoute.login;
      },
      name: 'message',
      builder: (BuildContext context, GoRouterState state) {
        return const DirectMessagePage();
      },
    ),
  ],
);