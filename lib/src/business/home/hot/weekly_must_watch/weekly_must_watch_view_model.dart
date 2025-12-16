import 'package:equatable/equatable.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'weekly_must_watch_view_model.g.dart';

@riverpod
class WeeklyMustWatchViewModel extends _$WeeklyMustWatchViewModel {
  @override
  WeeklyMustWatchState build() {
    return const WeeklyMustWatchState();
  }
}

class WeeklyMustWatchState extends Equatable {
  const WeeklyMustWatchState();

  @override
  List<Object?> get props => [];
}
