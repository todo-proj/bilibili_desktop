import 'package:bilibili_desktop/src/business/common/widget/common_tab_bar.dart';
import 'package:bilibili_desktop/src/business/home/hot/hot_view_model.dart';
import 'package:bilibili_desktop/src/business/home/hot/comprehensive_hot/comprehensive_hot_page.dart';
import 'package:bilibili_desktop/src/business/home/hot/weekly_must_watch/weekly_must_watch_page.dart';
import 'package:bilibili_desktop/src/business/home/hot/must_watch/must_watch_page.dart';
import 'package:bilibili_desktop/src/business/home/hot/ranking/ranking_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HotPage extends ConsumerStatefulWidget {
  const HotPage({super.key});

  @override
  ConsumerState<HotPage> createState() => _HotPageState();
}

class _HotPageState extends ConsumerState<HotPage> {
  late HotViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = ref.read(hotViewModelProvider.notifier);
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(hotViewModelProvider);
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          child: CommonTabBar(
            items: state.items,
            initialIndex: state.currentIndex,
            onTap: (index, item) {
              _viewModel.changeTab(item.tag);
            },
          ),
        ),
        Expanded(
          child: IndexedStack(
            index: state.currentIndex,
            children: const [
              ComprehensiveHotPage(),
              WeeklyMustWatchPage(),
              MustWatchPage(),
              RankingPage(),
            ],
          ),
        ),
      ],
    );
  }
}
