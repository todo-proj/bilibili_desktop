import 'package:bilibili_desktop/src/business/home/home_view_model.dart';
import 'package:bilibili_desktop/src/business/home/recommend/home_recommend_page.dart';
import 'package:bilibili_desktop/src/business/home/recommend/home_recommend_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {

  late HomeViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = ref.read(homeViewModelProvider.notifier);
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(homeViewModelProvider);
    return IndexedStack(
      index: state.currentIndex,
      children: [
        HomeRecommendPage(),
        HomeRecommendPage(),
        HomeRecommendPage(),
        HomeRecommendPage(),
        HomeRecommendPage(),
      ],
    );
  }

}
