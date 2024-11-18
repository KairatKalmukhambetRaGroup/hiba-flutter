part of '../core_library.dart';

/// A custom AppBar widget that provides consistent styling and behavior across the app.
///
/// The [CustomAppBar] extends Flutter's [AppBar] and applies predefined configurations,
/// such as background color, leading icon behavior, title styling, and bottom border.
///
/// ### Example Usage
/// ```dart
/// AppBar appBar = CustomAppBar(
///   titleText: 'Page Title',
///   context: context,
/// );
/// ```
class CustomAppBar extends AppBar {
  /// The title text displayed in the app bar.
  final String? titleText;

  /// The build context, used to determine navigation capabilities.
  final BuildContext context;

  /// Creates a [CustomAppBar] with consistent styling and behavior.
  ///
  /// - [titleText]: The text to display as the title in the app bar. If null, no title is displayed.
  /// - [context]: The build context, required to check if navigation pop is possible.

  CustomAppBar({super.key, this.titleText, required this.context})
      : super(
          automaticallyImplyLeading: true,
          leadingWidth: 48,
          leading: Navigator.of(context).canPop()
              ? IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: SvgPicture.asset('assets/svg/chevron-left-grey.svg'),
                )
              : null,
          backgroundColor: AppColors.white,
          surfaceTintColor: AppColors.white,
          title: titleText == null
              ? null
              : Text(
                  titleText,
                  style: AppTheme.black600_16,
                ),
          shape:
              const Border(bottom: BorderSide(width: 1, color: AppColors.grey)),
          centerTitle: true,
        );
}
