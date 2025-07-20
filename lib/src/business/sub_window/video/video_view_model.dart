import 'package:bilibili_desktop/src/business/common/widget/common_tab_bar.dart';
import 'package:bilibili_desktop/src/business/sub_window/video/state.dart';
import 'package:bilibili_desktop/src/providers/api_provider.dart';
import 'package:bilibili_desktop/src/utils/logger.dart';
import 'package:bilibili_desktop/src/utils/wbi_check_util.dart';
import 'package:flutter/material.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'video_view_model.g.dart';

@riverpod
class VideoViewModel extends _$VideoViewModel {
  // Create a [Player] to control playback.
  late final player = Player();

  // Create a [VideoController] to handle video output from [Player].
  late final controller = VideoController(player);

  @override
  VideoPageState build() {
    ref.onDispose(() {
      player.dispose();
    });
    return VideoPageState(
      owner: Owner(),
      items: [TabBarItem("简介", "intro"), TabBarItem("评论", "comment")],
      selectedItemIndex: 0,
    );
  }


  void getVideoInfo(String bvid, String cid, String mid) async {
    final api = await ref.read(apiProvider);
    try {
      final videoInfoRequest = api.videoInfo(bvid).handle();
      // 获取视频up信息
      final upInfoRequest = api.userCard(mid).handle();
      // 获取视频url
      // webi验证
      final params = WbiCheckUtil.generateWbiParams({
        "bvid": bvid,
        "cid": cid,
        "qn": "80",
      });
      final videoUrlRequest = api.videoUrl(params).handle();
      // 获取关联视频
      final relatedVideoRequest = api.getRelatedVideo(bvid).handle();

      final videoInfo = await videoInfoRequest;
      final upInfo = await upInfoRequest;
      final videoUrl = await videoUrlRequest;
      final relatedVideo = await relatedVideoRequest;
      debugPrint('finish_getVideoInfo');
      state = state.copyWith(
        url: videoUrl.durl[0].url,
        title: videoInfo.title,
        cid: videoInfo.cid,
        bvid: bvid,
        desc: videoInfo.desc,
        relatedVideo: relatedVideo,
        pages: videoInfo.pages,
        owner: Owner(
          mid: upInfo.card.mid,
          name: upInfo.card.name,
          face: upInfo.card.face,
          following: upInfo.following,
          follower: upInfo.follower,
          likeNum: upInfo.likeNum,
        ),
        intro: VideoIntro(
          coinNum: videoInfo.stat.coin,
          collectNum: videoInfo.stat.favorite,
          likeNum: videoInfo.stat.like,
          shareNum: videoInfo.stat.share,
        ),
      );
      debugPrint('play_video');
      if (state.url.isNotEmpty) {
        player.open(
          Media(
            state.url,
            httpHeaders: {"Referer": "https://www.bilibili.com"},
          ),
        );
      }
    } catch (e, s) {
      L.e(e, stackTrace: s);
    }
  }

  void generateItems() {}

  void changeTab(int index) {
    state = state.copyWith(selectedItemIndex: index);
  }

  void toggleIntro() {
    state = state.copyWith(intro: state.intro.copyWith(showDesc: !state.intro.showDesc));
  }
}
