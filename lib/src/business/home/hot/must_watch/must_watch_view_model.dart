import 'package:equatable/equatable.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'must_watch_view_model.g.dart';

@riverpod
class MustWatchViewModel extends _$MustWatchViewModel {
  @override
  MustWatchState build() {
    return const MustWatchState();
  }
}

class MustWatchState extends Equatable {
  const MustWatchState();

  @override
  List<Object?> get props => [];
}
