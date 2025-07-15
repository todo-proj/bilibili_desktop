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
}