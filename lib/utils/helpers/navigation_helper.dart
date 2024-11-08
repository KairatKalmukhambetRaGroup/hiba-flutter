/// lib/utils/utils_library.dart
part of '../utils_library.dart';

/// A helper class for managing navigation in a Flutter application.
///
/// This class provides a centralized way to handle route navigation,
/// including named route pushes, replacements, and popping the current route.
/// It uses a [GlobalKey] to hold the application's `NavigatorState`,
/// making it possible to perform navigation operations without direct
/// access to the `BuildContext`.
///
/// Example usage:
/// ```dart
/// // Initialize the navigator key in the app:
/// MaterialApp(
///   navigatorKey: NavigationHelper.key,
///   // other configurations...
/// );
///
/// // Then navigate using:
/// NavigationHelper.pushNamed('/routeName', arguments: {...});
/// ```

class NavigationHelper {
  /// Private constructor to prevent instantiation of this utility class.
  const NavigationHelper._();

  /// A global key to hold the application's `NavigatorState`.
  ///
  /// This key allows accessing the navigator from anywhere in the app,
  /// making it possible to perform navigation operations without needing
  /// a `BuildContext`.
  static final _key = GlobalKey<NavigatorState>();

  /// Returns the global key for accessing the navigator.
  ///
  /// Can be used in `MaterialApp` to set the navigator key, enabling
  /// navigation through [NavigationHelper].
  static GlobalKey<NavigatorState> get key => _key;

  /// Pushes a named route onto the navigation stack.
  ///
  /// - [routeName] is the name of the route to navigate to.
  /// - [arguments] are any optional arguments to pass to the route.
  ///
  /// Returns a [Future] that completes when the pushed route is popped.
  static Future<T?>? pushNamed<T extends Object?>(
    String routeName, {
    Object? arguments,
  }) {
    return _key.currentState?.pushNamed<T?>(
      routeName,
      arguments: arguments,
    );
  }

  /// Replaces the current route with a named route.
  ///
  /// - [routeName] is the name of the new route.
  /// - [arguments] are any optional arguments to pass to the route.
  ///
  /// Returns a [Future] that completes when the pushed route is popped.
  static Future<T?>? pushReplacementNamed<T extends Object?>(
    String routeName, {
    Object? arguments,
  }) {
    return _key.currentState?.pushReplacementNamed(
      routeName,
      arguments: arguments,
    );
  }

  /// Pops the current route off the navigation stack.
  ///
  /// - [result] is an optional result to pass back to the previous route.
  static void pop<T extends Object?>([T? result]) {
    return _key.currentState?.pop(result);
  }
}
