import 'dart:async';

import 'package:bilibili_desktop/src/business/common/view_state/view_state.dart';
import 'package:bilibili_desktop/src/providers/api_provider.dart';
import 'package:equatable/equatable.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'login_view_model.g.dart';

@riverpod
class LoginViewModel extends _$LoginViewModel {

  Timer? _qrCodeExpiredTimer;
  Timer? _qrCodeCheckTimer;

  @override
  ViewState<LoginState> build() {
    ref.onDispose(() {
      _qrCodeExpiredTimer?.cancel();
      _qrCodeCheckTimer?.cancel();
    });
    generateCode();
    return const ViewState(status: ViewStateStatus.loading);
  }

  void generateCode() async {
    final api = await ref.read(loginProvider);
    try {
      final data = await api.generateCode().handle();
      _createQrCodeExpiredTimer();
      _createQrCodeCheckTimer();
      state = state.successState(LoginState(qrcode: data.url, qrcodeKey: data.qrcodeKey, isExpired: false, waitingConfirm: false));
    }catch (e) {
      state = state.errorState(errorMessage: e.toString());
    }
  }

  void _createQrCodeExpiredTimer() {
    final startTime = DateTime.now().millisecondsSinceEpoch;
    _qrCodeExpiredTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final current = DateTime.now().millisecondsSinceEpoch;
      if (current - startTime > 180_1000) {
        timer.cancel();
        _qrCodeCheckTimer?.cancel();
        state = state.successState(state.data?.copyWith(isExpired: true));
      }
    });
  }

  void _createQrCodeCheckTimer() {
    _qrCodeCheckTimer = Timer.periodic(const Duration(seconds: 3), (timer) async {
      final api = await ref.read(loginProvider);
      try {
        final data = await api.checkCode(state.data?.qrcodeKey ?? '').handle();
        final code = data['code'];
        if (code == 0) {



          timer.cancel();
          //success
        }else if (code == 86038) {
          //expired
          state = state.successState(state.data?.copyWith(isExpired: true));
          timer.cancel();
        }else if (code == 86090){
          //已扫码未确认
          state = state.successState(state.data?.copyWith(waitingConfirm: true));
        }
      }catch (e) {
        timer.cancel();
        state = state.errorState(errorMessage: e.toString());
      }
    });
  }

}

class LoginState extends Equatable {

  final String qrcode;
  final String qrcodeKey;
  final bool isExpired;
  final bool waitingConfirm;

  const LoginState({
    required this.qrcode,
    required this.qrcodeKey,
    this.isExpired = false,
    this.waitingConfirm = false,
  });

  copyWith({
    String? qrcode,
    String? qrcodeKey,
    bool? isExpired,
    bool? waitingConfirm,
  }) {
    return LoginState(
      qrcode: qrcode ?? this.qrcode,
      qrcodeKey: qrcodeKey ?? this.qrcodeKey,
      isExpired: isExpired ?? this.isExpired,
      waitingConfirm: waitingConfirm ?? this.waitingConfirm,
    );
  }

  @override
  List<Object?> get props => [qrcode, qrcodeKey, isExpired, waitingConfirm];


}