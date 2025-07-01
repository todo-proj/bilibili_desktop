// ==================== 自定义异常类 ====================
class NetworkException implements Exception {
  final String message;
  final int code;

  NetworkException(this.message, {required this.code});

  @override
  String toString() => 'NetworkException: $message (code: $code)';
}