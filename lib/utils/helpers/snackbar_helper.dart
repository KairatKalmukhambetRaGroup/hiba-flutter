/// lib/utils/utils_library.dart
part of '../utils_library.dart';

/// A helper class for displaying [SnackBar] in a Flutter application.
///
/// `SnackbarHelper` provides a simple way to show snack bar messages without requiring
/// direct access to the `BuildContext`. It uses a [GlobalKey] for the `ScaffoldMessengerState`,
/// allowing snack bars to be shown from anywhere in the app.
///
/// Example usage:
/// ```dart
/// // Initialize the scaffold messenger key in the app:
/// MaterialApp(
///   scaffoldMessengerKey: SnackbarHelper.key,
///   // other configurations...
/// );
///
/// // Show a snack bar message:
/// SnackbarHelper.showSnackBar('This is a message');
/// ```

class SnackbarHelper {
  /// Private constructor to prevent instantiation of this utility class.
  const SnackbarHelper._();

  /// A global key to access the [ScaffoldMessengerState] for showing snack bars.
  ///
  /// This key should be assigned to the `scaffoldMessengerKey` in the `MaterialApp` widget
  /// to enable displaying snack bars from [SnackbarHelper].
  static final _key = GlobalKey<ScaffoldMessengerState>();

  /// Returns the global key for accessing the scaffold messenger.
  static GlobalKey<ScaffoldMessengerState> get key => _key;

  /// Displays a snack bar with the specified [message].
  ///
  /// - [message] is the text to display in the snack bar. If null, an empty string is shown.
  /// - [isError] indicates if the snack bar represents an error (default is false).
  ///
  /// If there is an existing snack bar, it is removed before showing the new one.
  static void showSnackBar(String? message, {bool isError = false}) =>
      _key.currentState
        ?..removeCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(message ?? ''),
          ),
        );
}
