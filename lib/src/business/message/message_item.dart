import 'package:bilibili_desktop/src/providers/theme/extension/app_color.dart';
import 'package:bilibili_desktop/src/utils/string_util.dart';
import 'package:bilibili_desktop/src/utils/widget_util.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class MessageItem extends StatelessWidget {
  final Message message;
  final void Function(MessageLink)? onLinkTap;

  const MessageItem({super.key, required this.message, this.onLinkTap});

  bool get isLeft => !message.isSelf;

  EdgeInsets get contentPadding => isLeft
      ? const EdgeInsets.only(left: 15, right: 40 + 15, top: 5, bottom: 5)
      : const EdgeInsets.only(left: 40 + 15, right: 15, top: 5, bottom: 5);

  EdgeInsets get iconPadding =>
      isLeft ? const EdgeInsets.only(right: 5) : const EdgeInsets.only(left: 5);

  Color panelColor(BuildContext context) => isLeft 
      ? Theme.of(context).appColor.messageBubbleLeft 
      : const Color(0xff96EC6D);

  TextDirection get textDirection =>
      isLeft ? TextDirection.ltr : TextDirection.rtl;

  @override
  Widget build(BuildContext context) {
    if (message.type == MessageType.time) {
      return _buildTime(context);
    }
    return Padding(
      padding: contentPadding,
      child: Row(
        textDirection: textDirection,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildIcon(),
          Flexible(child: ClipRRect(
            borderRadius: BorderRadiusGeometry.only(
              topLeft: isLeft ? Radius.circular(0) : Radius.circular(20),
              topRight: isLeft ? Radius.circular(20) : Radius.circular(0),
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
              child: _buildContent(context))),
        ],
      ),
    );
  }

  Widget _buildTime(BuildContext context) {
    final data = message.data as MessageText;
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 5),
        child: Text(
          data.texts.first.$1,
          style: TextStyle(
            fontSize: 12,
            color: Theme.of(context).appColor.messageTimeText,
          ),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    switch(message.type) {
      case MessageType.text:
        return _buildText(context);
      case MessageType.image:
        return _buildImage();
      case MessageType.link:
        return _buildLink(context);
      case MessageType.time:
        return _buildTime(context);
    }
  }

  Widget _buildText(BuildContext context) {
    final data = message.data as MessageText;
    return Container(
      color: panelColor(context),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: Text.rich(TextSpan(
            children: data.texts.map((e){
              if (e.$1.isNotEmpty) {
                return TextSpan(
                  text: e.$1,
                  style: TextStyle(fontSize: 16),
                );
              }else {
                return WidgetSpan(child: CachedNetworkImage(imageUrl: e.$2, width: 20, height: 20,));
              }
            }).toList()
        )),
      ),
    );
  }

  Widget _buildImage() {
    final data = message.data as MessageImage;
    return CachedNetworkImage(
      imageUrl: data.imageUrl,
      height: 200,
      width: 200 * data.imageAspectRatio,
      fit: BoxFit.cover,
      errorWidget: (context, url, error) => Icon(Icons.error),
    );
  }

  Widget _buildLink(BuildContext context) {
    final data = message.data as MessageLink;
    return GestureDetector(
      onTap: (){
        onLinkTap?.call(data);
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: panelColor(context),
        ),
        padding: EdgeInsets.all(10),
        height: 100,
        child: Row(
          children: [
            Expanded(
              flex: 2,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                    child: CachedNetworkImage(imageUrl: data.thumb, fit: BoxFit.fill, ))),
            8.wSize,
            Expanded(flex: 3, child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(data.title, maxLines: 2, overflow: TextOverflow.ellipsis,),
                Text(StringUtils.formatDuration(data.duration)),
                Text('${data.reply}条回复'),
              ],
            ))
          ],
        ),
      ),
    );
  }

  Widget _buildIcon() {
    return Container(
      height: 40,
      width: 40,
      margin: iconPadding,
      child: ClipOval(child: CachedNetworkImage(imageUrl: message.face ?? '')),
    );
  }
}

enum MessageType { text, time, image, link }

class Message {
  final MessageType type;
  final int messageId;
  final String? face;
  final bool isSelf;
  final IMessageData data;

  factory Message.time({
    required String content,
  }) {
    return Message(
      data: MessageText(texts: [(content, '')]),
      type: MessageType.time,
      messageId: -1,
      isSelf: false,
    );
  }

  bool get isValid => messageId != -1;

  Message({
    required this.type,
    required this.messageId,
    this.face,
    required this.isSelf,
    required this.data,
  });

  toJson() {
    return {
      'type': type.index,
      'messageId': messageId,
      'face': face,
      'isSelf': isSelf,
      'title': data
    };
  }
}

abstract class IMessageData {}

class MessageText extends IMessageData{
  // text, url
  final List<(String, String)> texts;

  MessageText({
    required this.texts,
  });
}
class MessageImage extends IMessageData{
  final String imageUrl;
  final double imageAspectRatio;

  MessageImage({
    required this.imageUrl,
    this.imageAspectRatio = 1.0,
  });
}
class MessageLink extends IMessageData{
  final String title;
  final int id;
  final String bvid;
  final String thumb;
  final int duration;
  final int reply;

  MessageLink({
    required this.title,
    required this.id,
    required this.thumb,
    required this.duration,
    required this.reply,
    required this.bvid,
  });
}