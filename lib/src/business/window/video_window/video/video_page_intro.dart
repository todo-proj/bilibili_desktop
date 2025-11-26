import 'package:bilibili_desktop/src/business/common/widget/common_widget.dart';
import 'package:bilibili_desktop/src/providers/theme/extension/app_color.dart';
import 'package:bilibili_desktop/src/utils/asset_util.dart';
import 'package:bilibili_desktop/src/utils/string_util.dart';
import 'package:bilibili_desktop/src/utils/widget_util.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'video_view_model.dart';

class VideoPageIntro extends ConsumerStatefulWidget {
  const VideoPageIntro({super.key});

  @override
  ConsumerState<VideoPageIntro> createState() => _VideoPageIntroState();
}

class _VideoPageIntroState extends ConsumerState<VideoPageIntro> {
  late VideoViewModel _vm;

  @override
  void initState() {
    super.initState();
    _vm = ref.read(videoViewModelProvider.notifier);
  }

  @override
  Widget build(BuildContext context) {
    final owner = ref.watch(videoViewModelProvider.select((e) => e.owner));
    final videoTitle = ref.watch(videoViewModelProvider.select((e) => e.title));
    final videoDesc = ref.watch(videoViewModelProvider.select((e) => e.desc));
    final intro = ref.watch(videoViewModelProvider.select((e) => e.intro));
    final pages = ref.watch(videoViewModelProvider.select((e) => e.pages));
    final relatedVideo = ref.watch(
      videoViewModelProvider.select((e) => e.relatedVideo),
    );
    return SizedBox.expand(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              spacing: 10,
              children: [
                ClipOval(child: userAvatar(url: owner.face, size: 50, context: context)),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        owner.name,
                        style: TextStyle(
                          fontSize: 14,
                          color: Theme.of(context).appColor.videoPageText,
                        ),
                      ),
                      Row(
                        spacing: 10,
                        children: [
                          Text(
                            "${StringUtils.formatNum(owner.follower)}粉丝",
                            style: TextStyle(
                              color: Theme.of(context).appColor.videoPageText,
                              fontSize: 11,
                            ),
                          ),
                          CircleAvatar(
                            backgroundColor: Theme.of(context).appColor.videoPageSecondaryText,
                            radius: 1,
                          ),
                          Text(
                            "${StringUtils.formatNum(owner.likeNum)}点赞",
                            style: TextStyle(
                              color: Theme.of(context).appColor.videoPageText,
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                followButton(context, "关注", () {}),
              ],
            ),
            20.hSize,
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        videoTitle,
                        style: TextStyle(
                          color: Theme.of(context).appColor.videoPageText,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      intro.showDesc
                          ? Text(
                              videoDesc,
                              style: TextStyle(
                                color: Theme.of(context).appColor.videoPageSecondaryText,
                              ),
                            )
                          : SizedBox.shrink(),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: GestureDetector(
                    onTap: () {
                      _vm.toggleIntro();
                    },
                    child: Row(
                      children: [
                        AnimatedContainer(
                          duration: Duration(milliseconds: 300),
                          child: Text(
                            intro.showDesc ? "展开" : "收起",
                            style: TextStyle(
                              color: Theme.of(context).appColor.videoPageText,
                            ),
                          ),
                        ),
                        AnimatedRotation(
                          turns: intro.showDesc ? 0.5 : 0,
                          duration: Duration(milliseconds: 300),
                          child: Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: Theme.of(context).appColor.videoPageText,
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            15.hSize,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildVideoStat(
                  StringUtils.formatNum(intro.likeNum),
                  "icon_thumb_up".png,
                  () {},
                ),
                _buildVideoStat(
                  StringUtils.formatNum(intro.coinNum),
                  "icon_coin".png,
                  () {},
                ),
                _buildVideoStat(
                  StringUtils.formatNum(intro.collectNum),
                  "icon_collect".png,
                  () {},
                ),
                _buildVideoStat("缓存", "icon_download".png, () {}),
                _buildVideoStat(
                  StringUtils.formatNum(intro.shareNum),
                  "icon_share".png,
                  () {},
                ),
              ],
            ),
            //分P
            pages.length > 1
                ? Container(
                    constraints: BoxConstraints(maxHeight: 200),
                    decoration: BoxDecoration(
                      color: Theme.of(context).appColor.videoPageBackground,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    margin: EdgeInsets.only(top: 20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('title'),
                        Divider(),
                        Row(),
                        Flexible(
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: pages.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Text(
                                  pages[index].pagePart,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Theme.of(context).appColor.videoPageText,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  )
                : SizedBox.shrink(),
            20.hSize,
            //related video
            Column(
              spacing: 15,
              children: [
                ...relatedVideo.map(
                      (item) => GestureDetector(
                    onTap: (){
                      _vm.getVideoInfo(item.bvid);
                    },
                    child: SizedBox(
                      height: 78,
                      width: double.infinity,
                      child: Row(
                        spacing: 10,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Stack(
                              children: [
                                CachedNetworkImage(
                                  imageUrl: item.pic,
                                  fit: BoxFit.cover,
                                  width: 140,
                                ),
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  left: 0,
                                  child: Container(
                                    height: 30,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          Colors.transparent,
                                          Theme.of(context).appColor.videoPageBackground,
                                        ],
                                      ),
                                    ),
                                    child: Align(
                                      alignment: Alignment(0.8, 0.4),
                                      child: Text(
                                        StringUtils.formatDuration(item.duration),
                                        style: TextStyle(
                                          color: Theme.of(context).appColor.videoPageText,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: 2,
                              children: [
                                Text(
                                  item.title,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Theme.of(context).appColor.videoPageText,
                                  ),
                                ),
                                Spacer(),
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                      'icon_author'.svg,
                                      semanticsLabel: 'UP作者',
                                      width: 15,
                                      height: 15,
                                      colorFilter: ColorFilter.mode(
                                        Theme.of(context).appColor.videoPageSecondaryText,
                                        BlendMode.srcIn,
                                      ),
                                    ),
                                    Text(
                                      item.owner.name,
                                      style: TextStyle(
                                        color: Theme.of(context).appColor.videoPageSecondaryText,
                                        fontSize: 11,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.play_circle_outline_rounded,
                                      size: 15,
                                      color: Theme.of(context).appColor.videoPageSecondaryText,
                                    ),
                                    Text(
                                      StringUtils.formatNum(item.stat.view),
                                      style: TextStyle(
                                        color: Theme.of(context).appColor.videoPageSecondaryText,
                                        fontSize: 11,
                                      ),
                                    ),
                                    5.wSize,
                                    Icon(
                                      Icons.message,
                                      size: 15,
                                      color: Theme.of(context).appColor.videoPageSecondaryText,
                                    ),
                                    Text(
                                      StringUtils.formatNum(item.stat.danmaku),
                                      style: TextStyle(
                                        color: Theme.of(context).appColor.videoPageSecondaryText,
                                        fontSize: 11,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVideoStat(String title, String icon, VoidCallback onTap) {
    return IconButton(
      onPressed: onTap,
      style: ButtonStyle(
        padding: WidgetStateProperty.all(
          EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        ),
        backgroundColor: WidgetStateProperty.resolveWith<Color?>((
          Set<WidgetState> states,
        ) {
          if (states.contains(WidgetState.hovered)) {
            return Theme.of(context).appColor.videoPageBackground;
          }
          return Colors.transparent;
        }),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4), // 圆角
          ),
        ),
      ),
      icon: Column(
        children: [
          Image.asset(
            icon,
            width: 25,
            height: 25,
            color: Theme.of(context).appColor.videoPageSecondaryText,
          ),
          10.hSize,
          Text(
            title,
            style: TextStyle(
              fontSize: 11,
              color: Theme.of(context).appColor.videoPageText,
            ),
          ),
        ],
      ),
    );
  }
}
