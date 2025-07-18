import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
import 'package:bilibili_desktop/src/http/api_response.dart';
import 'package:bilibili_desktop/src/http/api_service.dart';
import 'package:bilibili_desktop/src/http/network_manager.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bilibili_desktop/src/utils/logger.dart' show L;
import 'package:path_provider/path_provider.dart';

Future<CookieJar> prepareJar() async {
  final Directory appDocDir = await getApplicationDocumentsDirectory();
  final String appDocPath = appDocDir.path;
  final cookiePath = path.join(appDocPath, ".cookies");
  if (!Directory(cookiePath).existsSync()) {
    Directory(cookiePath).createSync(recursive: true);
  }
  debugPrint("cookie path: $cookiePath");
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

final searchApiProvider = Provider((ref) async {
  final dio = (await NetworkManager.instance).dio;
  return ApiService(dio,
    baseUrl: 'https://s.search.bilibili.com/main/',
  );
});

extension ApiProvider<T> on Future<ApiResponse<T>> {
  Future<T> handle() async {
    try {
      final response = await this;
      if (response.isSuccess) {
        if (response.data != null) {
          return response.data!;
        }else if (response.result != null) {
          return response.result!;
        }
        throw Exception('参数都为null');
      } else {
        L.e("api error: ${response.message}");
        throw Exception(response.message);
      }
    } catch (e, s) {
      L.e("catch error: $e, $s");
      rethrow;
    }
  }
}



