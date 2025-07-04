import 'package:bilibili_desktop/src/business/common/dialog_page.dart';
import 'package:bilibili_desktop/src/business/login/login_page.dart';
import 'package:bilibili_desktop/src/business/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'main_route.dart';

class RootRoute {
  static const splash = '/';
  static const login = '/login';
}

final appRouter = GoRouter(
  initialLocation: RootRoute.splash, // 启动时显示 Splash 页面
  routes: [
    GoRoute(
      path: RootRoute.splash,
      name: 'splash',
      builder: (context, state) => const SplashPage(),
    ),
    GoRoute(
      path: RootRoute.login,
      name: 'login',
      pageBuilder: (context, state) => DialogPage(
        // 或者 MaterialPage
        key: state.pageKey,
        builder: (_) => const Center(child: LoginPage()),
      ),
    ),
    mainRoute,
  ],
  errorBuilder: (context, state) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          context.go(MainRoute.main);
        },
        child: Center(child: Text('404 - Page Not Found: ${state.error}')),
      ),
    );
  },
);
