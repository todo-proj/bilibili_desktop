import 'package:bilibili_desktop/src/http/error_code.dart';
import 'package:bilibili_desktop/src/providers/api_provider.dart';
import 'package:curl_logger_dio_interceptor/curl_logger_dio_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'package:bilibili_desktop/src/utils/logger.dart' show logger, L;
import 'interceptors/retry_interceptor.dart';
import 'network_config.dart';
import 'network_exception.dart';

class NetworkManager {
  static NetworkManager? _instance;
  late Dio _dio;

  static Future<NetworkManager> get instance async {
    _instance ??= await NetworkManager._internal();
    return _instance!;
  }

  static Future<NetworkManager> _internal() async {
    final dio = Dio();
    final manager = NetworkManager._create(dio);
    await manager._setupDioAsync(); // 异步配置
    return manager;
  }

  NetworkManager._create(this._dio);

  Dio get dio => _dio;

  Future<void> _setupDioAsync() async {
    // 基础配置
    _dio.options = BaseOptions(
      baseUrl: NetworkConfig.baseUrl,
      connectTimeout: Duration(milliseconds: NetworkConfig.connectTimeout),
      receiveTimeout: Duration(milliseconds: NetworkConfig.receiveTimeout),
      sendTimeout: Duration(milliseconds: NetworkConfig.sendTimeout),
      headers: {
        "Referer": "https://www.bilibili.com/",
        "User-Agent":
        "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36",
        "Origin": "https://www.bilibili.com/",
        "Accept": "*/*",
        "Accept-Language": "zh-CN,zh;q=0.9,en-US;q=0.8,en;q=0.7"
      },
    );

    final cookieManager = CookieManager(await prepareJar());
    // 添加拦截器
    _setupInterceptors([cookieManager]);
  }

  void _setupInterceptors(List<Interceptor> interceptors) {
    for (var interceptor in interceptors) {
      _dio.interceptors.add(interceptor);
    }
    // 日志拦截器（仅在 Debug 模式下）
    if (kDebugMode) {
      _dio.interceptors.add(CurlLoggerDioInterceptor());
      _dio.interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          responseHeader: false,
          error: true,
          compact: true,
          maxWidth: 90,
        ),
      );
    }
    // 请求拦截器
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          // 添加时间戳
          options.headers['timestamp'] = DateTime.now().millisecondsSinceEpoch;
          handler.next(options);
        },
        onResponse: (response, handler) {
          handler.next(response);
        },
        onError: (error, handler) {
          L.e("dio error", error: error);
          // 统一错误处理
          final networkException = _handleError(error);
          handler.reject(
            DioException(
              requestOptions: error.requestOptions,
              error: networkException,
            ),
          );
        },
      ),
    );

    // 重试拦截器
    _dio.interceptors.add(RetryInterceptor());
  }

  // 错误处理
  NetworkException _handleError(DioException error) {
    switch (error.type) {
      case DioExceptionType.badResponse:
        return _handleHttpError(error.response?.statusCode);
      case DioExceptionType.cancel:
        return NetworkException('请求已取消', code: ErrorCode.requestCancelled);
      default:
        return NetworkException('网络跑丢了，请稍后重试', code: ErrorCode.networkError);
    }
  }

  NetworkException _handleHttpError(int? statusCode) {
    switch (statusCode) {
      case 400:
        return NetworkException('请求参数错误', code: 400);
      case 401:
        return NetworkException('未授权，请重新登录', code: 401);
      case 403:
        return NetworkException('禁止访问', code: 403);
      case 404:
        return NetworkException('请求资源不存在', code: 404);
      case 405:
        return NetworkException('请求方法不被允许', code: 405);
      case 500:
        return NetworkException('服务器内部错误', code: 500);
      case 502:
        return NetworkException('网关错误', code: 502);
      case 503:
        return NetworkException('服务不可用', code: 503);
      case 504:
        return NetworkException('网关超时', code: 504);
      default:
        return NetworkException('HTTP错误: $statusCode', code: ErrorCode.networkError);
    }
  }

  // 更新 BaseUrl
  void updateBaseUrl(String baseUrl) {
    _dio.options.baseUrl = baseUrl;
  }
}
