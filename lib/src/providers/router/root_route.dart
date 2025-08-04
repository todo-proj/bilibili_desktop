import 'package:bilibili_desktop/src/business/common/dialog_page.dart';
import 'package:bilibili_desktop/src/business/login/login_page.dart';
import 'package:bilibili_desktop/src/business/message/direct_message_page.dart';
import 'package:bilibili_desktop/src/business/splash_page.dart';
import 'package:bilibili_desktop/src/business/user/user_center.dart';
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


// 统一的转场动画构建函数
Page buildPageWithTransition(Widget child, GoRouterState state) {
  return CustomTransitionPage(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(opacity: animation, child: child);
    },
  );
}

String? redirect(Ref ref, GoRouterState state) {
  if (ref.read(userCenterProviderProvider.notifier).checkLogin()) {
    return null;
  }
  return RootRoute.login;
}
