import 'package:bilibili_desktop/src/config/window_config.dart';
import 'package:bilibili_desktop/src/providers/router/root_route.dart';
import 'package:bilibili_desktop/src/providers/theme/themes_provider.dart';
import 'package:bilibili_desktop/src/utils/app_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:media_kit/media_kit.dart';
import 'package:window_manager/window_manager.dart';

import 'src/providers/theme/themes.dart';


void main() async{
  MediaKit.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();
  await AppStorage.init();
  await windowManager.ensureInitialized();
  WindowOptions windowOptions = WindowOptions(
    size: Size(WindowConfig.windowWidth, WindowConfig.windowHeight),
    minimumSize: Size(WindowConfig.windowMinWidth, WindowConfig.windowMinHeight),
    center: true,
    backgroundColor: Colors.transparent,
    skipTaskbar: false,
    titleBarStyle: TitleBarStyle.hidden,
  );
  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });
  runApp(ProviderScope(child: const App()));
}

class App extends ConsumerWidget {
  const App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeModeState = ref.watch(themesProvider);
    debugPrint('ThemeMode: ${themeModeState.mode}');
    return MaterialApp.router(
      title: 'BiliBili野生客户端',
      theme: Themes.lightTheme,
      darkTheme: Themes.darkTheme,
      themeMode: themeModeState.mode,
      routerConfig: ref.read(appRouterProvider),
    );
  }
}
