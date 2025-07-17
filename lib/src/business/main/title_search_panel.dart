import 'package:bilibili_desktop/src/business/common/event_dispatcher_mixin.dart';
import 'package:bilibili_desktop/src/business/main/main_view_model.dart';
import 'package:bilibili_desktop/src/business/main/search/search_view_model.dart';
import 'package:bilibili_desktop/src/config/window_config.dart';
import 'package:bilibili_desktop/src/providers/router/main_route.dart';
import 'package:bilibili_desktop/src/utils/widget_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

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
  late SearchViewModel _searchVm;

  OverlayEntry? _searchPanel;

  @override
  void initState() {
    super.initState();
    _vm = ref.read(mainViewModelProvider.notifier);
    _searchVm = ref.read(searchViewModelProvider.notifier);
    _searchVm.getStream<OpenSearchPageEvent>().listen((event) {
      debugPrint('event: $event');
      if (mounted) {
        context.go(MainRoute.search);
      }
    });
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
    final isSearchState = ref.watch(mainViewModelProvider.select((v)=>v.isSearchState));
    final showPanel = ref.watch(mainViewModelProvider.select((v)=>v.showSearchPanel));
    if (!showPanel) {
      _hideSearchPanel();
    }
    return AnimatedAlign(
      alignment: isSearchState ? Alignment.center : Alignment(widget.offset, 0.0),
      duration: Duration(milliseconds: 200),
      onEnd: (){
        if (showPanel) {
          _showSearchPanel();
        }
      },
      child: CompositedTransformTarget(
        link: _layerLink,
        child: AnimatedContainer(
          width: isSearchState ? WindowConfig.searchPanelExpandedWidth : WindowConfig.searchPanelWidth,
          duration: Duration(milliseconds: 200),
          height: 40,
          decoration: isSearchState
              ? BoxDecoration(
                  border: Border.all(color: Colors.pink, width: 1),
                  borderRadius: BorderRadius.circular(6),
                )
              : BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceContainer,
                  borderRadius: BorderRadius.circular(6),
                ),
          child: TextField(
            key: _textFieldKey,
            textAlignVertical: TextAlignVertical.center,
            focusNode: _panelFocusNode,
            controller: _controller,
            onTap: (){
              if (!isSearchState) {
                _vm.enterSearchState();
              }else {
                _vm.showSearchPanel();
                _showSearchPanel();
              }
            },
            onSubmitted: (content) {
              _searchVm.search(content);
            },
            decoration: InputDecoration(
              hintText: '搜索你感兴趣的视频',
              hintStyle: TextStyle(fontSize: 14, color: Colors.grey[500]),
              contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10), // 让文字垂直居中
              suffixIcon: Icon(Icons.search, size: 24,),
              border: InputBorder.none,
              isDense: true,
            ),
            cursorColor: Theme.of(context).colorScheme.onSurface,
            cursorWidth: 1,
            cursorHeight: 12,
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
          child: Consumer(
            builder: (context, ref, child) {
              final vm = ref.read(searchViewModelProvider.notifier);
              final history = ref.watch(searchViewModelProvider.select((e)=>e.history));
              return Material(
                elevation: 4.0,
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(child: Stack(
                    children: [
                      Column(
                        children: [
                          if (history.isNotEmpty)
                            Column(
                            children: [
                              Row(
                                children: [
                                  Text("Search"),
                                  Spacer(),
                                  GestureDetector(
                                      onTap: (){
                                        vm.clearSearchHistory();
                                      },
                                      child: Icon(Icons.delete)),
                                ],
                              ),
                              Wrap(
                                spacing: 10,
                                runSpacing: 10,
                                children: history.map((e) => Text(e)).toList(),
                              ),
                            ],
                          ),
                          Text("hot"),
                        ],
                      )
                    ],
                  )),
                ),
              );
            }
          ),
        ),
      ),
    );
  }

  bool isClickInsideTextField(Offset globalPosition) {
    return isClickInsideArea(globalPosition, _textFieldKey);
  }

  void _showSearchPanel() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final overlayEntry = _createOverlayEntry();
      _searchPanel = overlayEntry;
      Overlay.of(context).insert(overlayEntry);
    });
  }

  void _hideSearchPanel() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _searchPanel?.remove();
      _searchPanel = null;
    });
  }
}
