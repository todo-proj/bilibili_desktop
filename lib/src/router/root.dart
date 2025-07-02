import 'package:bilibili_desktop/src/business/common/dialog_page.dart';
import 'package:bilibili_desktop/src/business/login/login_page.dart';
import 'package:bilibili_desktop/src/router/home.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


final appRouter = GoRouter(routes: [rootRouter]);

final RouteBase rootRouter = GoRoute(
  path: '/',
  redirect: (_, __) => '/home', // ✅ 让 '/' 重定向到 '/home'
  routes: [
    homeRouter,
    GoRoute(
      path: 'login',
      pageBuilder: (context, state) => DialogPage(
        key: state.pageKey,
        builder: (_) => Center(child: const LoginPage()),
      ),
    ),
  ],
);
