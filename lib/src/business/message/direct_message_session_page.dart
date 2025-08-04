import 'package:bilibili_desktop/src/business/message/direct_message_view_model.dart';
import 'package:bilibili_desktop/src/business/message/session_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DirectMessageSessionPage extends ConsumerStatefulWidget {
  const DirectMessageSessionPage({super.key});

  @override
  ConsumerState<DirectMessageSessionPage> createState() => _DirectMessageSessionPageState();
}

class _DirectMessageSessionPageState extends ConsumerState<DirectMessageSessionPage> {

  late DirectMessageViewModel _directMessageViewModel;

  @override
  void initState() {
    super.initState();
    _directMessageViewModel = ref.read(directMessageViewModelProvider.notifier);

  }


  @override
  Widget build(BuildContext context) {
    final currentSession = ref.watch(directMessageViewModelProvider.select((e)=>e.currentSession));
    if (currentSession == null) {
      return const SizedBox();
    }
    final viewModelProvider = sessionViewModelProvider.call(currentSession);
    final userName = ref.watch(viewModelProvider.select((e)=>e.userName));
    return Column(
      children: [
        Row(
          children: [
            IconButton(onPressed: (){
              _directMessageViewModel.exitSessionSection();
            }, icon: Icon(Icons.arrow_back_ios_new_rounded)),
            Text(userName),
          ],
        )
      ],
    );
  }
}
