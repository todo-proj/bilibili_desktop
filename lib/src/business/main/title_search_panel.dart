import 'package:bilibili_desktop/src/business/main/main_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TitleSearchPanel extends ConsumerStatefulWidget {

  final double rightMargin;
  const TitleSearchPanel({super.key, required this.rightMargin});

  @override
  ConsumerState<TitleSearchPanel> createState() => _TitleSearchPanelState();
}

class _TitleSearchPanelState extends ConsumerState<TitleSearchPanel> {
  final TextEditingController _controller = TextEditingController();
  final LayerLink _layerLink = LayerLink();
  final FocusNode _panelFocusNode = FocusNode();
  final GlobalKey _textFieldKey = GlobalKey();

  late MainViewModel _vm;

  OverlayEntry? _searchPanel;

  @override
  void initState() {
    super.initState();
    _vm = ref.read(mainViewModelProvider.notifier);
  }

  @override
  void dispose() {
    _controller.dispose();
    _panelFocusNode.dispose();
    _hideSearchPanel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    debugPaintSizeEnabled = false;
    final showPanel = ref.watch(mainViewModelProvider.select((v)=>v.showSearchPanel));
    if (!showPanel) {
      _hideSearchPanel();
    }
    return AnimatedAlign(
      alignment: showPanel ? Alignment.center : Alignment(0.6, 0.0),
      duration: Duration(milliseconds: 200),
      onEnd: (){
        if (showPanel) {
          _showSearchPanel();
        }
      },
      child: CompositedTransformTarget(
        link: _layerLink,
        child: AnimatedContainer(
          width: showPanel ? 400 : 200,
          duration: Duration(milliseconds: 200),
          decoration: showPanel
              ? BoxDecoration(
                  border: Border.all(color: Colors.pink, width: 1),
                  borderRadius: BorderRadius.circular(10),
                )
              : BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(10),
                ),
          child: TextField(
            key: _textFieldKey,
            focusNode: _panelFocusNode,
            controller: _controller,
            onTap: (){
              _vm.showSearchPanel();
            },
            decoration: InputDecoration(
              hintText: '搜索你感兴趣的视频',
              suffixIcon: Icon(Icons.search),
              border: InputBorder.none,
            ),
          ),
        ),
      ),
    );
  }


  OverlayEntry _createOverlayEntry(Offset offset, Size textFieldSize) {
    return OverlayEntry(
      builder: (context) => Positioned(
        width: 400,
        height: 400,
        child: CompositedTransformFollower(
          link: _layerLink,
          offset: Offset(0, 50), // 距离目标控件的偏移量
          child: Material(
            elevation: 4.0,
            borderRadius: BorderRadius.circular(8),
            child: Listener(
              behavior: HitTestBehavior.opaque,
              onPointerDown: (event) {
                final Offset clickPosition = event.position;
                // 检查点击是否在TextField区域内
                bool isClickInTextField = _isClickInsideArea(
                    clickPosition,
                    offset,
                    textFieldSize
                );
                // 检查点击是否在面板区域内
                bool isClickInPanel = _isClickInsideArea(
                    clickPosition,
                    Offset(offset.dx, offset.dy + textFieldSize.height + 4),
                    Size(textFieldSize.width, 400)
                );
                // 如果点击在TextField或面板外部，则关闭面板
                if (!isClickInTextField && !isClickInPanel) {
                  _vm.hideSearchPanel();
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(child: Text("搜索面板")),
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool _isClickInsideArea(Offset globalPosition, Offset areaOffset, Size areaSize) {
    return globalPosition.dx >= areaOffset.dx &&
        globalPosition.dx <= areaOffset.dx + areaSize.width &&
        globalPosition.dy >= areaOffset.dy &&
        globalPosition.dy <= areaOffset.dy + areaSize.height;
  }

  void _showSearchPanel() {
    // 获取TextField的位置和大小
    final RenderBox renderBox = _textFieldKey.currentContext!.findRenderObject() as RenderBox;
    final Offset offset = renderBox.localToGlobal(Offset.zero);
    final Size size = renderBox.size;
    final overlayEntry = _createOverlayEntry(offset, size);
    _searchPanel = overlayEntry;
    Overlay.of(context).insert(overlayEntry);
  }

  void _hideSearchPanel() {
    _searchPanel?.remove();
    _searchPanel = null;
  }
}
