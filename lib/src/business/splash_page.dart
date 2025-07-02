import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'common/system_titlebar.dart';
import 'common/window_control_area.dart';
import 'main/side_bar.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {


  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  Future<void> _navigateToHome() async {
    // 模拟加载
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) {
      // 假设检查登录状态，如果已登录则到 home，否则到 login
      bool isLoggedIn = false; // 替换为你的实际登录检查逻辑
      if (isLoggedIn) {
        context.go('/home');
      } else {
        // context.go('/login');
        // 或者如果你希望登录后回到 home
        context.go('/main/home');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('Splash'),
    );
  }
}

// 什么时候用push，什么时候用go