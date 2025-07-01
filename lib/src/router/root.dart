import 'package:bilibili_desktop/src/business/common/dialog_page.dart';
import 'package:bilibili_desktop/src/business/home/home_page.dart';
import 'package:bilibili_desktop/src/business/login/login_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


final appRouter = GoRouter(routes: [rootRouter]);

final RouteBase rootRouter = GoRoute(
  path: '/',
  builder: (context, state) => const HomePage(),
  routes: [
    GoRoute(
      path: 'login',
      pageBuilder: (context, state) => DialogPage(
        key: state.pageKey,
        builder: (_) => Center(child: const LoginPage()),
      ),
    ),
  ],
);
