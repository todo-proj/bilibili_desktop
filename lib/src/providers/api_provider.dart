import 'package:bilibili_desktop/src/http/api_response.dart';
import 'package:bilibili_desktop/src/http/api_service.dart';
import 'package:bilibili_desktop/src/http/network_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bilibili_desktop/src/utils/logger.dart' show logger;

final apiProvider = Provider((ref) async {
  return ApiService(NetworkManager.instance.dio);
});

final loginProvider = Provider((ref) async {
  return ApiService(
    NetworkManager.instance.dio,
    baseUrl: 'https://passport.bilibili.com/',
  );
});

extension ApiProvider<T> on Future<ApiResponse<T>> {
  Future<T> handle() async {
    try {
      final response = await this;
      if (response.isSuccess) {
        return response.data!;
      } else {
        logger.e("api error: ${response.message}");
        throw Exception(response.message);
      }
    } catch (e, s) {
      logger.e("catch error: $e, $s");
      rethrow;
    }
  }
}
