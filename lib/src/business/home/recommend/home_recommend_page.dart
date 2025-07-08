import 'package:bilibili_desktop/src/business/home/recommend/home_recommend_view_model.dart';
import 'package:bilibili_desktop/src/http/model/recommend_video_model.dart' show Item;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeRecommendPage extends ConsumerStatefulWidget {
  const HomeRecommendPage({super.key});

  @override
  ConsumerState<HomeRecommendPage> createState() => _HomeRecommendPageState();
}

class _HomeRecommendPageState extends ConsumerState<HomeRecommendPage> {

  final ScrollController _scrollController = ScrollController();
  late HomeRecommendViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = ref.read(homeRecommendViewModelProvider.notifier);
    _scrollController.addListener((){
      final loading = ref.read(homeRecommendViewModelProvider.select((e)=>e.loading));
      if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent && !loading) {
        _viewModel.loadMore();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final items = ref.watch(homeRecommendViewModelProvider.select((e)=>e.items));
    return GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 4, // 每行显示 4 个 item
      mainAxisSpacing: 10, // 垂直间距
      crossAxisSpacing: 10, // 水平间距
      childAspectRatio: 1.33, // 宽高比
    ), itemCount: items.length,
        itemBuilder: (context, index) {
      return _buildItem(context, items[index]);
    });
  }


  Widget _buildItem(BuildContext context, Item item) {
    return Container(
      color: Colors.blue,
      child: Text('Item $item'),
    );
  }
}
