import 'package:flutter/material.dart';

class AppColor extends ThemeExtension<AppColor> {
  final Color refreshButtonColor;
  final Color refreshButtonHoverColor;

  const AppColor({required this.refreshButtonColor, required this.refreshButtonHoverColor});

  @override
  ThemeExtension<AppColor> copyWith({Color? refreshButtonColor, Color? refreshButtonHoverColor}) {
    return AppColor(
      refreshButtonColor: refreshButtonColor ?? this.refreshButtonColor,
      refreshButtonHoverColor: refreshButtonHoverColor ?? this.refreshButtonHoverColor,
    );
  }

  @override
  ThemeExtension<AppColor> lerp(
    covariant ThemeExtension<AppColor>? other,
    double t,
  ) {
    if (other is AppColor) {
      return AppColor(
        refreshButtonColor: Color.lerp(refreshButtonColor, other.refreshButtonColor, t)!,
        refreshButtonHoverColor: Color.lerp(refreshButtonHoverColor, other.refreshButtonHoverColor, t)!,
      );
    }
    return this;
  }
}
