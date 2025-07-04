import 'package:bilibili_desktop/src/http/model/user_info_model.dart';
import 'package:bilibili_desktop/src/providers/api_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_center.g.dart';

@riverpod
class UserCenterProvider extends _$UserCenterProvider {
  @override
  UserInfoModel? build() {
    return null;
  }

  void checkLogin() {
    ref.read(apiProvider)
        .then((value) => value.getAccount())
        .then((value) {}, onError: (error) {});
  }
}
