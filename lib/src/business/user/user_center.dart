import 'package:bilibili_desktop/src/business/common/event_dispatcher_mixin.dart';
import 'package:bilibili_desktop/src/http/model/user_info_model.dart';
import 'package:bilibili_desktop/src/providers/api_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:bilibili_desktop/src/utils/logger.dart' show logger;

part 'user_center.g.dart';

@Riverpod(keepAlive: true)
class UserCenterProvider extends _$UserCenterProvider{

  @override
  UserInfoModel? build() {
    checkLogin();
    return null;
  }

  void checkLogin() async {
    try {
      final api = await ref.read(apiProvider);
      final account = await api.getAccount();
      if (account.isSuccess) {
        final info = await api.getUserAccountInformation();
        if (info.isSuccess) {
          state = info.data;
          emitToStream<CheckLoginEvent>(CheckLoginEvent(true));
        }
      }
    }catch(e, s) {
      emitToStream<CheckLoginEvent>(CheckLoginEvent(false));
      logger.e(s);
    }
  }

}

class CheckLoginEvent {
  final bool isLogin;
  CheckLoginEvent(this.isLogin);
}
