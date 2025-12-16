import 'package:bilibili_desktop/src/business/common/widget/common_tab_bar.dart';
import 'package:equatable/equatable.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'hot_view_model.g.dart';

class HotPageType {
  static const String comprehensive = "comprehensive";
  static const String weekly = "weekly";
  static const String mustWatch = "mustWatch";
  static const String ranking = "ranking";
}

@riverpod
class HotViewModel extends _$HotViewModel {
  @override
  HotPageState build() {
    return HotPageState(
      items: _generateTabBarItems(),
      currentTag: HotPageType.comprehensive,
      currentIndex: 0,
    );
  }

  List<TabBarItem> _generateTabBarItems() {
    return [
      TabBarItem("综合热门", HotPageType.comprehensive),
      TabBarItem("每周必看", HotPageType.weekly),
      TabBarItem("入站必刷", HotPageType.mustWatch),
      TabBarItem("排行榜", HotPageType.ranking),
    ];
  }

  void changeTab(String tag) {
    state = state.copyWith(
      currentTag: tag,
      currentIndex: state.items.indexWhere((element) => element.tag == tag),
    );
  }
}

class HotPageState extends Equatable {
  final List<TabBarItem> items;
  final String currentTag;
  final int currentIndex;

  const HotPageState({
    required this.items,
    required this.currentTag,
    required this.currentIndex,
  });

  copyWith({
    List<TabBarItem>? items,
    String? currentTag,
    int? currentIndex,
  }) {
    return HotPageState(
      items: items ?? this.items,
      currentTag: currentTag ?? this.currentTag,
      currentIndex: currentIndex ?? this.currentIndex,
    );
  }

  @override
  List<Object?> get props => [items, currentTag, currentIndex];
}
