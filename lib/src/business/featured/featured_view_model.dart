import 'package:equatable/equatable.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'featured_view_model.g.dart';

@riverpod
class FeaturedViewModel extends _$FeaturedViewModel {
  @override
  FeaturedState build() {
    return const FeaturedState();
  }
}

class FeaturedState extends Equatable {
  const FeaturedState();

  @override
  List<Object?> get props => [];
}
