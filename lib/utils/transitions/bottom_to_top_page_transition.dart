part of '../utils_library.dart';

/// A custom page transition used for smooth navigation in the app.
///
/// ### Example Usage
/// ```dart
/// Navigator.push(
///   context,
///   CustomPageTransition(
///     child: OrderConfirmPage(order: order),
///   ),
/// );
/// ```
class BottomToTopPageTransition extends MaterialPageRoute {
  /// Creates a [CustomPageTransition] with the given [child] widget.
  BottomToTopPageTransition({required Widget child})
      : super(builder: (BuildContext context) => child);

  /// Duration of the transition.
  @override
  Duration get transitionDuration => const Duration(milliseconds: 200);

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    var begin = const Offset(0.0, 1.0);
    var end = Offset.zero;
    var tween = Tween(begin: begin, end: end);
    var offsetAnimation = animation.drive(tween);
    return SlideTransition(
      position: offsetAnimation,
      child: child,
    );
  }
}
