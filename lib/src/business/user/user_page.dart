import 'package:bilibili_desktop/src/business/common/widget/common_tab_bar.dart';
import 'package:bilibili_desktop/src/business/common/widget/common_widget.dart';
import 'package:bilibili_desktop/src/business/common/widget/hover_widget.dart';
import 'package:bilibili_desktop/src/business/home/home_page_head.dart';
import 'package:bilibili_desktop/src/business/user/user_center.dart';
import 'package:bilibili_desktop/src/providers/theme/extension/app_color.dart';
import 'package:bilibili_desktop/src/utils/widget_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserPage extends ConsumerStatefulWidget {
  const UserPage({super.key});

  @override
  ConsumerState<UserPage> createState() => _UserPageState();
}

class _UserPageState extends ConsumerState<UserPage> {
  @override
  Widget build(BuildContext context) {
    final userInfo = ref.watch(
      userCenterProviderProvider.select((e) => e.userInfo),
    );
    final coin = ref.watch(userCenterProviderProvider.select((e) => e.coin));
    final bCoinBalance = ref.watch(
      userCenterProviderProvider.select((e) => e.bCoinBalance),
    );
    final dynamicNum = ref.watch(
      userCenterProviderProvider.select((e) => e.dynamicNum),
    );
    final followerNum = ref.watch(
      userCenterProviderProvider.select((e) => e.followerNum),
    );
    final followingNum = ref.watch(
      userCenterProviderProvider.select((e) => e.followingNum),
    );
    final items = ref.watch(
      userCenterProviderProvider.select((e) => e.items),
    );
    final isLogin = userInfo?.isLogin ?? false;
    final defaultHoverColor = Theme.of(context).appColor.hoverColor;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainer,
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
              child: Row(
                spacing: 20,
                children: [
                  userAvatar(url: userInfo?.face, size: 80),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      isLogin
                          ? HoverText(
                              text: userInfo?.uname ?? '',
                              hoverColor: defaultHoverColor,
                            )
                          : Text('点击登录', style: TextStyle(fontSize: 18)),
                      Row(
                        children: [
                          Row(
                            children: [
                              Text('B币: ', style: TextStyle(fontSize: 13)),
                              HoverText(
                                text: bCoinBalance,
                                hoverColor: defaultHoverColor,
                                style: TextStyle(fontSize: 13)
                              ),
                            ],
                          ),
                          20.wSize,
                          Row(
                            children: [
                              Text('硬币: ', style: TextStyle(fontSize: 13)),
                              HoverText(text: coin, hoverColor: defaultHoverColor, style: TextStyle(fontSize: 13)),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  Spacer(),
                  SizedBox(
                    width: 240,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          spacing: 15,
                          children: [
                            _buildItem(dynamicNum, defaultHoverColor, TextStyle(fontSize: 13)),
                            Text('动态', style: TextStyle(fontSize: 13),),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                          child: VerticalDivider(
                            color: Colors.grey,
                            width: 5,
                            thickness: 0.5,
                          ),
                        ),
                        Column(
                          spacing: 15,
                          children: [
                            _buildItem(followingNum, defaultHoverColor, TextStyle(fontSize: 13)),
                            Text('关注', style: TextStyle(fontSize: 13)),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                          child: VerticalDivider(
                            color: Colors.grey,
                            width: 5,
                            thickness: 0.5,
                          ),
                        ),
                        Column(
                          spacing: 15,
                          children: [
                            _buildItem(followerNum, defaultHoverColor, TextStyle(fontSize: 13)),
                            Text('粉丝', style: TextStyle(fontSize: 13)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  20.wSize,
                  TextButton(onPressed: (){}, child: Row(
                    children: [
                      Text('空间'),
                      Icon(Icons.keyboard_arrow_right_rounded)
                    ],
                  ))
                ],
              ),
            ),
            20.hSize,
            Divider(color: Colors.grey,),
            20.hSize,
            CommonTabBar(items: items, initialIndex: 0, onTap: (index, tag){})
          ],
        ),
      ),
    );
  }

  Widget _buildItem(String content, Color hoverColor, TextStyle style) {
    if (content.isNotEmpty) {
      return HoverText(text: content, hoverColor: hoverColor, style: style,);
    }
    return SizedBox(
      width: 5,
      height: 1,
      child: ColoredBox(color: Theme.of(context).colorScheme.onSurface),
    );
  }
}
