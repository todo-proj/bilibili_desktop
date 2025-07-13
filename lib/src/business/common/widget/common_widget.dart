import 'package:bilibili_desktop/src/business/login/login_state_tool.dart';
import 'package:bilibili_desktop/src/providers/router/root_route.dart';
import 'package:bilibili_desktop/src/providers/theme/extension/app_color.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

Widget refreshButton(BuildContext context, VoidCallback onPressed) {
  return SizedBox.square(
    dimension: 36,
    child: IconButton(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.resolveWith<Color?>((
          Set<WidgetState> states,
        ) {
          if (states.contains(WidgetState.hovered)) {
            // return bgColor.withValues(alpha: 0.5); // hover 时的颜色
            return Theme.of(
              context,
            ).extension<AppColor>()!.refreshButtonHoverColor; // hover 时的颜色
          }
          return Theme.of(context).extension<AppColor>()!.refreshButtonColor;
        }),
        foregroundColor: WidgetStateProperty.all(
          Theme.of(context).colorScheme.onSurface,
        ),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8), // 圆角
          ),
        ),
        padding: WidgetStateProperty.all(EdgeInsets.zero),
      ),
      onPressed: onPressed,
      icon: Icon(Icons.refresh, size: 24),
    ),
  );
}

Widget followButton(BuildContext context, String title, VoidCallback onPressed) {
  return Consumer(
    builder: (context, ref, child) {
      return IconButton(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.resolveWith<Color?>((
            Set<WidgetState> states,
          ) {
            if (states.contains(WidgetState.hovered)) {
              return Colors.pink.withValues(alpha: 0.5);
            } else {
              return Colors.pink;
            }
          }),
        ),
        onPressed: () {
          if (checkLogin(ref)) {
            onPressed();
          } else {
            context.push(RootRoute.login);
          }
        },
        icon: Row(
          children: [
            Icon(Icons.add, size: 24),
            Text(title, style: TextStyle(fontSize: 12)),
          ],
        ),
      );
    },
  );
}

Widget userAvatar({required String url, required double size}) {
  final defaultAvatar = Image.asset(
    'assets/images/icon_default_avatar.png',
    width: size,
    color: Colors.grey,
  );
  return ClipOval(
    child: CachedNetworkImage(
      imageUrl: url,
      width: size,
      height: size,
      placeholder: (context, url) => defaultAvatar,
      errorWidget: (context, url, error) => defaultAvatar,
    ),
  );
}
