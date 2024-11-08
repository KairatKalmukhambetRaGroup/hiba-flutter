/// lib/utils/utils_library.dart
part of 'utils_library.dart';

/// An extension on [BuildContext] that provides convenience methods
/// for obtaining fractional heights and widths based on the screen size.
///
/// This extension allows quick access to screen dimensions as a fraction of the
/// total height or width, which can be useful for responsive layouts.
///
/// Example usage:
/// ```dart
/// // Get half the screen height
/// double halfHeight = context.heightFraction(sizeFraction: 0.5);
///
/// // Get a third of the screen width
/// double thirdWidth = context.widthFraction(sizeFraction: 0.33);
/// ```
extension ContextExtension on BuildContext {
  /// Returns a fraction of the screen height.
  ///
  /// - [sizeFraction] is the fraction of the total height. The default is 1,
  ///   which returns the full screen height.
  double heightFraction({double sizeFraction = 1}) =>
      MediaQuery.sizeOf(this).height * sizeFraction;

  /// Returns a fraction of the screen width.
  ///
  /// - [sizeFraction] is the fraction of the total width. The default is 1,
  ///   which returns the full screen width.
  double widthFraction({double sizeFraction = 1}) =>
      MediaQuery.sizeOf(this).width * sizeFraction;
}
