import 'package:bilibili_desktop/src/business/common/event_dispatcher_mixin.dart';
import 'package:bilibili_desktop/src/business/user/user_center.dart';
import 'package:bilibili_desktop/src/router/main_route.dart';
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
  void initState() {
    super.initState();
    final userCenterProvider = ref.read(userCenterProviderProvider.notifier);
    userCenterProvider.getStream<CheckLoginEvent>().listen((event){
      if (mounted) {
        context.go(MainRoute.main);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userCenterProviderProvider);
    return Scaffold(
      body: Center(
        child: Image.asset('assets/images/bilibili_logo.png', width: 250, color: Colors.pink,),
      ),
    );
  }
}
