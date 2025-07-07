import 'package:bilibili_desktop/src/utils/logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TitleSearchPanel extends ConsumerStatefulWidget {
  const TitleSearchPanel({super.key});

  @override
  ConsumerState<TitleSearchPanel> createState() => _TitleSearchPanelState();
}

class _TitleSearchPanelState extends ConsumerState<TitleSearchPanel> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  final LayerLink _layerLink = LayerLink();

  bool isFocused = false;

  OverlayEntry? _searchPanel;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        isFocused = _focusNode.hasFocus;
        if (isFocused) {
          final overlayEntry = _createOverlayEntry();
          _searchPanel = overlayEntry;
          Overlay.of(context).insert(overlayEntry);
        }else {
          _searchPanel?.remove();
        }
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: AnimatedContainer(
        width: isFocused ? 400 : 300,
        duration: Duration(milliseconds: 200),
        decoration: isFocused
            ? BoxDecoration(
                border: Border.all(color: Colors.pink, width: 1),
                borderRadius: BorderRadius.circular(10),
              )
            : BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(10),
              ),
        child: TextField(
          focusNode: _focusNode,
          controller: _controller,
          decoration: InputDecoration(
            hintText: '搜索你感兴趣的视频',
            suffixIcon: Icon(Icons.search),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }


  OverlayEntry _createOverlayEntry() {
    return OverlayEntry(
      builder: (context) => Positioned(
        width: 400,
        height: 400,
        child: CompositedTransformFollower(
          link: _layerLink,
          offset: Offset(0, 60), // 距离目标控件的偏移量
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
}


class TitleSearchPanelTest extends StatelessWidget {
  const TitleSearchPanelTest({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('TitleSearchPanelTest')),
      body: Column(
        children: [
          TitleSearchPanel(),
        ],
      ),
    );
  }
}
