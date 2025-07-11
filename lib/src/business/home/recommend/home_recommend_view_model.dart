import 'package:bilibili_desktop/src/http/model/recommend_video_model.dart' show Item;
import 'package:bilibili_desktop/src/providers/api_provider.dart';
import 'package:bilibili_desktop/src/utils/logger.dart';
import 'package:equatable/equatable.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_recommend_view_model.g.dart';

@riverpod
class HomeRecommendViewModel extends _$HomeRecommendViewModel {
  @override
  HomeRecommendState build() {
    refresh();
    return HomeRecommendState(items: []);
  }

  void refresh() async{
    final response = await getRecommendList();
    state = state.copyWith(items: response);
  }

  void loadMore() async{
    final response = await getRecommendList();
    state = state.copyWith(items: [...state.items, ...response]);
  }

  Future<List<Item>> getRecommendList() async {
    final api = await ref.read(apiProvider);
    state = state.copyWith(loading: true);
    try {
      final response = await api.getRecommendVideoList(20).handle();
      state = state.copyWith(loading: false);
      return response.item;
    }catch(e) {
      L.e("getRecommendList error: $e");
      state = state.copyWith(loading: false);
    }
    return [];
  }
}


class HomeRecommendState extends Equatable{
  final List<Item> items;
  final bool loading;

  const HomeRecommendState({
    required this.items,
    this.loading = false,
  });

  copyWith({
    List<Item>? items,
    bool? loading,
  }) {
    return HomeRecommendState(
      items: items ?? this.items,
      loading: loading ?? this.loading,
    );
  }

  @override
  List<Object?> get props => [items, loading];
}