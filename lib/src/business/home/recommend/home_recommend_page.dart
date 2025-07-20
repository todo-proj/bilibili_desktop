import 'package:bilibili_desktop/src/business/common/reesponsive_grid_delegate.dart';
import 'package:bilibili_desktop/src/business/common/widget/common_widget.dart';
import 'package:bilibili_desktop/src/business/home/recommend/home_recommend_view_model.dart';
import 'package:bilibili_desktop/src/business/sub_window/video_window_manager.dart';
import 'package:bilibili_desktop/src/config/window_config.dart';
import 'package:bilibili_desktop/src/http/model/recommend_video_model.dart'
    show Item;
import 'package:bilibili_desktop/src/utils/asset_util.dart';
import 'package:bilibili_desktop/src/utils/date_util.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
    _scrollController.addListener(() {
      final loading = ref.read(
        homeRecommendViewModelProvider.select((e) => e.loading),
      );
      debugPrint("scrollController.position.pixels: ${_scrollController.position.pixels}, $loading");
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent &&
          !loading) {
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
    debugPaintSizeEnabled = false;
    final items = ref.watch(
      homeRecommendViewModelProvider.select((e) => e.items),
    );
    return Stack(
      children: [
        Positioned.fill(
          child: Container(
            color: Theme.of(context).colorScheme.surface,
            padding: EdgeInsets.symmetric(
              horizontal: WindowConfig.systemTitleBarPaddingHorizontal,
              vertical: 15
            ),
            child: GridView.builder(
              gridDelegate: ResponsiveGridDelegate(
                // 每行显示 4 个 item
                crossAxisCount: 4,
                // 垂直间距
                mainAxisSpacing: 20,
                // 水平间距
                crossAxisSpacing: 30,
                topAspectRatio: 16 / 9,
                bottomHeight: 83,
              ),
              itemCount: items.length,
              itemBuilder: (context, index) {
                return _buildItem(context, items[index]);
              },
              controller: _scrollController,
            ),
          ),
        ),
        Positioned(
          bottom: 40,
          right: 40,
          child: refreshButton(context, () {
            _viewModel.refresh();
          }),
        ),
      ],
    );
  }

  Widget _buildItem(BuildContext context, Item item) {
    return GestureDetector(
      onTap: () {
        // context.push(RootRoute.video, extra: item);
        VideoWindowManager.openVideo(ref, item.cid, item.bvid, item.owner.mid);
      },
      child: Container(
        decoration: BoxDecoration(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 10,
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: CachedNetworkImage(imageUrl: item.pic, fit: BoxFit.cover,)),
            ),
            SizedBox(
              height: 40,
              child: Text(
                item.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.start,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: 10,
              children: [
                SvgPicture.asset(
                  'icon_author'.svg,
                  semanticsLabel: 'UP作者',
                  width: 20,
                  height: 20,
                  colorFilter: const ColorFilter.mode(Colors.grey, BlendMode.srcIn),
                ),
                CircleAvatar(backgroundColor: Colors.grey, radius: 1),
                Flexible(
                  child: Text(
                    item.owner.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.start,
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ),
                Text(
                  formatVideoTime(item.pubdate),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.start,
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
