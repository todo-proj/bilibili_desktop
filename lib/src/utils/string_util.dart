import 'package:flutter/material.dart';

class StringUtils {

  static String formatNum(int num) {
    if (num < 10000) {
      return num.toString();
    } else {
      return "${(num / 10000).toStringAsFixed(1)}万";
    }
  }

  static String formatDuration(int second) {
    String twoDigits(int n) {
      if (n >= 10) return "$n";
      return "0$n";
    }
    int hours = second ~/ 3600;
    int minutes = second ~/ 60;
    int seconds = second % 60;
    if (hours == 0) {
      return "${twoDigits(minutes)}:${twoDigits(seconds)}";
    }
    return "${twoDigits(hours)}:${twoDigits(minutes)}:${twoDigits(seconds)}";
  }

  static Widget formatTag(String input) {
    // 提取标签内的文字
    RegExp tagRegExp = RegExp(r'<[^>]+>([^<]+)</[^>]+>');
    Match? tagMatch = tagRegExp.firstMatch(input);
    String tagText = tagMatch?.group(1) ?? '';

    // 提取标签后的文字
    String remainingText = input.replaceAll(tagRegExp, '').trim();

    return Text.rich(
      TextSpan(
        children: [
          TextSpan(text: tagText, style: TextStyle(color: Colors.red)),
          TextSpan(text: remainingText),
        ]
      )
    );
  }
}