import 'dart:io';

import 'package:bilibili_desktop/src/business/window/video_window/video/video_page.dart';
import 'package:bilibili_desktop/src/business/window/video_window/video/video_view_model.dart';
import 'package:bilibili_desktop/src/business/window/video_window/video_message_receiver.dart';
import 'package:bilibili_desktop/src/providers/theme/themes.dart';
import 'package:bilibili_desktop/src/utils/wbi_check_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:window_manager/window_manager.dart';

class VideoWindowApp extends ConsumerStatefulWidget {
  final int windowId;
  final dynamic argument;
  const VideoWindowApp(this.windowId, this.argument, {super.key});

  @override
  ConsumerState<VideoWindowApp> createState() => _VideoWindowAppState();
}

class _VideoWindowAppState extends ConsumerState<VideoWindowApp> with WindowListener{

  ThemeMode get mode => widget.argument['dark'] ? ThemeMode.dark : ThemeMode.light;

  late VideoMessageReceiverProvider _receiverProvider;
  late VideoMessageReceiver _receiver;

  @override
  void initState() {
    super.initState();
    _receiverProvider = videoMessageReceiverProvider.call(mode);
    _receiver = ref.read(_receiverProvider.notifier);

    windowManager.addListener(this);
  }

  @override
  void dispose() {
    windowManager.removeListener(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mode = ref.watch(_receiverProvider.select((e)=>e.mode));
    return MaterialApp(
      theme: Themes.lightTheme,
      darkTheme: Themes.darkTheme,
      themeMode: mode,
      home: Scaffold(
        body: VideoPage(cid: widget.argument['cid'], bvid: widget.argument['bvid'], mid: widget.argument['mid']),
      ),
    );
  }

  @override
  void onWindowClose() async{
    final videoViewModel = ref.read(videoViewModelProvider.notifier);
    if (Platform.isMacOS) {
      videoViewModel.player.stop();
    }else {
      videoViewModel.player.dispose();
    }
  }

  @override
  void onWindowFocus() {
    debugPrint("onWindowFocus");
  }

}

void prepareVideoWindowParams(dynamic argument) async{
  WbiCheckUtil.injectKey(argument['img'], argument['sub']);
}