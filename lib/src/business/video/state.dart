import 'package:bilibili_desktop/src/business/common/widget/common_tab_bar.dart';
import 'package:bilibili_desktop/src/http/model/recommend_video_model.dart';
import 'package:equatable/equatable.dart';

class VideoPageState extends Equatable {
  final String bvid;
  final String cid;
  final String title;
  final String url;
  final String desc;
  final Owner owner;
  final List<TabBarItem> items;
  final List<Item> relatedVideo;
  final int selectedItemIndex;
  final VideoIntro intro;

  const VideoPageState({
    this.bvid = "",
    this.cid = "",
    this.title = "",
    this.desc = "",
    this.url = "",
    this.intro = const VideoIntro(),
    required this.items,
    this.relatedVideo = const [],
    required this.selectedItemIndex,
    required this.owner,
  });

  VideoPageState copyWith({
    String? bvid,
    String? title,
    String? desc,
    String? url,
    String? cid,
    List<TabBarItem>? items,
    List<Item>? relatedVideo,
    int? selectedItemIndex,
    Owner? owner,
    VideoIntro? intro,
  }) {
    return VideoPageState(
      bvid: bvid ?? this.bvid,
      cid: cid ?? this.cid,
      title: title ?? this.title,
      desc: desc ?? this.desc,
      url: url ?? this.url,
      items: items ?? this.items,
      relatedVideo: relatedVideo ?? this.relatedVideo,
      selectedItemIndex: selectedItemIndex ?? this.selectedItemIndex,
      owner: owner ?? this.owner,
      intro: intro ?? this.intro,
    );
  }

  @override
  List<Object?> get props => [
    bvid,
    title,
    desc,
    url,
    cid,
    items,
    selectedItemIndex,
    owner,
    relatedVideo,
    intro,
  ];
}

class Owner extends Equatable {
  final String mid;
  final String name;
  final String face;
  final bool following;
  final int follower;
  final int likeNum;

  const Owner({
    this.mid = "",
    this.name = "",
    this.face = "",
    this.following = false,
    this.follower = 0,
    this.likeNum = 0,
  });

  @override
  List<Object?> get props => [mid, name, face, following, follower, likeNum];
}


class VideoIntro extends Equatable {
  final bool showDesc;
  const VideoIntro({
    this.showDesc = false,
  });

  copyWith({
    bool? showDesc,
  }) {
    return VideoIntro(
      showDesc: showDesc ?? this.showDesc,
    );
  }

  @override
  List<Object?> get props => [showDesc];
}