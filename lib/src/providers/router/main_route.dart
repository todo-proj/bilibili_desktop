import 'package:bilibili_desktop/src/business/home/home_page.dart';
import 'package:bilibili_desktop/src/business/main/main_page.dart';
import 'package:bilibili_desktop/src/business/message/direct_message_page.dart';
import 'package:bilibili_desktop/src/business/setting/setting_page.dart';
import 'package:bilibili_desktop/src/business/user/user_center.dart';
import 'package:bilibili_desktop/src/business/user/user_page.dart';
import 'package:bilibili_desktop/src/providers/router/root_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';


class MainRoute {
  static const String main = '/main';
  static const String home = '/main/home';
  static const String settings = '/main/settings';
  static const String user = '/main/user';
  static const String zone = '/main/zone'; //个人空间
  static const String directMessage = '/main/message';
  static const String featured = '/main/featured';
  static const String following = '/main/following';
  static const String theme = '/main/theme';
}

// Main Shell Route
// 这个 ShellRoute 会包裹 /main 下的所有子路由
final mainRouteProvider = Provider<ShellRoute>((ref){
  return ShellRoute(
    builder: (BuildContext context, GoRouterState state, Widget child) {
      // 这个 child 是 ShellRoute.routes 中匹配到的页面
      return MainPage(child: child);
    },
    pageBuilder: (context, state, child) {
      return CustomTransitionPage(
        child: MainPage(child: child),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      );
    },
    routes: [
      // 当访问 /main (或者 /main/ 被重定向) 时，会默认重定向到 /main/home
      GoRoute(
        path: MainRoute.main,
        redirect: (_, state) {
          return MainRoute.home;
        },
      ),
      GoRoute(
        path: MainRoute.home,
        name: 'home',
        pageBuilder: (context, state) =>
            _buildPageWithTransition(HomePage(key: state.pageKey), state),
      ),
      GoRoute(
        path: MainRoute.settings,
        name: 'settings',
        pageBuilder: (context, state) =>
            _buildPageWithTransition(SettingPage(key: state.pageKey), state),
      ),
      GoRoute(
        path: MainRoute.user,
        name: 'user',
        pageBuilder: (context, state) =>
            _buildPageWithTransition(UserPage(key: state.pageKey), state),
      ),
      GoRoute(
        path: MainRoute.directMessage,
        name: 'message',
        pageBuilder: (context, state) => _buildPageWithTransition(
          DirectMessagePage(key: state.pageKey),
          state,
        ),
      ),
      GoRoute(
        path: MainRoute.zone,
        name: 'zone',
        pageBuilder: (context, state) => _buildPageWithTransition(
          DirectMessagePage(key: state.pageKey),
          state,
        ),
      ),
      GoRoute(
        path: MainRoute.featured,
        name: 'featured',
        pageBuilder: (context, state) => _buildPageWithTransition(
          DirectMessagePage(key: state.pageKey),
          state,
        ),
      ),
      GoRoute(
        path: MainRoute.following,
        name: 'following',
        pageBuilder: (context, state) => _buildPageWithTransition(
          DirectMessagePage(key: state.pageKey),
          state,
        ),
      ),
    ],
  );
});


// 统一的转场动画构建函数
Page _buildPageWithTransition(Widget child, GoRouterState state) {
  return CustomTransitionPage(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(opacity: animation, child: child);
    },
  );
}
