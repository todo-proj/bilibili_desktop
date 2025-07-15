class StringUtils {

  static String formatNum(int num) {
    if (num < 10000) {
      return num.toString();
    } else {
      return "${(num / 10000).toStringAsFixed(1)}万";
    }
  }
}