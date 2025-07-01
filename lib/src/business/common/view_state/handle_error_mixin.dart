import 'package:bilibili_desktop/src/http/error_code.dart';
import 'package:bilibili_desktop/src/http/network_exception.dart';

mixin HandleErrorMixin {
  (int errorCode, String errorMessage) handleError(Exception error, ) {
    if (error is NetworkException) {
      return (error.code, error.message);
    } else {
      return (ErrorCode.unknown, error.toString());
    }
  }
}