import 'package:equatable/equatable.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'chase_detail_view_model.g.dart';

@riverpod
class ChaseDetailViewModel extends _$ChaseDetailViewModel {
  @override
  ChaseDetailState build() {
    return const ChaseDetailState();
  }
}

class ChaseDetailState extends Equatable {
  const ChaseDetailState();

  @override
  List<Object?> get props => [];
}
