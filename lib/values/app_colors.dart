part of '../core_library.dart';

/// A utility class that defines the color palette used throughout the app.
///
/// The [AppColors] class provides a centralized place to access the standard colors
/// used in the application's theme, ensuring consistency across different widgets
/// and screens.
///
/// ### Example Usage
/// ```dart
/// Container(
///   color: AppColors.primaryColor,
///   child: Text(
///     'Hello, World!',
///     style: TextStyle(color: AppColors.white),
///   ),
/// )
/// ```
///
/// {@category Core}
class AppColors {
  const AppColors._();

  static const Color primaryColor = Color(0xffBAE162);
  static const Color darkBlue = Color(0xff1E2E3D);
  static const Color darkerBlue = Color(0xff152534);
  static const Color darkestBlue = Color(0xff0C1C2E);

  static const Color black = Color(0xff161616);
  static const Color white = Color(0xffffffff);

  static const Color red = Color(0xffEA455F);
  static const Color orange = Color(0xffF96800);
  static const Color mainBlue = Color(0xff2b3467);

  static const Color grey = Color(0xffd9d9d9);
  static const Color darkGrey = Color(0xff898A8D);

  static const Color bgLight = Color(0xfff5f5f5);

  static const List<Color> defaultGradient = [
    darkBlue,
    darkerBlue,
    darkestBlue,
  ];
}
