import 'package:bilibili_desktop/src/business/common/event_dispatcher_mixin.dart';
import 'package:bilibili_desktop/src/business/common/source_aware_text_editing_controller.dart';
import 'package:bilibili_desktop/src/business/common/widget/hover_widget.dart';
import 'package:bilibili_desktop/src/business/main/search/search_view_model.dart';
import 'package:bilibili_desktop/src/config/window_config.dart';
import 'package:bilibili_desktop/src/providers/router/main_route.dart';
import 'package:bilibili_desktop/src/utils/string_util.dart';
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
  final SourceAwareTextEditingController _controller =
      SourceAwareTextEditingController();
  final LayerLink _layerLink = LayerLink();
  final FocusNode _panelFocusNode = FocusNode();
  final GlobalKey _textFieldKey = GlobalKey();

  late SearchViewModel _searchVm;

  OverlayEntry? _searchPanel;

  @override
  void initState() {
    super.initState();
    _searchVm = ref.read(searchViewModelProvider.notifier);
    _searchVm.getStream<OpenSearchPageEvent>().listen((event) {
      debugPrint('event: $event');
      if (mounted) {
        context.go(MainRoute.search);
      }
    });
    _controller.textNotifier.addListener(() {
      final isUser = !_controller.textNotifier.value.$2;
      final text = _controller.text;
      final value = _controller.value;
      if (text.isNotEmpty) {
        // 判断是否正在组合输入（例如拼音还没选字）
        if (value.composing.isValid && !value.composing.isCollapsed) {
          // 说明还没输完，正在组字，不要处理
          return;
        }
        // 输入框有内容，且是用户输入的，则发送请求
        if (isUser) {
          _searchVm.getSearchSuggest(text);
        }
      } else {
        _searchVm.clearSearchSuggest();
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
    final isSearchState = ref.watch(
      searchViewModelProvider.select((v) => v.isSearchState),
    );
    if (!isSearchState && _controller.text.isNotEmpty) {
      _controller.clear();
    }
    final showPanel = ref.watch(
      searchViewModelProvider.select((v) => v.showSearchPanel),
    );
    if (!showPanel) {
      _hideSearchPanel();
    } else {
      _showSearchPanel();
    }
    return AnimatedAlign(
      alignment: isSearchState
          ? Alignment.center
          : Alignment(widget.offset, 0.0),
      duration: Duration(milliseconds: 200),
      onEnd: () {
        if (isSearchState) {
          _searchVm.showSearchPanel();
        }
      },
      child: CompositedTransformTarget(
        link: _layerLink,
        child: AnimatedContainer(
          width: isSearchState
              ? WindowConfig.searchPanelExpandedWidth
              : WindowConfig.searchPanelWidth,
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
            controller: _controller.controller,
            onTap: () {
              if (!isSearchState) {
                _searchVm.enterSearchState();
              } else {
                _searchVm.showSearchPanel();
              }
            },
            onSubmitted: (content) {
              _searchVm.search(content);
            },
            decoration: InputDecoration(
              hintText: '搜索你感兴趣的视频',
              hintStyle: TextStyle(fontSize: 14, color: Colors.grey[500]),
              contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
              // 让文字垂直居中
              suffixIcon: Icon(Icons.search, size: 24),
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
        child: CompositedTransformFollower(
          link: _layerLink,
          offset: Offset(0, 50), // 距离目标控件的偏移量
          child: Consumer(
            builder: (context, ref, child) {
              final vm = ref.read(searchViewModelProvider.notifier);
              final history = ref.watch(
                searchViewModelProvider.select((e) => e.history),
              );

              final suggests = ref.watch(
                searchViewModelProvider.select((e) => e.searchSuggests),
              );
              final hotWords = ref.watch(
                searchViewModelProvider.select((e) => e.hotWords),
              );
              return Material(
                elevation: 4.0,
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  constraints: BoxConstraints(minHeight: 200),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: suggests.isNotEmpty
                      ? SizedBox(
                          height: 100,
                          child: Padding(
                            padding: EdgeInsetsGeometry.all(10),
                            child: ListView.builder(
                              itemCount: suggests.length,
                              itemBuilder: (context, index) {
                                return HoverEffect(
                                  builder: (value) {
                                    return GestureDetector(
                                      onTap: () {
                                        _controller.text =
                                            suggests[index].value;
                                        _searchVm.search(suggests[index].value);
                                      },
                                      child: ColoredBox(
                                        color: value
                                            ? Colors.grey[300]!
                                            : Colors.white,
                                        child: ListTile(
                                          title: StringUtils.formatTag(
                                            suggests[index].name,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        )
                      : Padding(
                          padding: EdgeInsetsGeometry.all(20),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (history.isNotEmpty)
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "搜索历史",
                                          style: TextStyle(fontSize: 16),
                                        ),
                                        Spacer(),
                                        GestureDetector(
                                          onTap: () {
                                            vm.clearSearchHistory();
                                          },
                                          child: Icon(Icons.delete),
                                        ),
                                      ],
                                    ),
                                    10.hSize,
                                    SizedBox(
                                      width: double.infinity,
                                      child: Wrap(
                                        spacing: 10,
                                        runSpacing: 10,
                                        children: history
                                            .map(
                                              (e) => GestureDetector(
                                                onTap: (){
                                                  _controller.text = e;
                                                  _searchVm.search(e);
                                                },
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(vertical: 3, horizontal: 5),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(5),
                                                    color: Theme.of(
                                                      context,
                                                    ).colorScheme.surfaceContainer,
                                                  ),
                                                  child: Text(e, style: TextStyle(fontSize: 11),),
                                                ),
                                              ),
                                            )
                                            .toList(),
                                      ),
                                    ),
                                    10.hSize,
                                  ],
                                ),
                              Text("热搜", style: TextStyle(fontSize: 16)),
                              10.hSize,
                              GridView.builder(
                                shrinkWrap: true,
                                itemCount: hotWords.length,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      mainAxisExtent: 40,
                                      crossAxisSpacing: 20,
                                    ),
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: (){
                                      _controller.text =
                                          suggests[index].value;
                                      _searchVm.search(suggests[index].value);
                                    },
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "${index + 1} ${hotWords[index].showName}",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                ),
              );
            },
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
      if (_searchPanel != null) {
        return;
      }
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
