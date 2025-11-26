import 'package:flutter/material.dart';

class AppColor extends ThemeExtension<AppColor> {
  final Color refreshButtonColor;
  final Color refreshButtonHoverColor;
  final Color hoverColor;
  final Color directMessageBackground;
  final Color sideBarBackground;
  final Color sideBarButtonBackground;
  final Color defaultAvatarBackground;
  final Color defaultAvatarIcon;
  final Color dividerColor;
  final Color inputBackground;
  final Color inputHintText;
  final Color messageBubbleLeft;
  final Color messageTimeText;
  final Color tabBarBadgeBackground;
  final Color tabBarBadgeText;
  final Color searchSuggestBackground;
  final Color searchSuggestHoverBackground;
  final Color secondaryText;
  final Color videoPageBackground;
  final Color videoPageText;
  final Color videoPageSecondaryText;

  const AppColor({
    required this.refreshButtonColor,
    required this.refreshButtonHoverColor,
    required this.hoverColor,
    required this.directMessageBackground,
    required this.sideBarBackground,
    required this.sideBarButtonBackground,
    required this.defaultAvatarBackground,
    required this.defaultAvatarIcon,
    required this.dividerColor,
    required this.inputBackground,
    required this.inputHintText,
    required this.messageBubbleLeft,
    required this.messageTimeText,
    required this.tabBarBadgeBackground,
    required this.tabBarBadgeText,
    required this.searchSuggestBackground,
    required this.searchSuggestHoverBackground,
    required this.secondaryText,
    required this.videoPageBackground,
    required this.videoPageText,
    required this.videoPageSecondaryText,
  });

  @override
  ThemeExtension<AppColor> copyWith({
    Color? refreshButtonColor,
    Color? refreshButtonHoverColor,
    Color? hoverColor,
    Color? directMessageBackground,
    Color? sideBarBackground,
    Color? sideBarButtonBackground,
    Color? defaultAvatarBackground,
    Color? defaultAvatarIcon,
    Color? dividerColor,
    Color? inputBackground,
    Color? inputHintText,
    Color? messageBubbleLeft,
    Color? messageTimeText,
    Color? tabBarBadgeBackground,
    Color? tabBarBadgeText,
    Color? searchSuggestBackground,
    Color? searchSuggestHoverBackground,
    Color? secondaryText,
    Color? videoPageBackground,
    Color? videoPageText,
    Color? videoPageSecondaryText,
  }) {
    return AppColor(
      refreshButtonColor: refreshButtonColor ?? this.refreshButtonColor,
      refreshButtonHoverColor:
          refreshButtonHoverColor ?? this.refreshButtonHoverColor,
      hoverColor: hoverColor ?? this.hoverColor,
      directMessageBackground:
          directMessageBackground ?? this.directMessageBackground,
      sideBarBackground: sideBarBackground ?? this.sideBarBackground,
      sideBarButtonBackground: sideBarButtonBackground ?? this.sideBarButtonBackground,
      defaultAvatarBackground: defaultAvatarBackground ?? this.defaultAvatarBackground,
      defaultAvatarIcon: defaultAvatarIcon ?? this.defaultAvatarIcon,
      dividerColor: dividerColor ?? this.dividerColor,
      inputBackground: inputBackground ?? this.inputBackground,
      inputHintText: inputHintText ?? this.inputHintText,
      messageBubbleLeft: messageBubbleLeft ?? this.messageBubbleLeft,
      messageTimeText: messageTimeText ?? this.messageTimeText,
      tabBarBadgeBackground: tabBarBadgeBackground ?? this.tabBarBadgeBackground,
      tabBarBadgeText: tabBarBadgeText ?? this.tabBarBadgeText,
      searchSuggestBackground: searchSuggestBackground ?? this.searchSuggestBackground,
      searchSuggestHoverBackground: searchSuggestHoverBackground ?? this.searchSuggestHoverBackground,
      secondaryText: secondaryText ?? this.secondaryText,
      videoPageBackground: videoPageBackground ?? this.videoPageBackground,
      videoPageText: videoPageText ?? this.videoPageText,
      videoPageSecondaryText: videoPageSecondaryText ?? this.videoPageSecondaryText,
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
        sideBarBackground: Color.lerp(sideBarBackground, other.sideBarBackground, t)!,
        sideBarButtonBackground: Color.lerp(sideBarButtonBackground, other.sideBarButtonBackground, t)!,
        defaultAvatarBackground: Color.lerp(defaultAvatarBackground, other.defaultAvatarBackground, t)!,
        defaultAvatarIcon: Color.lerp(defaultAvatarIcon, other.defaultAvatarIcon, t)!,
        dividerColor: Color.lerp(dividerColor, other.dividerColor, t)!,
        inputBackground: Color.lerp(inputBackground, other.inputBackground, t)!,
        inputHintText: Color.lerp(inputHintText, other.inputHintText, t)!,
        messageBubbleLeft: Color.lerp(messageBubbleLeft, other.messageBubbleLeft, t)!,
        messageTimeText: Color.lerp(messageTimeText, other.messageTimeText, t)!,
        tabBarBadgeBackground: Color.lerp(tabBarBadgeBackground, other.tabBarBadgeBackground, t)!,
        tabBarBadgeText: Color.lerp(tabBarBadgeText, other.tabBarBadgeText, t)!,
        searchSuggestBackground: Color.lerp(searchSuggestBackground, other.searchSuggestBackground, t)!,
        searchSuggestHoverBackground: Color.lerp(searchSuggestHoverBackground, other.searchSuggestHoverBackground, t)!,
        secondaryText: Color.lerp(secondaryText, other.secondaryText, t)!,
        videoPageBackground: Color.lerp(videoPageBackground, other.videoPageBackground, t)!,
        videoPageText: Color.lerp(videoPageText, other.videoPageText, t)!,
        videoPageSecondaryText: Color.lerp(videoPageSecondaryText, other.videoPageSecondaryText, t)!,
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
