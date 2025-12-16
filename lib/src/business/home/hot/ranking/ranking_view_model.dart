import 'package:equatable/equatable.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'ranking_view_model.g.dart';

@riverpod
class RankingViewModel extends _$RankingViewModel {
  @override
  RankingState build() {
    return const RankingState();
  }
}

class RankingState extends Equatable {
  const RankingState();

  @override
  List<Object?> get props => [];
}
