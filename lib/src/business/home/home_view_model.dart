import 'package:bilibili_desktop/src/business/common/common_tab_bar.dart';
import 'package:equatable/equatable.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_view_model.g.dart';

class HomePageType {
  static const String live = "live";
  static const String recommend = "recommend";
  static const String hot = "hot";
  static const String chase = "chase";
  static const String movie = "movie";
}

@riverpod
class HomeViewModel extends _$HomeViewModel {
  @override
  HomePageState build() {
    return HomePageState(items: _generateTabBarItems(), currentTag: HomePageType.recommend, initialIndex: 1, currentIndex: 1);
  }

  List<TabBarItem> _generateTabBarItems() {
    return [
      TabBarItem("直播", HomePageType.live),
      TabBarItem("推荐", HomePageType.recommend),
      TabBarItem("热门", HomePageType.hot),
      TabBarItem("追番", HomePageType.chase),
      TabBarItem("影视", HomePageType.movie),
    ];
  }

  void changeTab(String tag) {
    state = state.copyWith(currentTag: tag, currentIndex: state.items.indexWhere((element) => element.tag == tag));
  }
}


class HomePageState extends Equatable {
  final List<TabBarItem> items;
  final String currentTag;
  final int initialIndex;
  final int currentIndex;

  const HomePageState({
    required this.items,
    required this.currentTag,
    required this.initialIndex,
    required this.currentIndex,
  });


  copyWith({
    List<TabBarItem>? items,
    String? currentTag,
    int? initialIndex,
    int? currentIndex,
  }) {
    return HomePageState(
      items: items ?? this.items,
      currentTag: currentTag ?? this.currentTag,
      initialIndex: initialIndex ?? this.initialIndex,
      currentIndex: currentIndex ?? this.currentIndex,
    );
  }

  @override
  List<Object?> get props => [items, currentTag, initialIndex, currentIndex];

}