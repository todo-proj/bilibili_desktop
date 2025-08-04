import 'package:bilibili_desktop/src/business/common/secondary_click_menu_wrapper.dart';
import 'package:bilibili_desktop/src/business/common/widget/common_tab_bar.dart';
import 'package:bilibili_desktop/src/business/common/widget/hover_widget.dart';
import 'package:bilibili_desktop/src/business/message/direct_message_view_model.dart';
import 'package:bilibili_desktop/src/providers/router/main_route.dart';
import 'package:bilibili_desktop/src/providers/theme/extension/app_color.dart';
import 'package:bilibili_desktop/src/utils/date_util.dart';
import 'package:bilibili_desktop/src/utils/widget_util.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class DirectMessagePage extends ConsumerStatefulWidget {
  final VoidCallback? onClose;

  const DirectMessagePage({super.key, this.onClose});

  @override
  ConsumerState<DirectMessagePage> createState() => _DirectMessagePageState();
}

class _DirectMessagePageState extends ConsumerState<DirectMessagePage>{
  late DirectMessageViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = ref.read(directMessageViewModelProvider.notifier);
  }

  @override
  Widget build(BuildContext context) {
    final items = ref.watch(
      directMessageViewModelProvider.select((e) => e.items),
    );
    final sessions = ref.watch(
      directMessageViewModelProvider.select((e) => e.sessions),
    );
    return Container(
      padding: EdgeInsets.all(20),
      color: Theme.of(context).appColor.directMessageBackground,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        spacing: 10,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('消息', style: TextStyle(fontSize: 20)),
              Spacer(),
              IconButton(
                onPressed: () {
                  context.go(MainRoute.settings);
                },
                icon: Icon(Icons.settings, size: 25),
              ),
            ],
          ),
          CommonTabBar(
            items: items,
            initialIndex: 0,
            onTap: (index, item) {
              _viewModel.changeTab(index);
            },
          ),
          Expanded(
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: sessions.length,
              separatorBuilder: (context, index) {
                return 15.hSize;
              },
              itemBuilder: (context, index) {
                return _buildSessionItem(index, sessions[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSessionItem(int index, SessionData session) {
    return Builder(
      key: ValueKey(session.sessionTakerId),
      builder: (ctx) {
        return GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: (){
            _viewModel.enterSessionSection(session);
          },
          child: SecondaryClickMenuWrapper(
            items: buildSessionMenuItems(session),
            onSelected: (value) {
              handleSession(index, session, value);
            },
            child: Row(
              spacing: 10,
              children: [
                CircleAvatar(
                  backgroundImage: CachedNetworkImageProvider(session.userFace),
                  radius: 20,
                ),
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(session.userName),
                            Text(
                              session.lastMsg,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                      Text(formatVideoTime(session.timestamp)),
                    ],
                  ),
                ),
                if (session.unreadCount > 0)
                  CircleAvatar(
                    radius: 10,
                    backgroundColor: Colors.red,
                    child: Center(
                      child: Text(
                        session.unreadCount.toString(),
                        style: TextStyle(color: Colors.white, height: 1, fontSize: 12),
                      ),
                    ),
                  )
                else
                  Icon(Icons.keyboard_arrow_right_rounded, size: 20),
              ],
            ),
          ),
        );
      }
    );
  }

  void handleSession(int index, SessionData session, int type) {
    switch (type) {
      case 0:
        _viewModel.updateSession(index, session);
        break;
      case 1:
        _viewModel.topSession(index, session);
        break;
      case 2:
        _viewModel.removeSession(index, session);
        break;
    }
  }

  List<PopupMenuItem> buildSessionMenuItems(SessionData session) {
    List<PopupMenuItem> items = [];
    if (session.unreadCount > 0) {
      items.add(PopupMenuItem(value: 0, child: Text("标记为已读")));
    }
    items.add(PopupMenuItem(value: 1, child: Text(session.isTop ? '取消置顶' : "置顶")));
    items.add(PopupMenuItem(value: 2, child: Text("删除会话")));
    return items;
  }
}
