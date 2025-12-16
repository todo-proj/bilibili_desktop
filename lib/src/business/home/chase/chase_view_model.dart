import 'package:equatable/equatable.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'chase_view_model.g.dart';

@riverpod
class ChaseViewModel extends _$ChaseViewModel {
  @override
  ChaseState build() {
    return const ChaseState();
  }
}

class ChaseState extends Equatable {
  const ChaseState();

  @override
  List<Object?> get props => [];
}
