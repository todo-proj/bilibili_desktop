import 'package:bilibili_desktop/src/business/window/video_window/video/video_view_model.dart';
import 'package:bilibili_desktop/src/http/model/video_reply_model.dart';
import 'package:bilibili_desktop/src/utils/date_util.dart';
import 'package:bilibili_desktop/src/utils/string_util.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:readmore/readmore.dart';

class VideoPageComment extends ConsumerStatefulWidget {
  const VideoPageComment({super.key});

  @override
  ConsumerState<VideoPageComment> createState() => _VideoPageCommentState();
}

class _VideoPageCommentState extends ConsumerState<VideoPageComment> {
  @override
  Widget build(BuildContext context) {
    final replies = ref.watch(videoViewModelProvider.select((v) => v.replies));
    return ListView.separated(
      separatorBuilder: (context, index) {
        return const Divider(height: 10);
      },
      itemCount: replies.length,
      itemBuilder: (context, index) => _buildItem(replies[index]),
    );
  }

  Widget _buildItem(Reply reply) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          backgroundImage: CachedNetworkImageProvider(reply.member.avatar),
          radius: 15,
        ),
        const SizedBox(width: 15),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            spacing: 5,
            children: [
              Text(reply.member.uname),
              Text(formatTimeStamp(reply.ctime), style: TextStyle(fontSize: 11),),
              ReadMoreText(
                reply.content.message,
                trimMode: TrimMode.Line,
                trimLines: 4,
                colorClickableText: Colors.lightBlue,
                trimCollapsedText: '展开',
                trimExpandedText: '收起',
              ),
            ],
          ),
        ),
      ],
    );
  }
}
