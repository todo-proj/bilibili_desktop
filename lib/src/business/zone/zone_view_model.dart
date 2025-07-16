import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'zone_view_model.g.dart';

@riverpod
class ZoneViewModel extends _$ZoneViewModel {
  @override
  ZoneState build() {
    return ZoneState();
  }
}



class ZoneState {}