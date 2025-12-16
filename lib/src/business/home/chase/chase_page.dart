import 'package:bilibili_desktop/src/business/home/chase/chase_detail/chase_detail_page.dart';
import 'package:bilibili_desktop/src/config/window_config.dart';
import 'package:bilibili_desktop/src/providers/theme/extension/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ChasePage extends ConsumerWidget {
  const ChasePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      color: Theme.of(context).colorScheme.surface,
      padding: EdgeInsets.symmetric(
        horizontal: WindowConfig.systemTitleBarPaddingHorizontal,
        vertical: 15,
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.play_circle_outline,
              size: 64,
              color: Theme.of(context).appColor.secondaryText,
            ),
            SizedBox(height: 16),
            Text(
              '追番',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).appColor.secondaryText,
              ),
            ),
            SizedBox(height: 8),
            Text(
              '功能开发中...',
              style: TextStyle(
                fontSize: 14,
                color: Theme.of(context).appColor.secondaryText,
              ),
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                context.go('/main/home/chase/detail');
              },
              child: const Text('进入追番详情'),
            ),
          ],
        ),
      ),
    );
  }
}
