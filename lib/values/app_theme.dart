part of '../core_library.dart';

class AppTheme {
  static const textFormFieldBorder = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(12)),
    borderSide: BorderSide(color: Colors.grey, width: 1.6),
  );

  static final ThemeData themeData = ThemeData(
    useMaterial3: true,
    colorSchemeSeed: AppColors.primaryColor,
    scaffoldBackgroundColor: AppColors.bgLight,
    textTheme: const TextTheme(
      titleLarge: TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.white,
        fontSize: 34,
        letterSpacing: 0.5,
      ),
      bodySmall: TextStyle(
        fontWeight: FontWeight.normal,
        color: Colors.black,
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

// WHITE
  static const TextStyle white500_14 = TextStyle(
    color: AppColors.white,
    fontWeight: FontWeight.w500,
    fontSize: 14,
    height: 1,
  );
  static const TextStyle white500_16 = TextStyle(
    color: AppColors.white,
    fontWeight: FontWeight.w500,
    fontSize: 16,
  );
  static const TextStyle white600_11 = TextStyle(
    color: AppColors.white,
    fontWeight: FontWeight.w600,
    fontSize: 11,
  );
  static const TextStyle white600_16 = TextStyle(
    color: AppColors.white,
    fontWeight: FontWeight.w600,
    fontSize: 16,
  );
  static const TextStyle white700_34 = TextStyle(
    fontWeight: FontWeight.w700,
    color: Colors.white,
    fontSize: 34,
    letterSpacing: 0.5,
  );

// BLACK
  static const TextStyle black400_12 = TextStyle(
    color: AppColors.black,
    fontWeight: FontWeight.w400,
    fontSize: 12,
  );
  static const TextStyle black400_14 = TextStyle(
    color: AppColors.black,
    fontWeight: FontWeight.w400,
    fontSize: 14,
  );
  static const TextStyle black400_16 = TextStyle(
    color: AppColors.black,
    fontWeight: FontWeight.w400,
    fontSize: 16,
  );
  static const TextStyle black500_11 = TextStyle(
    color: AppColors.black,
    fontWeight: FontWeight.w500,
    fontSize: 11,
  );
  static const TextStyle black500_14 = TextStyle(
    color: AppColors.black,
    fontWeight: FontWeight.w500,
    fontSize: 14,
  );
  static const TextStyle black500_16 = TextStyle(
    color: AppColors.black,
    fontWeight: FontWeight.w500,
    fontSize: 16,
  );
  static const TextStyle black600_14 = TextStyle(
    color: AppColors.black,
    fontWeight: FontWeight.w600,
    fontSize: 14,
    height: 1,
  );
  static const TextStyle black600_16 = TextStyle(
    color: AppColors.black,
    fontWeight: FontWeight.w600,
    fontSize: 16,
  );
  static const TextStyle black600_28 = TextStyle(
    color: AppColors.black,
    fontWeight: FontWeight.w600,
    fontSize: 28,
  );

  // DARKGREY
  static const TextStyle darkGrey500_11 = TextStyle(
    color: AppColors.darkGrey,
    fontWeight: FontWeight.w500,
    fontSize: 11,
    height: 1,
  );
  static const TextStyle darkGrey500_14 = TextStyle(
    color: AppColors.darkGrey,
    fontWeight: FontWeight.w500,
    fontSize: 14,
  );
  static const TextStyle darkGrey500_16 = TextStyle(
    color: AppColors.darkGrey,
    fontWeight: FontWeight.w500,
    fontSize: 16,
  );
  static const TextStyle darkGrey600_11 = TextStyle(
    color: AppColors.darkGrey,
    fontWeight: FontWeight.w600,
    fontSize: 11,
  );

// BLUE
  static const TextStyle blue500_11 = TextStyle(
    color: AppColors.mainBlue,
    fontWeight: FontWeight.w500,
    fontSize: 11,
  );
  static const TextStyle blue500_14 = TextStyle(
    color: AppColors.mainBlue,
    fontWeight: FontWeight.w500,
    fontSize: 14,
  );
  static const TextStyle blue500_16 = TextStyle(
    color: AppColors.mainBlue,
    fontWeight: FontWeight.w500,
    fontSize: 16,
  );
  static const TextStyle blue600_14 = TextStyle(
    color: AppColors.mainBlue,
    fontWeight: FontWeight.w600,
    fontSize: 14,
    height: 1,
  );
  static const TextStyle blue600_16 = TextStyle(
    color: AppColors.mainBlue,
    fontWeight: FontWeight.w600,
    fontSize: 16,
  );

  static const TextStyle blue700_14 = TextStyle(
    color: AppColors.mainBlue,
    fontWeight: FontWeight.w700,
    fontSize: 14,
  );

  static const TextStyle blue700_16 = TextStyle(
    color: AppColors.mainBlue,
    fontWeight: FontWeight.w700,
    fontSize: 16,
  );

  static const TextStyle orange500_16 = TextStyle(
    color: AppColors.orange,
    fontWeight: FontWeight.w500,
    fontSize: 16,
  );
  static const TextStyle orange600_14 = TextStyle(
    color: AppColors.orange,
    fontWeight: FontWeight.w600,
    fontSize: 14,
  );

  static const TextStyle red500_16 = TextStyle(
    color: AppColors.red,
    fontWeight: FontWeight.w500,
    fontSize: 16,
  );
  static const TextStyle red600_16 = TextStyle(
    color: AppColors.red,
    fontWeight: FontWeight.w600,
    fontSize: 16,
  );
  static const TextStyle red700_16 = TextStyle(
    color: AppColors.red,
    fontWeight: FontWeight.w700,
    fontSize: 16,
  );
  static const TextStyle grey500_16 = TextStyle(
    color: AppColors.grey,
    fontWeight: FontWeight.w500,
    fontSize: 16,
  );
  static const TextStyle grey400_14 = TextStyle(
    color: Colors.grey,
    fontWeight: FontWeight.w400,
    fontSize: 14,
    letterSpacing: 0.5,
  );
}
