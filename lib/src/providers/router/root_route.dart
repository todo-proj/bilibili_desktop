import 'package:bilibili_desktop/src/business/common/dialog_page.dart';
import 'package:bilibili_desktop/src/business/login/login_page.dart';
import 'package:bilibili_desktop/src/business/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'main_route.dart';

class RootRoute {
  static const splash = '/';
  static const login = '/login';
  static const video = '/video/:id';
}

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) {
          return const SplashPage();
        },
      ),
      GoRoute(
        path: '/login',
        pageBuilder: (context, state) => DialogPage(
          // 或者 MaterialPage
          key: state.pageKey,
          builder: (_) => const Center(child: LoginPage()),
        ),
      ),
      ref.read(mainRouteProvider),
      // GoRoute(
      //   path: RootRoute.video,
      //   builder: (context, state) {
      //     Item item = state.extra as Item;
      //     return VideoPage(cid: item.cid, bvid: item.bvid, mid: item.owner.mid.toString(),);
      //   },
      // ),
    ],
    errorBuilder: (context, state) {
      return Scaffold(
        body: GestureDetector(
          onTap: () {
            context.go(MainRoute.home);
          },
          child: Center(child: Text('404 - Page Not Found: ${state.error}')),
        ),
      );
    },
  );
});