part of '../core_library.dart';

/// A utility class that defines regular expressions used for validation throughout the app.
///
/// The [AppRegex] class centralizes commonly used regular expressions for validating
/// user input, such as email addresses, phone numbers, and passwords, ensuring consistency
/// and reducing redundancy across the application.
///
/// ### Example Usage
/// ```dart
/// bool isValidEmail(String email) {
///   return AppRegex.emailRegex.hasMatch(email);
/// }
/// ```
class AppRegex {
  const AppRegex._();

  /// Regular expression to validate email addresses.
  ///
  /// Matches standard email formats such as:
  /// - `example@domain.com`
  /// - `user.name@sub.domain.org`
  /// - Does not support spaces or special characters outside the allowed set.
  static final RegExp emailRegex = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.([a-zA-Z]{2,})+");

  /// Regular expression to validate phone numbers.
  ///
  /// Matches formats like:
  /// - `+1234567890`
  /// - `(123) 456-7890`
  /// - `123-456-7890`
  /// - Does not enforce a specific country code.
  static final RegExp phoneNumberRegex =
      RegExp(r"^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$");

  /// Regular expression to validate strong passwords.
  ///
  /// Enforces:
  /// - At least one lowercase letter.
  /// - At least one uppercase letter.
  /// - At least one numeric digit.
  /// - At least one special character from `@$#!%*?&_`.
  /// - Minimum length of 8 characters.
  static final RegExp passwordRegex = RegExp(
      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$#!%*?&_])[A-Za-z\d@#$!%*?&_].{7,}$');
}
