import 'package:flutter/material.dart';

String formatVideoTime(int timeStamp) {

  DateTime time = DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000);
  final now = DateTime.now();
  final hour = now.hour + 1;
  final difference = now.difference(time);
  // 24内,显示小时;24之外显示昨天;今年内,显示月日;小于今年,年月日
  if (difference.inHours < hour) {
    return "${difference.inHours}小时前";
  }else if (difference.inHours < 24 + hour) {
    return "昨天";
  } else if (time.year == now.year) {
    return "${time.month}-${time.day}";
  } else {
    return "${time.year}-${time.month}-${time.day}";
  }
}