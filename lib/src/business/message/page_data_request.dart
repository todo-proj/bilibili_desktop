import 'package:bilibili_desktop/src/http/api_response.dart';
import 'package:bilibili_desktop/src/providers/api_provider.dart';
import 'package:bilibili_desktop/src/utils/logger.dart';
import 'package:flutter/material.dart';

typedef PageEmptyChecker<T>= bool Function(T data);

class PageDataRequest {
  final int pageSize;
  int pageNum;
  bool hasMore;

  PageDataRequest({
    this.pageSize = 20,
    this.pageNum = 1,
    this.hasMore = true,
  });

  void nextPage() {
    pageNum++;
  }

  void reset() {
    pageNum = 1;
    hasMore = true;
  }

  void refresh<T>(
    ValueGetter<Future<ApiResponse<T>>> sendRequestBlock,
    ValueChanged<T>? successBlock, {
    PageEmptyChecker<T>? emptyChecker,
    VoidCallback? emptyCallback,
    VoidCallback? failCallback,
  }) {
    sendRequestBlock()
        .handle()
        .then((response) {
          pageNum++;
          final isEmpty = emptyChecker?.call(response) ?? false;
          if (isEmpty) {
            hasMore = false;
            emptyCallback?.call();
          } else {
            hasMore = true;
            successBlock?.call(response);
          }
        })
        .catchError((e, s) {
          L.e(e, stackTrace: s);
          failCallback?.call();
        });
  }

  void requestMore<T>(Future<ApiResponse<T>> sendRequestBlock, ValueChanged<T>? successBlock, {
    PageEmptyChecker<T>? emptyChecker,
    VoidCallback? emptyCallback,
    VoidCallback? failCallback,
  }) {
    if (!hasMore) {
      emptyCallback?.call();
      L.e('没有更多数据了');
      return;
    }
    sendRequestBlock.handle().then((response) {
      pageNum++;
      final isEmpty = emptyChecker?.call(response) ?? false;
      if (isEmpty) {
        hasMore = false;
        emptyCallback?.call();
      } else {
        successBlock?.call(response);
      }
    }).catchError((e, s) {
      L.e(e, stackTrace: s);
      failCallback?.call();
    });
  }
}
