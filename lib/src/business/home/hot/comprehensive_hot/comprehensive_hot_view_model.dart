import 'package:equatable/equatable.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'comprehensive_hot_view_model.g.dart';

@riverpod
class ComprehensiveHotViewModel extends _$ComprehensiveHotViewModel {
  @override
  ComprehensiveHotState build() {
    return const ComprehensiveHotState();
  }
}

class ComprehensiveHotState extends Equatable {
  const ComprehensiveHotState();

  @override
  List<Object?> get props => [];
}
