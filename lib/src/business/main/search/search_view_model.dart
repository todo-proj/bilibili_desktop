import 'package:bilibili_desktop/src/business/common/event_dispatcher_mixin.dart';
import 'package:bilibili_desktop/src/http/model/search_result_model.dart'
    show Datum;
import 'package:bilibili_desktop/src/providers/api_provider.dart';
import 'package:bilibili_desktop/src/utils/app_storage.dart';
import 'package:bilibili_desktop/src/utils/logger.dart' show L;
import 'package:bilibili_desktop/src/utils/wbi_check_util.dart'
    show WbiCheckUtil;
import 'package:equatable/equatable.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'search_view_model.g.dart';

@Riverpod(keepAlive: true)
class SearchViewModel extends _$SearchViewModel {
  @override
  SearchState build() {
    return SearchState(
      history: _getSearchHistory(),
      items: [
        SearchTabBarItem(
          type: SearchType.all,
          children: [
            SearchTabBarItem(type: SearchType.mediaBangumi),
            SearchTabBarItem(type: SearchType.mediaFt),
            SearchTabBarItem(type: SearchType.video),
          ],
        ),
        SearchTabBarItem(type: SearchType.video),
        SearchTabBarItem(type: SearchType.mediaBangumi),
        SearchTabBarItem(type: SearchType.mediaFt),
        SearchTabBarItem(
          type: SearchType.live,
          children: [
            SearchTabBarItem(type: SearchType.live),
            SearchTabBarItem(type: SearchType.liveUser),
            SearchTabBarItem(type: SearchType.liveRoom),
          ],
        ),
        SearchTabBarItem(type: SearchType.biliUser),
      ],
    );
  }

  void search(String keyword) async {
    if (keyword.isEmpty) {
      return;
    }
    emitToStream(OpenSearchPageEvent());
    _addSearchHistory(keyword);
    final api = await ref.read(apiProvider);
    // webi验证
    final params = WbiCheckUtil.generateWbiParams({"keyword": keyword});
    Map<SearchType, SearchTabBarItem> searchItems = {};
    try {
      final searchResult = await api.searchAll(params).handle();
      searchResult.pageInfo.forEach((k, v) {
        final type = SearchType.fromName(k);
        if (type == SearchType.empty) return;
        searchItems[type] = SearchTabBarItem(
          type: type,
          pages: v.pages,
          total: v.total,
        );
      });
      for (var v in searchResult.result) {
        final type = SearchType.fromName(v.resultType);
        if (type == SearchType.empty) continue;
        searchItems[type] = searchItems[type]?.copyWith(data: v.data);
      }
      // 组合primaryItems
      List<SearchTabBarItem> primaryItems = [];
      primaryItems.add(_generateMultiTabBarItem(searchItems, SearchType.all, [
        SearchType.mediaFt,
        SearchType.mediaBangumi,
        SearchType.video,
      ]).copyWith(showNum: false));
      _addItemToPrimary(primaryItems, searchItems, SearchType.video);
      _addItemToPrimary(primaryItems, searchItems, SearchType.mediaFt);
      _addItemToPrimary(primaryItems, searchItems, SearchType.mediaBangumi);
      primaryItems.add(_generateMultiTabBarItem(searchItems, SearchType.live, [
        SearchType.live,
        SearchType.liveUser,
        SearchType.liveRoom,
      ]));
      _addItemToPrimary(primaryItems, searchItems, SearchType.biliUser);
      state = state.copyWith(items: primaryItems, showPage: true);
    } catch (e, s) {
      L.e(e, stackTrace: s);
    }
  }

  void clearSearchHistory() {
    state = state.copyWith(history: []);
    AppStorage.setStringList(AppStorageKeys.searchHistory, []);
  }

  SearchTabBarItem _generateMultiTabBarItem(Map<SearchType, SearchTabBarItem> searchItems, SearchType container, List<SearchType> children) {
    final empty = SearchTabBarItem(
      type: SearchType.empty,
      pages: 0,
      total: 0,
    );
    final List<SearchTabBarItem> items = children.map((e)=> searchItems[e] ?? empty).where((e)=>e != empty).toList();
    final pages = items.map((e)=>e.pages).fold(0, (previousValue, element) => previousValue + element);
    final total = items.map((e)=>e.total).fold(0, (previousValue, element) => previousValue + element);
    return SearchTabBarItem(type: container, pages: pages, total: total, children: items);
  }

  List<String> _getSearchHistory() {
    return AppStorage.getStringList(AppStorageKeys.searchHistory);
  }

  void _addItemToPrimary(List<SearchTabBarItem> primaryItems, Map<SearchType, SearchTabBarItem> searchItems, SearchType type) {
    final item = searchItems[type];
    if (item != null) {
      primaryItems.add(item);
    }
  }

  void _addSearchHistory(String keyword) {
    if (keyword.isEmpty) {
      return;
    }
    List<String> history = [...state.history];
    history.insert(0, keyword);
    if (history.length > 10) {
      history = history.sublist(0, 10);
    }
    state = state.copyWith(history: history);
    AppStorage.setStringList(AppStorageKeys.searchHistory, history);
  }

}

class SearchState extends Equatable {
  final List<SearchTabBarItem> items;
  final int primaryIndex;
  final bool showPage;
  final List<String> history;

  const SearchState({this.items = const [], this.primaryIndex = 0, this.showPage = false, this.history = const []});

  copyWith({List<SearchTabBarItem>? items, int? primaryIndex, bool? showPage, List<String>? history}) {
    return SearchState(
      items: items ?? this.items,
      primaryIndex: primaryIndex ?? this.primaryIndex,
      showPage: showPage ?? this.showPage,
      history: history ?? this.history,
    );
  }

  @override
  List<Object?> get props => [items, primaryIndex, showPage, history];
}

class SearchTabBarItem extends Equatable {
  final SearchType type;
  final int pages;
  final int total;
  final List<Datum> data;
  final bool showNum;
  final List<SearchTabBarItem> children;

  const SearchTabBarItem({
    required this.type,
    this.pages = 0,
    this.total = 0,
    this.showNum = true,
    this.data = const [],
    this.children = const [],
  });

  copyWith({
    SearchType? type,
    int? pages,
    int? total,
    List<Datum>? data,
    bool? showNum,
    List<SearchTabBarItem>? children,
  }) {
    return SearchTabBarItem(
      type: type ?? this.type,
      pages: pages ?? this.pages,
      total: total ?? this.total,
      data: data ?? this.data,
      showNum: showNum ?? this.showNum,
      children: children ?? this.children,
    );
  }

  @override
  List<Object?> get props => [type, pages, total, children, showNum];
}

enum SearchType {
  all("综合", 'all'),
  liveRoom("直播间", 'live_room'),
  live("直播", 'live'),
  liveUser("主播", 'live_user'),
  video("视频", 'video'),
  biliUser("用户", 'bili_user'),
  mediaFt("影视", 'media_ft'),
  mediaBangumi("番剧", 'media_bangumi'),
  empty("无", '');

  final String name;
  final String tag;

  const SearchType(this.name, this.tag);

  factory SearchType.fromName(String tag) {
    return SearchType.values.firstWhere(
      (element) => element.tag == tag,
      orElse: () => SearchType.empty,
    );
  }
}

class OpenSearchPageEvent {}
