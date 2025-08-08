import 'package:bilibili_desktop/src/business/message/direct_message_view_model.dart';
import 'package:bilibili_desktop/src/business/message/message_item.dart';
import 'package:bilibili_desktop/src/business/message/session_view_model.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DirectMessageSessionPage extends ConsumerStatefulWidget {
  const DirectMessageSessionPage({super.key});

  @override
  ConsumerState<DirectMessageSessionPage> createState() =>
      _DirectMessageSessionPageState();
}

class _DirectMessageSessionPageState
    extends ConsumerState<DirectMessageSessionPage> {
  late DirectMessageViewModel _directMessageViewModel;
  final TextEditingController _textController = TextEditingController();
  final _listenable = IndicatorStateListenable();
  final refreshController = EasyRefreshController(controlFinishLoad: true);

  @override
  void initState() {
    super.initState();
    _directMessageViewModel = ref.read(directMessageViewModelProvider.notifier);
  }

  @override
  void dispose() {
    _textController.dispose();
    refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentSession = ref.watch(
      directMessageViewModelProvider.select((e) => e.currentSession),
    );
    if (currentSession == null) {
      return const SizedBox();
    }
    final viewModelProvider = sessionViewModelProvider.call(currentSession);
    final viewModel = ref.read(viewModelProvider.notifier);
    final userName = ref.watch(viewModelProvider.select((e) => e.userName));
    final messages = ref.watch(viewModelProvider.select((e) => e.messages));
    final hasMore = ref.watch(viewModelProvider.select((e) => e.hasMore));
    return Column(
      children: [
        Row(
          children: [
            IconButton(
              onPressed: () {
                _directMessageViewModel.exitSessionSection();
              },
              icon: Icon(Icons.arrow_back_ios_new_rounded),
            ),
            Text(userName, style: TextStyle(fontSize: 20)),
          ],
        ),
        Expanded(
          child: EasyRefresh(
            clipBehavior: Clip.hardEdge,
            controller: refreshController,
            onLoad: ()async{
              final res = await viewModel.requestSessionMessages(_findValidMessage(messages).messageId);

              WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                if (res) {
                  refreshController.finishLoad(hasMore ? IndicatorResult.success : IndicatorResult.noMore);
                }else {
                  refreshController.finishLoad(IndicatorResult.fail);
                }
              });
              setState(() {

              });
            },
            header: CupertinoHeader(
                infiniteOffset: refreshController.headerState?.result == IndicatorResult.noMore ? null : 60
            ),
            child: CustomScrollView(
              reverse: true,
              shrinkWrap: true,
              slivers: [
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                        (context, index) {
                      return MessageItem(message: messages[index]);
                    },
                    childCount: messages.length,
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          color: Colors.grey,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.all(Radius.circular(6))),
                  margin: EdgeInsets.all(5),
                  child: ValueListenableBuilder(
                    valueListenable: _textController,
                    builder: (context, value, child) {
                      return TextField(
                        controller: _textController,
                        style: TextStyle(fontSize: 16, height: 1.5),
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                            borderSide: BorderSide(
                              color: Colors.transparent,
                              width: 1,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                            borderSide: BorderSide(
                              color: Colors.pinkAccent,
                              width: 2,
                            ),
                          ),
                          isDense: false,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 8,
                          ),
                          suffixIcon: value.text.isNotEmpty
                              ? IconButton(
                                  onPressed: () {
                                    viewModel.sendText(_textController.text);
                                    _textController.clear();
                                  },
                                  icon: Icon(Icons.send_rounded),
                                  padding: EdgeInsets.zero,
                                  constraints: BoxConstraints(),
                                )
                              : SizedBox.shrink(),
                          suffixIconConstraints: BoxConstraints(
                            minWidth: 40,
                            minHeight: 40,
                          ),
                          hintText: "发个消息聊聊呗～",
                          hintStyle: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              IconButton(onPressed: () {
                viewModel.sentImage();
              }, icon: Icon(Icons.image_outlined, size: 24,)),
              IconButton(onPressed: () {}, icon: Icon(Icons.insert_emoticon, size: 24,)),
            ],
          ),
        ),
      ],
    );
  }

  Message _findValidMessage(List<Message> messages) {
    for(int i = messages.length - 1; i >= 0; i--) {
      final message = messages[i];
      if (message.isValid) {
        return message;
      }
    }
    throw Exception('No valid message found');
  }
}
