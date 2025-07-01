import 'package:bilibili_desktop/src/utils/asset_util.dart';
import 'package:bilibili_desktop/src/utils/widget_util.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';


/// 默认页面状态视图组件（加载中、加载失败、网络错误、空布局）
Widget defaultLoadingWidget() {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        40.hSize,
        ColorFiltered(
            colorFilter: const ColorFilter.mode(
              Colors.blue,
              BlendMode.srcIn,
            ),
            child: Lottie.asset("view_loading".lottie,
                width: 256, height: 256)),
        // Text("加载中...",
        //     style: TextStyle(
        //         color: ColorPalettes.instance.thirdText, fontSize: 26)),
        40.hSize,
      ],
    ),
  );
}

Widget defaultEmptyWidget(BuildContext context, {int? errorCode, String? errorMessage, VoidCallback? retryBlock}) {
  return InkWell(
    onTap: retryBlock,
    child: Center(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            40.hSize,
            Container(
                width: 256,
                height: 256,
                alignment: Alignment.center,
                child: Image.asset("ic_view_empty".webp,
                    width: 120,
                    height: 120,
                    color: Colors.blue)),
            Text("暂无数据，点击刷新",
                style: TextStyle(
                    color: Colors.blue, fontSize: 26)),
            40.hSize,
          ],
        ),
      ),
    ),
  );
}

Widget defaultErrorWidget(BuildContext context, {int? errorCode, String? errorMessage, VoidCallback? retryBlock}) {
  return InkWell(
    onTap: retryBlock,
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          40.hSize,
          Container(
              width: 256,
              height: 256,
              alignment: Alignment.center,
              child: Image.asset(
                  (errorCode == 408)
                      ? "ic_view_network_error".webp
                      : "ic_view_fail".webp,
                  width: 180,
                  height: 180,
                  color: Colors.blue)),
          Text("${errorMessage ?? "未知错误"}，点击重试",
              style: TextStyle(
                  color: Colors.black, fontSize: 26)),
          40.hSize,
        ],
      ),
    ),
  );
}