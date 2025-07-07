import 'package:bilibili_desktop/src/http/model/basic_user_info_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_center.g.dart';

@Riverpod(keepAlive: true)
class UserCenterProvider extends _$UserCenterProvider{

  @override
  BasicUserInfoModel? build() {
    return null;
  }

  void updateState(BasicUserInfoModel? state) {
    this.state = state;
  }

}


