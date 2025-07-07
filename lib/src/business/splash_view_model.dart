
import 'package:bilibili_desktop/src/business/user/user_center.dart';
import 'package:bilibili_desktop/src/providers/api_provider.dart';
import 'package:equatable/equatable.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../utils/logger.dart' show logger;

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
      final api = await ref.read(apiProvider);
      final account = await api.getAccount();
      if (account.isSuccess) {
        final info = await api.getUserAccountInformation();
        if (info.isSuccess) {
          ref.read(userCenterProviderProvider.notifier).updateState(info.data);
        }
      }
    }catch(e, s) {
      logger.e(s);
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