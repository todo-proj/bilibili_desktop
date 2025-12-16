import 'package:equatable/equatable.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'following_view_model.g.dart';

@riverpod
class FollowingViewModel extends _$FollowingViewModel {
  @override
  FollowingState build() {
    return const FollowingState();
  }
}

class FollowingState extends Equatable {
  const FollowingState();

  @override
  List<Object?> get props => [];
}
