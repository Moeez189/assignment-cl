import 'package:flutter/material.dart';

/// App dimensions and spacing
class AppDimens {
  AppDimens._();

  // Padding
  static const double paddingXS = 4.0;
  static const double paddingS = 8.0;
  static const double paddingM = 12.0;
  static const double paddingL = 16.0;
  static const double paddingXL = 20.0;
  static const double paddingXXL = 24.0;
  static const double paddingXXXL = 32.0;

  // Margin
  static const double marginXS = 4.0;
  static const double marginS = 8.0;
  static const double marginM = 12.0;
  static const double marginL = 16.0;
  static const double marginXL = 20.0;
  static const double marginXXL = 24.0;
  static const double marginXXXL = 32.0;

  // Border radius
  static const double radiusXS = 4.0;
  static const double radiusS = 8.0;
  static const double radiusM = 12.0;
  static const double radiusL = 16.0;
  static const double radiusXL = 20.0;
  static const double radiusXXL = 24.0;
  static const double radiusCircle = 100.0;

  // Icon sizes
  static const double iconXS = 16.0;
  static const double iconS = 20.0;
  static const double iconM = 24.0;
  static const double iconL = 32.0;
  static const double iconXL = 48.0;
  static const double iconXXL = 64.0;

  // Avatar sizes
  static const double avatarS = 32.0;
  static const double avatarM = 40.0;
  static const double avatarL = 56.0;
  static const double avatarXL = 72.0;

  // Card
  static const double cardElevation = 2.0;
  static const double cardRadius = 12.0;

  // Button
  static const double buttonHeight = 48.0;
  static const double buttonRadius = 24.0;

  // App bar
  static const double appBarHeight = 56.0;

  // Post card
  static const double postImageHeight = 200.0;
  static const double postDetailImageHeight = 250.0;
  static const double postCardMarginH = 16.0;
  static const double postCardMarginV = 8.0;

  // Search bar
  static const double searchBarHeight = 48.0;
  static const double searchBarRadius = 24.0;

  // Status views (empty, error, loading)
  static const double statusIconSize = 80.0;
}

/// Common EdgeInsets
class AppPadding {
  AppPadding._();

  static const EdgeInsets zero = EdgeInsets.zero;
  static const EdgeInsets allXS = EdgeInsets.all(AppDimens.paddingXS);
  static const EdgeInsets allS = EdgeInsets.all(AppDimens.paddingS);
  static const EdgeInsets allM = EdgeInsets.all(AppDimens.paddingM);
  static const EdgeInsets allL = EdgeInsets.all(AppDimens.paddingL);
  static const EdgeInsets allXL = EdgeInsets.all(AppDimens.paddingXL);
  static const EdgeInsets allXXL = EdgeInsets.all(AppDimens.paddingXXL);
  static const EdgeInsets allXXXL = EdgeInsets.all(AppDimens.paddingXXXL);

  static const EdgeInsets horizontalS = EdgeInsets.symmetric(horizontal: AppDimens.paddingS);
  static const EdgeInsets horizontalM = EdgeInsets.symmetric(horizontal: AppDimens.paddingM);
  static const EdgeInsets horizontalL = EdgeInsets.symmetric(horizontal: AppDimens.paddingL);
  static const EdgeInsets horizontalXL = EdgeInsets.symmetric(horizontal: AppDimens.paddingXL);

  static const EdgeInsets verticalS = EdgeInsets.symmetric(vertical: AppDimens.paddingS);
  static const EdgeInsets verticalM = EdgeInsets.symmetric(vertical: AppDimens.paddingM);
  static const EdgeInsets verticalL = EdgeInsets.symmetric(vertical: AppDimens.paddingL);
  static const EdgeInsets verticalXL = EdgeInsets.symmetric(vertical: AppDimens.paddingXL);

  /// Standard padding for post list (ListView.builder)
  static const EdgeInsets postListPadding = EdgeInsets.only(
    top: AppDimens.paddingS,
    bottom: AppDimens.paddingL,
  );
}

/// Common BorderRadius
class AppBorderRadius {
  AppBorderRadius._();

  static BorderRadius zero = BorderRadius.zero;
  static BorderRadius allXS = BorderRadius.circular(AppDimens.radiusXS);
  static BorderRadius allS = BorderRadius.circular(AppDimens.radiusS);
  static BorderRadius allM = BorderRadius.circular(AppDimens.radiusM);
  static BorderRadius allL = BorderRadius.circular(AppDimens.radiusL);
  static BorderRadius allXL = BorderRadius.circular(AppDimens.radiusXL);
  static BorderRadius circle = BorderRadius.circular(AppDimens.radiusCircle);
}
