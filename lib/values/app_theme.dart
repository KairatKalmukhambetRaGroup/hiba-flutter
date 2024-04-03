import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTheme {
  static const textFormFieldBorder = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(12)),
    borderSide: BorderSide(color: Colors.grey, width: 1.6),
  );

  static final ThemeData themeData = ThemeData(
    useMaterial3: true,
    colorSchemeSeed: AppColors.primaryColor,
    scaffoldBackgroundColor: Colors.white,
    textTheme: const TextTheme(
      titleLarge: TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.white,
        fontSize: 34,
        letterSpacing: 0.5,
      ),
      bodySmall: TextStyle(
        color: Colors.grey,
        fontSize: 14,
        letterSpacing: 0.5,
      ),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      filled: true,
      fillColor: Colors.transparent,
      errorStyle: TextStyle(fontSize: 12),
      contentPadding: EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 14,
      ),
      border: textFormFieldBorder,
      errorBorder: textFormFieldBorder,
      focusedBorder: textFormFieldBorder,
      focusedErrorBorder: textFormFieldBorder,
      enabledBorder: textFormFieldBorder,
      labelStyle: TextStyle(
        fontSize: 17,
        color: Colors.grey,
        fontWeight: FontWeight.w500,
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.primaryColor,
        padding: const EdgeInsets.all(4),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        textStyle: const TextStyle(fontWeight: FontWeight.bold),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.primaryColor,
        minimumSize: const Size(double.infinity, 50),
        side: BorderSide(color: Colors.grey.shade200),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
      ),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        foregroundColor: Colors.black,
        backgroundColor: AppColors.primaryColor,
        disabledBackgroundColor: Colors.grey.shade300,
        minimumSize: const Size(double.infinity, 52),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
      ),
    ),
  );

  static const TextStyle bodyBlack500_14 = TextStyle(
    color: AppColors.black,
    fontWeight: FontWeight.w500,
    fontSize: 14,
  );
  static const TextStyle bodyDarkGrrey500_14 = TextStyle(
    color: AppColors.darkGrey,
    fontWeight: FontWeight.w500,
    fontSize: 14,
  );
  static const TextStyle bodyWhite500_14 = TextStyle(
    color: AppColors.white,
    fontWeight: FontWeight.w500,
    fontSize: 14,
  );

  static const TextStyle bodyBlack600_28 = TextStyle(
    color: AppColors.black,
    fontWeight: FontWeight.w600,
    fontSize: 28,
  );

  static const TextStyle headingBlack500_16 = TextStyle(
    color: AppColors.black,
    fontWeight: FontWeight.w500,
    fontSize: 16,
  );
  static const TextStyle headingBlack400_16 = TextStyle(
    color: AppColors.black,
    fontWeight: FontWeight.w400,
    fontSize: 16,
  );
  static const TextStyle headingWhite500_16 = TextStyle(
    color: AppColors.white,
    fontWeight: FontWeight.w500,
    fontSize: 16,
  );
  static const TextStyle headingBlue600_16 = TextStyle(
    color: AppColors.mainBlue,
    fontWeight: FontWeight.w600,
    fontSize: 16,
  );

  static const TextStyle bodyBlue700_14 = TextStyle(
    color: AppColors.mainBlue,
    fontWeight: FontWeight.w700,
    fontSize: 14,
  );
  static const TextStyle bodyBlue600_14 = TextStyle(
    color: AppColors.mainBlue,
    fontWeight: FontWeight.w600,
    fontSize: 14,
  );
  static const TextStyle bodyBlue500_14 = TextStyle(
    color: AppColors.mainBlue,
    fontWeight: FontWeight.w500,
    fontSize: 14,
  );
  static const TextStyle bodyBlue500_16 = TextStyle(
    color: AppColors.mainBlue,
    fontWeight: FontWeight.w500,
    fontSize: 16,
  );

  static const TextStyle headingBlack600_14 = TextStyle(
    color: AppColors.black,
    fontWeight: FontWeight.w600,
    fontSize: 14,
  );

  static const TextStyle bodyBlack400_14 = TextStyle(
    color: AppColors.black,
    fontWeight: FontWeight.w400,
    fontSize: 14,
  );
  static const TextStyle headingBlack600_16 = TextStyle(
    color: AppColors.black,
    fontWeight: FontWeight.w600,
    fontSize: 16,
  );

  static const TextStyle bodyBlack500_11 = TextStyle(
    color: AppColors.black,
    fontWeight: FontWeight.w500,
    fontSize: 11,
  );
  static const TextStyle bodyBlue500_11 = TextStyle(
    color: AppColors.mainBlue,
    fontWeight: FontWeight.w500,
    fontSize: 11,
  );

  static const TextStyle bodyDarkgrey500_11 = TextStyle(
    color: AppColors.darkGrey,
    fontWeight: FontWeight.w500,
    fontSize: 11,
  );
  static const TextStyle bodyDarkgrey500_16 = TextStyle(
    color: AppColors.darkGrey,
    fontWeight: FontWeight.w500,
    fontSize: 16,
  );

  static const TextStyle titleLarge = TextStyle(
    fontWeight: FontWeight.bold,
    color: Colors.white,
    fontSize: 34,
    letterSpacing: 0.5,
  );

  static const TextStyle bodySmall = TextStyle(
    color: Colors.grey,
    letterSpacing: 0.5,
  );

  static const TextStyle headingOrange500_16 = TextStyle(
    color: AppColors.orange,
    fontWeight: FontWeight.w500,
    fontSize: 16,
  );

  static const TextStyle bodyRed500_16 = TextStyle(
    color: AppColors.red,
    fontWeight: FontWeight.w500,
    fontSize: 16,
  );
  static const TextStyle bodyGrey500_16 = TextStyle(
    color: AppColors.grey,
    fontWeight: FontWeight.w500,
    fontSize: 16,
  );
}
