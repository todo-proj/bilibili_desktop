import 'package:bilibili_desktop/src/business/message/direct_message_page.dart';
import 'package:bilibili_desktop/src/business/message/direct_message_view_model.dart';
import 'package:bilibili_desktop/src/providers/router/main_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'direct_message_session_page.dart';

class DirectMessageContainerPage extends ConsumerStatefulWidget {
  final VoidCallback? onClose;

  const DirectMessageContainerPage({super.key, this.onClose});

  @override
  ConsumerState<DirectMessageContainerPage> createState() => _DirectMessageContainerPageState();
}

class _DirectMessageContainerPageState extends ConsumerState<DirectMessageContainerPage>
    with TickerProviderStateMixin {

  late AnimationController _controller;
  late Animation<Offset> _animation;

  final controller = PageController(viewportFraction: 1.0); // 全屏滑动
  late DirectMessageViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = ref.read(directMessageViewModelProvider.notifier);
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = Tween<Offset>(
      begin: Offset(-1, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.dismissed) {
        widget.onClose?.call();
      }
    });
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(directMessageViewModelProvider.select((e)=>(e.pageIndex, e.currentSession)), (prev, next){
      if (prev != next) {
        controller.animateToPage(
          next.$1,
          duration: Duration(milliseconds: 300), // ✅ 自定义动画时间
          curve: Curves.easeOut,                 // ✅ 自定义动画曲线
        );
      }
    });
    return TapRegion(
      groupId: MainRoute.directMessage,
      onTapOutside: (event) {
        _controller.reverse();
      },
      child: SlideTransition(
        position: _animation,
        child: PageView.builder(
          controller: controller,
          itemCount: 2,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return _buildContent(index, ValueKey(index));
          },
        ),
      ),
    );
  }

  Widget _buildContent(int pageIndex, Key key) {
    if (pageIndex == 0) {
      return DirectMessagePage(key: key, onClose: widget.onClose,);
    } else {
      return DirectMessageSessionPage(key: key);
    }
  }

}

