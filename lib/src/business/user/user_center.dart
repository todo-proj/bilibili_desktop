import 'package:bilibili_desktop/src/business/common/widget/common_tab_bar.dart';
import 'package:bilibili_desktop/src/http/model/basic_user_info_model.dart';
import 'package:bilibili_desktop/src/providers/api_provider.dart';
import 'package:bilibili_desktop/src/utils/logger.dart';
import 'package:equatable/equatable.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_center.g.dart';

@Riverpod(keepAlive: true)
class UserCenterProvider extends _$UserCenterProvider{

  @override
  UserCenterState build() {
    return UserCenterState(userInfo: null, items: [
      TabBarItem('历史记录', 'history'),
      TabBarItem('离线缓存', 'cache'),
      TabBarItem('我的收藏', 'collect'),
      TabBarItem('稍后再看', 'watchLater'),
    ]);
  }

  void updateState(BasicUserInfoModel? model) {
    state = state.copyWith(
      userInfo: model,
      mid: model?.mid ?? '',
      name: model?.uname ?? '',
      face: model?.face ?? '',
      coin: model?.money ?? '—',
      bCoinBalance: model?.wallet.bcoinBalance.toString() ?? '—',
    );
    getUserCard();
  }


  bool checkLogin() {
    return state.userInfo?.isLogin ?? false;
  }

  void getUserCard() async{
    if (!checkLogin()) return;
    final api = await ref.read(apiProvider);
    try {
      final mid = state.userInfo!.mid.toString();
      final userCard = await api.userCard(mid).handle();
      state = state.copyWith(
        followerNum: userCard.follower.toString(),
        followingNum: userCard.following.toString(),
        dynamicNum: userCard.archiveCount.toString()
      );
    }catch(e, s) {
      L.e('getRelationStat error: ', error: e, stackTrace: s);
    }
  }

}


class UserCenterState extends Equatable{
  final String mid;
  final String name;
  final String face;
  final String coin;
  // 拥有B币数
  final String bCoinBalance;
  final String followerNum;
  final String followingNum;
  final String dynamicNum;

  final List<TabBarItem> items;
  final BasicUserInfoModel? userInfo;
  const UserCenterState({
    this.mid = '',
    this.name = '',
    this.face = '',
    this.coin = '—',
    this.bCoinBalance = '—',
    this.followerNum = '',
    this.followingNum = '',
    this.dynamicNum = '',
    this.items = const [],
    this.userInfo,
  });


  UserCenterState copyWith({
    String? mid,
    String? name,
    String? face,
    String? coin,
    String? bCoinBalance,
    String? followerNum,
    String? followingNum,
    String? dynamicNum,
    BasicUserInfoModel? userInfo,
    List<TabBarItem>? items,
  }) {
    return UserCenterState(
      userInfo: userInfo ?? this.userInfo,
      mid: mid ?? this.mid,
      name: name ?? this.name,
      face: face ?? this.face,
      coin: coin ?? this.coin,
      bCoinBalance: bCoinBalance ?? this.bCoinBalance,
      followerNum: followerNum ?? this.followerNum,
      followingNum: followingNum ?? this.followingNum,
      dynamicNum: dynamicNum ?? this.dynamicNum,
      items: items ?? this.items,
    );
  }

  @override
  List<Object?> get props => [userInfo, name, face, coin, followerNum, followingNum, dynamicNum, mid, bCoinBalance, items];
}

