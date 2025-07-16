import 'package:flutter/material.dart';

class AppColor extends ThemeExtension<AppColor> {
  final Color refreshButtonColor;
  final Color refreshButtonHoverColor;
  final Color hoverColor;

  const AppColor({required this.refreshButtonColor, required this.refreshButtonHoverColor, required this.hoverColor});

  @override
  ThemeExtension<AppColor> copyWith({Color? refreshButtonColor, Color? refreshButtonHoverColor, Color? hoverColor}) {
    return AppColor(
      refreshButtonColor: refreshButtonColor ?? this.refreshButtonColor,
      refreshButtonHoverColor: refreshButtonHoverColor ?? this.refreshButtonHoverColor,
      hoverColor: hoverColor ?? this.hoverColor,
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
        hoverColor: Color.lerp(hoverColor, other.hoverColor, t)!,
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

main() {
  List<int> rgb = [246, 247, 248];
  for (var element in rgb) {
    //16进制
    print(element.toRadixString(16));
  }
}

