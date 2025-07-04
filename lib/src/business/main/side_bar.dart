import 'package:bilibili_desktop/src/business/main/main_view_model.dart';
import 'package:bilibili_desktop/src/business/main/side_bar_item.dart';
import 'package:bilibili_desktop/src/providers/theme/themes_provider.dart';
import 'package:bilibili_desktop/src/router/main_route.dart';
import 'package:bilibili_desktop/src/utils/widget_util.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';



class SideBar extends ConsumerStatefulWidget {
  const SideBar({super.key});

  @override
  ConsumerState<SideBar> createState() => _SideBarState();
}

class _SideBarState extends ConsumerState<SideBar> {
  String _currentTag = MainRoute.home;

  @override
  Widget build(BuildContext context) {
    debugPaintSizeEnabled = false;
    final items = ref.watch(mainViewModelProvider.select((v)=> v.sideBarItems));

    return Container(
      width: 80,
      color: Colors.grey.withAlpha(111),
      child: Column(
        spacing: 10,
        children: [
          50.hSize,
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Icon(Icons.arrow_back_ios_new_rounded, size: 20),
          ),
          10.hSize,
          ...List.generate(items.length, (index) {
            return _buildItem(items[index]);
          }),
          20.hSize,
        ],
      ),
    );
  }

  Widget _buildItem(SideBarItem item) {
    final isSelected = item.tag == _currentTag && item.maintainState;
    if (item.tag == MainRoute.zone) {
      return GestureDetector(
        child: _buildItemZone(item),
        onTap: () {
          _onTap(item);
        },
      );
    }

    if (item.child != null) {
      return GestureDetector(
        child: item.child,
        onTap: () {
          _onTap(item);
        },
      );
    }
    if (item.icon != null && item.title != null) {
      return SizedBox(
        height: 60,
        child: TextButton(
          statesController: WidgetStatesController(isSelected ? {WidgetState.selected} : {}),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(item.icon, size: 30,),
              3.hSize,
              Text(item.title!, style: TextStyle(fontSize: 12, )),
            ],
          ),
          onPressed: () {
            _onTap(item);
          },
        ),
      );
    }
    if (item.icon != null ) {
      return IconButton(
        isSelected: isSelected,
        onPressed: () {
          _onTap(item);
        },
        icon: Icon(item.icon),
      );
    }
    return const Spacer();
  }

  Widget _buildItemZone(SideBarItem item) {
    final defaultAvatar = Image.asset('assets/images/icon_default_avatar.png', width: 20, color: Colors.grey,);
    if (item.object == null) {
      return defaultAvatar;
    }
    final isLogin = item.object['isLogin'];
    final avatar = item.object['avatar'];
    if (!isLogin) {
      return defaultAvatar;
    }
    return CachedNetworkImage(
      imageUrl: avatar,
      placeholder: (context, url) => CircularProgressIndicator(),
      errorWidget: (context, url, error) => defaultAvatar,
    );
  }


  void _onTap(SideBarItem item) {
    if (item.tag == _currentTag) return;
    switch(item.tag) {
      case MainRoute.home:
      case MainRoute.zone:
      case MainRoute.featured:
      case MainRoute.following:
      case MainRoute.settings:
        context.go(item.tag);
        break;
      case MainRoute.theme:
        ref.read(themesProvider.notifier).toggleTheme();
        ref.read(mainViewModelProvider.notifier).refreshSideBar();
        break;
    }
    setState(() {
      if (item.maintainState) {
        _currentTag = item.tag;
      }
    });
  }
}
