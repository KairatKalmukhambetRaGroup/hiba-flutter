/// lib/utils/utils_library.dart
part of '../utils_library.dart';

//// A widget that provides a gradient background for its child widgets.
///
/// `GradientBackground` is useful for adding a gradient background to a section
/// of the UI. You can customize the gradient colors and include multiple child widgets.
///
/// Example usage:
/// ```dart
/// GradientBackground(
///   colors: [Colors.blue, Colors.green],
///   children: [
///     Text('Hello'),
///     ElevatedButton(onPressed: () {}, child: Text('Click Me')),
///   ],
/// );
/// ```
///
class GradientBackground extends StatelessWidget {
  /// Creates a [GradientBackground] widget.
  ///
  /// - [children] are the widgets displayed inside the gradient background.
  /// - [colors] is an optional parameter for customizing the gradient colors.
  ///   By default, it uses the [AppColors.defaultGradient].
  const GradientBackground({
    required this.children,
    this.colors = AppColors.defaultGradient,
    super.key,
  });

  /// A list of colors used to create the background gradient.
  ///
  /// If not provided, defaults to [AppColors.defaultGradient].
  final List<Color> colors;

  /// A list of widgets displayed inside the gradient background.
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(gradient: LinearGradient(colors: colors)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: context.heightFraction(sizeFraction: 0.1),
            ),
            ...children,
          ],
        ),
      ),
    );
  }
}
