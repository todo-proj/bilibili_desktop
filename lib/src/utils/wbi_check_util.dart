import 'dart:convert';
import 'dart:collection';
import 'package:crypto/crypto.dart';

class WbiCheckUtil {
  static final md5Hash = md5;

  static String _imgKey = "";
  static String _subKey = "";

  static void injectKey(String imgKey, String subKey) {
    _imgKey = imgKey.split('/').last.split('.').first;
    _subKey = subKey.split('/').last.split('.').first;
  }

  static Map<String, dynamic> generateWbiParams(Map<String, dynamic> params) {
    final mixinKey = getMixinKey(_imgKey, _subKey);

    final map = SplayTreeMap<String, dynamic>(); // 自动按 key 排序
    map.addAll(params);
    int date = (DateTime.now().millisecondsSinceEpoch ~/ 1000);
    map['wts'] = date;

    final param = map.entries.map((e) =>
    '${e.key}=${Uri.encodeComponent(e.value.toString())}').join('&');
    final s = param + mixinKey;
    final wbiSign = md5Run(s);
    Map<String, dynamic> result = {};
    result.addAll(params);
    result.addAll({
      "wts" : date,
      "w_rid" : wbiSign
    });
    return result;
  }

  static final List<int> mixinKeyEncTab = [
    46, 47, 18, 2, 53, 8, 23, 32, 15, 50, 10, 31, 58, 3, 45, 35, 27, 43, 5, 49,
    33, 9, 42, 19, 29, 28, 14, 39, 12, 38, 41, 13, 37, 48, 7, 16, 24, 55, 40,
    61, 26, 17, 0, 1, 60, 51, 30, 4, 22, 25, 54, 21, 56, 59, 6, 63, 57, 62, 11,
    36, 20, 34, 44, 52
  ];

  static String getMixinKey(String imgKey, String subKey) {
    final s = imgKey + subKey;
    final buffer = StringBuffer();
    for (var i = 0; i < 32; i++) {
      buffer.write(s[mixinKeyEncTab[i]]);
    }
    return buffer.toString();
  }

  static String md5Run(String input) {
    final bytes = utf8.encode(input);
    final digest = md5convert(bytes);
    return digest;
  }

  static String md5convert(List<int> bytes) {
    final digest = md5Hash.convert(bytes);
    return digest.toString();
  }

}



