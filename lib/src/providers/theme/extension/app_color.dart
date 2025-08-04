import 'package:flutter/material.dart';

class AppColor extends ThemeExtension<AppColor> {
  final Color refreshButtonColor;
  final Color refreshButtonHoverColor;
  final Color hoverColor;
  final Color directMessageBackground;

  const AppColor({
    required this.refreshButtonColor,
    required this.refreshButtonHoverColor,
    required this.hoverColor,
    required this.directMessageBackground,
  });

  @override
  ThemeExtension<AppColor> copyWith({
    Color? refreshButtonColor,
    Color? refreshButtonHoverColor,
    Color? hoverColor,
    Color? directMessageBackground,
  }) {
    return AppColor(
      refreshButtonColor: refreshButtonColor ?? this.refreshButtonColor,
      refreshButtonHoverColor:
          refreshButtonHoverColor ?? this.refreshButtonHoverColor,
      hoverColor: hoverColor ?? this.hoverColor,
      directMessageBackground:
          directMessageBackground ?? this.directMessageBackground,
    );
  }

  @override
  ThemeExtension<AppColor> lerp(
    covariant ThemeExtension<AppColor>? other,
    double t,
  ) {
    if (other is AppColor) {
      return AppColor(
        refreshButtonColor: Color.lerp(
          refreshButtonColor,
          other.refreshButtonColor,
          t,
        )!,
        refreshButtonHoverColor: Color.lerp(
          refreshButtonHoverColor,
          other.refreshButtonHoverColor,
          t,
        )!,
        hoverColor: Color.lerp(hoverColor, other.hoverColor, t)!,
        directMessageBackground: Color.lerp(directMessageBackground, other.directMessageBackground, t)!,
      );
    }
    return this;
  }
}

extension AppColorExtension on ThemeData {
  AppColor get appColor {
    return extension<AppColor>()!;
  }
}
