import 'package:flutter/material.dart';

extension SizedBoxExt on num {

  SizedBox get wSize => SizedBox(width: toDouble(),);
  SizedBox get hSize => SizedBox(height: toDouble(),);

}

bool isClickInsideArea(Offset globalPosition, GlobalKey key) {
  final renderObject = key.currentContext?.findRenderObject();
  if (renderObject == null || renderObject is! RenderBox) {
    return false;
  }

  final Offset offset = renderObject.localToGlobal(Offset.zero);
  final Size size = renderObject.size;
  final Offset clickPosition = globalPosition;

  return offset.dx <= clickPosition.dx &&
      offset.dx + size.width >= clickPosition.dx &&
      offset.dy <= clickPosition.dy &&
      offset.dy + size.height >= clickPosition.dy;
}