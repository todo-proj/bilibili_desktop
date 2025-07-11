import 'package:bilibili_desktop/src/providers/theme/extension/app_color.dart';
import 'package:flutter/material.dart';


Widget refreshButton(BuildContext context, VoidCallback onPressed) {
  return SizedBox.square(
    dimension: 36,
    child: IconButton(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.resolveWith<Color?>(
              (Set<WidgetState> states) {
            if (states.contains(WidgetState.hovered)) {
              // return bgColor.withValues(alpha: 0.5); // hover 时的颜色
              return Theme.of(context).extension<AppColor>()!
                  .refreshButtonHoverColor; // hover 时的颜色
            }
            return Theme.of(context).extension<AppColor>()!.refreshButtonColor;
          },
        ),
        foregroundColor: WidgetStateProperty.all(Theme.of(context).colorScheme.onSurface),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8), // 圆角
          ),
        ),
        padding: WidgetStateProperty.all(EdgeInsets.zero),
      ),
      onPressed: onPressed,
      icon: Icon(Icons.refresh, size: 24,),
    ),
  );
}