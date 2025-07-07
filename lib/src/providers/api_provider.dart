import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:bilibili_desktop/src/http/api_response.dart';
import 'package:bilibili_desktop/src/http/api_service.dart';
import 'package:bilibili_desktop/src/http/network_manager.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bilibili_desktop/src/utils/logger.dart' show logger;
import 'package:path_provider/path_provider.dart';

Future<CookieJar> prepareJar() async {
  final Directory appDocDir = await getApplicationDocumentsDirectory();
  final String appDocPath = appDocDir.path;
  final cookiePath = path.join(appDocPath, ".cookies");
  if (!Directory(cookiePath).existsSync()) {
    Directory(cookiePath).createSync(recursive: true);
  }
  final jar = PersistCookieJar(
    ignoreExpires: true,
    storage: FileStorage(cookiePath),
  );
  return jar;
}

final apiProvider = Provider((ref) async {
  final dio = (await NetworkManager.instance).dio;
  return ApiService(dio);
});

final loginProvider = Provider((ref) async {
  final dio = (await NetworkManager.instance).dio;
  return ApiService(dio,
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
