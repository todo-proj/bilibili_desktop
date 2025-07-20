import 'dart:io';

import 'package:bilibili_desktop/src/business/common/widget/common_tab_bar.dart';
import 'package:bilibili_desktop/src/business/common/window_control_area.dart';
import 'package:bilibili_desktop/src/business/main/window_control_bar.dart';
import 'package:bilibili_desktop/src/business/sub_window/event_widget.dart';
import 'package:bilibili_desktop/src/business/sub_window/video/video_page_intro.dart';
import 'package:bilibili_desktop/src/business/sub_window/video/video_view_model.dart';
import 'package:bilibili_desktop/src/business/sub_window/video_message_sender.dart';
import 'package:bilibili_desktop/src/utils/widget_util.dart';
import 'package:desktop_multi_window/desktop_multi_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:media_kit_video/media_kit_video.dart';

import 'video_page_comment.dart';

class VideoPage extends ConsumerStatefulWidget {
  final String cid;
  final String bvid;
  final String mid;

  const VideoPage({
    super.key,
    required this.cid,
    required this.bvid,
    required this.mid,
  });

  @override
  ConsumerState<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends ConsumerState<VideoPage> {
  late VideoViewModel _vm;

  @override
  void initState() {
    super.initState();
    _vm = ref.read(videoViewModelProvider.notifier);
    _vm.getVideoInfo(widget.bvid, widget.cid, widget.mid);
  }

  @override
  Widget build(BuildContext context) {
    final items = ref.watch(videoViewModelProvider.select((e) => e.items));
    final selectedItemIndex = ref.watch(
      videoViewModelProvider.select((e) => e.selectedItemIndex),
    );
    return Scaffold(
      body: Column(
        children: [
          Container(
            color: Colors.black87,
            width: double.infinity,
            height: 50,
            child: DoubleTapMaximizeArea(
              child: Align(
                alignment: Alignment.centerRight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  spacing: 40,
                  children: [
                    Platform.isMacOS ? const SizedBox.shrink() : WindowControlsBar()
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(child: Video(controller: _vm.controller)),
                Container(
                  color: Colors.black.withValues(alpha: 0.9),
                  width: 380,
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          CommonTabBar(
                            items: items,
                            initialIndex: 0,
                            onTap: (index, item) {
                              _vm.changeTab(index);
                            },
                          ),
                          Spacer(),
                          Builder(
                            builder: (ctx) {
                              return IconButton(
                                onPressed: () async {
                                  final RenderBox buttonBox = ctx.findRenderObject() as RenderBox;
                                  final position = RelativeRect.fromSize(
                                    buttonBox.localToGlobal(Offset(-20, 40)) & buttonBox.size,
                                    MediaQuery.of(context).size,
                                  );
                                  final selected = await showMenu(
                                    context: ctx,
                                    // 设置弹出位置
                                    position: position,
                                    color: Colors.grey,
                                    items: [
                                      PopupMenuItem(child: Text("选项1"), value: 1),
                                      PopupMenuItem(child: Text("选项2"), value: 2),
                                    ],
                                  );
                                  print(selected);
                                },
                                icon: Icon(
                                  Icons.more_vert_rounded,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                      Divider(thickness: 0.1, color: Colors.grey),
                      20.hSize,
                      Expanded(
                        child: IndexedStack(
                          index: selectedItemIndex,
                          children: [VideoPageIntro(), VideoPageComment()],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
