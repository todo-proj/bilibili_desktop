
import 'dart:io';

import 'package:bilibili_desktop/src/business/user/user_center.dart';
import 'package:bilibili_desktop/src/http/network_config.dart';
import 'package:bilibili_desktop/src/http/network_manager.dart';
import 'package:bilibili_desktop/src/providers/api_provider.dart';
import 'package:bilibili_desktop/src/utils/wbi_check_util.dart';
import 'package:equatable/equatable.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../utils/logger.dart' show logger, L;

part 'splash_view_model.g.dart';

@riverpod
class SplashViewModel extends _$SplashViewModel {
  @override
  SplashState build() {
    checkLogin();
    return SplashState(checkLogin: false);
  }

  void checkLogin() async {
    try {
      final api = ref.read(apiProvider);
      final account = await api.getAccount();
      final Map<String, String> wbi = {};
      if (account.isSuccess) {
        final info = await api.getUserAccountInformation();
        ref.read(userCenterProviderProvider.notifier).updateState(info.data);
      }
      final wbiResponse = await api.getWbiImg();
      if (wbiResponse.data != null) {
        final wbiImg = wbiResponse.data!.wbiImg;
        WbiCheckUtil.injectKey(wbiImg.imgUrl, wbiImg.subUrl);
      }
      final fingerprint = await api.getFingerprint().handle();
      final cookieJar = NetworkManager.instance.cookieJar;
      cookieJar.saveFromResponse(Uri.http('api.bilibili.com'), [
        Cookie('buvid3', fingerprint['b_3'] ?? ''),
        Cookie('buvid4', fingerprint['b_4'] ?? ''),
      ]);
    }catch(e, s) {
      L.e(e, stackTrace: s);
    }
    state = state.copyWith(checkLogin: true);
  }
}


class SplashState extends Equatable {
  final bool checkLogin;

  const SplashState({required this.checkLogin});

  @override
  List<Object?> get props => [checkLogin];

  copyWith({
    bool? checkLogin,
  }) {
    return SplashState(
      checkLogin: checkLogin ?? this.checkLogin,
    );
  }
}

class CheckLoginEvent {
  final bool isLogin;
  CheckLoginEvent(this.isLogin);
}