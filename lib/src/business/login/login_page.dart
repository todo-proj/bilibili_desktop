import 'package:bilibili_desktop/src/business/common/app_icons.dart';
import 'package:bilibili_desktop/src/business/common/close_toolbar.dart';
import 'package:bilibili_desktop/src/business/common/view_state/view_state.dart';
import 'package:bilibili_desktop/src/business/login/login_view_model.dart';
import 'package:bilibili_desktop/src/utils/widget_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:qr_flutter/qr_flutter.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  late LoginViewModel _loginVM;

  @override
  void initState() {
    super.initState();
    _loginVM = ref.read(loginViewModelProvider.notifier);
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(loginViewModelProvider);
    final codeExpired = ref.watch(
      loginViewModelProvider.select((value) => value.data?.isExpired ?? false),
    );
    final waitingConfirm = ref.watch(
      loginViewModelProvider.select((value) => value.data?.waitingConfirm ?? false),
    );
    return Material(
      color: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        width: 300, height: 350,
        child: Column(
          children: [
            CloseToolbar(
              onClose: () {
                context.pop();
              },
            ),
            switch (state.status) {
              ViewStateStatus.loading => const Center(
                child: CircularProgressIndicator(),
              ),
              ViewStateStatus.error => Center(
                child: Text(state.errorMessage ?? ''),
              ),
              ViewStateStatus.empty => Center(
                child: Text(state.errorMessage ?? ''),
              ),
              ViewStateStatus.success => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('扫描二维码登录', style: TextStyle(fontSize: 18),),
                  20.hSize,
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.withAlpha(112)),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.all(10),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Opacity(
                              opacity: (codeExpired || waitingConfirm) ? 0.1 : 1,
                              child: QrImageView(
                                padding: EdgeInsets.zero,
                                data: state.data?.qrcode ?? '',
                                version: QrVersions.auto,
                                errorCorrectionLevel: QrErrorCorrectLevel.H,
                                size: 150.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (codeExpired)
                        GestureDetector(
                          onTap: () {
                            _loginVM.generateCode();
                          },
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 25,
                                  child: Icon(
                                    Icons.refresh_rounded,
                                    color: Colors.blue,
                                    size: 30,
                                  ),
                                ),
                                10.hSize,
                                Text('二维码已过期', style: TextStyle(fontSize: 14),),
                                Text('请点击刷新', style: TextStyle(fontSize: 14),),
                              ],
                            ),
                          ),
                        ),
                      if (waitingConfirm)
                        Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 25,
                              child: Icon(
                                AppIcons.right,
                                color: Colors.blue,
                                size: 30,
                              ),
                            ),
                            10.hSize,
                            Text('扫码成功', style: TextStyle(fontSize: 14),),
                            Text('请在手机上确认', style: TextStyle(fontSize: 14),),
                          ],
                        ),
                      ),
                    ],
                  ),
                  10.hSize,
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(text: '请使用', style: TextStyle(fontSize: 12)),
                        TextSpan(
                          text: '哔哩哔哩APP',
                          style: TextStyle(color: Colors.pink, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  Text('扫码登录或扫码下载APP', style: TextStyle(fontSize: 12)),
                ],
              ),
            },
          ],
        ),
      ),
    );
  }
}
