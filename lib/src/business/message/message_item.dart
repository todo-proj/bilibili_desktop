import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class MessageItem extends StatelessWidget {
  final Message message;

  const MessageItem({super.key, required this.message});

  bool get isLeft => !message.isSelf;

  EdgeInsets get contentPadding => isLeft
      ? const EdgeInsets.only(left: 15, right: 40 + 15, top: 5, bottom: 5)
      : const EdgeInsets.only(left: 40 + 15, right: 15, top: 5, bottom: 5);

  EdgeInsets get iconPadding =>
      isLeft ? const EdgeInsets.only(right: 5) : const EdgeInsets.only(left: 5);

  Color get panelColor => isLeft ? Colors.grey : const Color(0xff96EC6D);

  TextDirection get textDirection =>
      isLeft ? TextDirection.ltr : TextDirection.rtl;

  @override
  Widget build(BuildContext context) {
    if (message.type == MessageType.time) {
      return _buildTime();
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
              child: _buildContent())),
        ],
      ),
    );
  }

  Widget _buildTime() {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 5),
        child: Text(
          message.texts.first.$1,
          style: TextStyle(fontSize: 12, color: Colors.grey),
        ),
      ),
    );
  }

  Widget _buildContent() {
    if (message.type == MessageType.image) {
      return _buildImage();
    } else {
      return _buildText();
    }
  }

  Widget _buildText() {
    return Container(
      color: panelColor,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: Text.rich(TextSpan(
            children: message.texts.map((e){
              if (e.$1.isNotEmpty) {
                return TextSpan(
                  text: e.$1,
                  style: TextStyle(fontSize: 16),
                );
              }else {
                return WidgetSpan(child: CachedNetworkImage(imageUrl: e.$2, width: 30, height: 30,));
              }
            }).toList()
        )),
      ),
    );
  }

  Widget _buildImage() {
    return CachedNetworkImage(
      imageUrl: message.imageUrl ?? '',
      height: 200,
      width: 200 * message.imageAspectRatio,
      fit: BoxFit.cover,
      errorWidget: (context, url, error) => Icon(Icons.error),
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

enum MessageType { text, time, image }

class Message {
  // text, url
  final List<(String, String)> texts;
  final MessageType type;
  final int messageId;
  final String? face;
  final bool isSelf;
  final String? imageUrl;
  final double imageAspectRatio;

  factory Message.time({
    required String content,
  }) {
    return Message(
      texts: [(content, '')],
      type: MessageType.time,
      messageId: -1,
      isSelf: false,
    );
  }

  bool get isValid => messageId != -1;

  Message({
    required this.texts,
    required this.type,
    required this.messageId,
    this.imageUrl,
    this.imageAspectRatio = 1.0,
    this.face,
    required this.isSelf,
  });
}
