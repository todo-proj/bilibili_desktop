import 'package:bilibili_desktop/src/business/common/widget/common_tab_bar.dart';
import 'package:bilibili_desktop/src/business/home/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePageHead extends ConsumerStatefulWidget {
  const HomePageHead({super.key});

  @override
  ConsumerState<HomePageHead> createState() => _HomePageHeadState();
}

class _HomePageHeadState extends ConsumerState<HomePageHead> {

  late HomeViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = ref.read(homeViewModelProvider.notifier);
  }

  @override
  Widget build(BuildContext context) {
    final items = ref.read(homeViewModelProvider.select((e)=>e.items));
    final currentIndex = ref.read(homeViewModelProvider.select((e)=>e.currentIndex));
    return CommonTabBar(items: items, initialIndex: currentIndex, onTap: (index, item) {
      _viewModel.changeTab(item.tag);
    });
  }
}
