import 'package:bilibili_desktop/src/business/home/home_page.dart';
import 'package:bilibili_desktop/src/business/main/main_page.dart';
import 'package:bilibili_desktop/src/business/main/search/search_page.dart';
import 'package:bilibili_desktop/src/business/message/direct_message_page.dart';
import 'package:bilibili_desktop/src/business/setting/setting_page.dart';
import 'package:bilibili_desktop/src/business/user/user_center.dart';
import 'package:bilibili_desktop/src/business/user/user_page.dart';
import 'package:bilibili_desktop/src/providers/router/root_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class MainRoute {
  static const String home = '/main/home';
  static const String settings = '/main/settings';
  static const String user = '/main/user';
  static const String zone = '/main/zone'; //个人空间
  static const String directMessage = '/main/message';
  static const String featured = '/main/featured';
  static const String following = '/main/following'; // 动态
  static const String theme = '/main/theme';
  static const String search = '/main/search';
}

// StatefulShellRoute
// 这个 ShellRoute 会包裹 /main 下的所有子路由
final mainRouteProvider = Provider<StatefulShellRoute>((ref) {
  return StatefulShellRoute.indexedStack(
    builder: (context, state, navigationShell) {
      return MainPage(path: state.fullPath, child: navigationShell);
    },
    branches: [
      StatefulShellBranch(
        routes: [
          GoRoute(
            path: MainRoute.home,
            name: 'home',
            pageBuilder: (context, state) => buildPageWithTransition(
              HomePage(key: const ValueKey('home')),
              state,
            ),
          ),
        ],
      ),
      StatefulShellBranch(
        routes: [
          GoRoute(
            path: MainRoute.featured,
            name: 'featured',
            redirect: (_, state) => redirect(ref, state),
            pageBuilder: (context, state) => buildPageWithTransition(
              DirectMessagePage(key: state.pageKey),
              state,
            ),
          ),
        ],
      ),
      StatefulShellBranch(
        routes: [
          GoRoute(
            path: MainRoute.following,
            name: 'following',
            redirect: (_, state) => redirect(ref, state),
            pageBuilder: (context, state) => buildPageWithTransition(
              DirectMessagePage(key: state.pageKey),
              state,
            ),
          ),
        ],
      ),
      StatefulShellBranch(
        routes: [
          GoRoute(
            path: MainRoute.user,
            name: 'user',
            pageBuilder: (context, state) => buildPageWithTransition(
              UserPage(key: const ValueKey('user')),
              state,
            ),
          ),
        ],
      ),
      StatefulShellBranch(
        routes: [
          GoRoute(
            path: MainRoute.settings,
            name: 'settings',
            pageBuilder: (context, state) => buildPageWithTransition(
              SettingPage(key: const ValueKey('settings')),
              state,
            ),
          ),
        ],
      ),
    ],
  );
});
