import 'package:bilibili_desktop/src/business/splash_view_model.dart';
import 'package:bilibili_desktop/src//providers/router/main_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';


class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({super.key});

  @override
  ConsumerState<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage> {

  @override
  Widget build(BuildContext context) {
    ref.listen(splashViewModelProvider, (prev, next) {
      if (next.checkLogin) {
        context.go(MainRoute.main);
      }
    });
    return Scaffold(
      body: Center(
        child: Image.asset('assets/images/bilibili_logo.png', width: 25, color: Colors.pink,),
      ),
    );
  }
}
