import 'package:bilibili_desktop/src/business/main/main_view_model.dart';
import 'package:bilibili_desktop/src/config/window_config.dart';
import 'package:bilibili_desktop/src/utils/widget_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TitleSearchPanel extends ConsumerStatefulWidget {

  final double offset;
  const TitleSearchPanel({super.key, required this.offset});

  @override
  ConsumerState<TitleSearchPanel> createState() => TitleSearchPanelState();
}

class TitleSearchPanelState extends ConsumerState<TitleSearchPanel> {
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
      alignment: showPanel ? Alignment.center : Alignment(widget.offset, 0.0),
      duration: Duration(milliseconds: 200),
      onEnd: (){
        if (showPanel) {
          _showSearchPanel();
        }
      },
      child: CompositedTransformTarget(
        link: _layerLink,
        child: AnimatedContainer(
          width: showPanel ? WindowConfig.searchPanelExpandedWidth : WindowConfig.searchPanelWidth,
          duration: Duration(milliseconds: 200),
          height: 40,
          decoration: showPanel
              ? BoxDecoration(
                  border: Border.all(color: Colors.pink, width: 1),
                  borderRadius: BorderRadius.circular(6),
                )
              : BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(6),
                ),
          child: TextField(
            key: _textFieldKey,
            textAlignVertical: TextAlignVertical.center,
            focusNode: _panelFocusNode,
            controller: _controller,
            onTap: (){
              _vm.showSearchPanel();
            },
            decoration: InputDecoration(
              hintText: '搜索你感兴趣的视频',
              hintStyle: TextStyle(fontSize: 14),
              contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10), // 让文字垂直居中
              suffixIcon: Icon(Icons.search, size: 24,),
              border: InputBorder.none,
              isDense: true,
            ),
            style: TextStyle(fontSize: 14),
          ),
        ),
      ),
    );
  }


  OverlayEntry _createOverlayEntry() {
    return OverlayEntry(
      builder: (context) => Positioned(
        width: WindowConfig.searchPanelExpandedWidth,
        height: 400,
        child: CompositedTransformFollower(
          link: _layerLink,
          offset: Offset(0, 50), // 距离目标控件的偏移量
          child: Material(
            elevation: 4.0,
            borderRadius: BorderRadius.circular(8),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(child: Text("搜索面板")),
            ),
          ),
        ),
      ),
    );
  }

  bool isClickInsideTextField(Offset globalPosition) {
    return isClickInsideArea(globalPosition, _textFieldKey);
  }

  void _showSearchPanel() {
    final overlayEntry = _createOverlayEntry();
    _searchPanel = overlayEntry;
    Overlay.of(context).insert(overlayEntry);
  }

  void _hideSearchPanel() {
    _searchPanel?.remove();
    _searchPanel = null;
  }
}
