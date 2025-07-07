import 'package:bilibili_desktop/src/business/user/user_center.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
//
// bool checkLogin(Ref ref) {
//   final userState = ref.read(userCenterProviderProvider);
//   if (userState == null) {
//     return false;
//   }
//   return userState.isLogin;
// }

bool checkLogin(WidgetRef ref) {
  final userState = ref.read(userCenterProviderProvider);
  if (userState == null) {
    return false;
  }
  return userState.isLogin;
}