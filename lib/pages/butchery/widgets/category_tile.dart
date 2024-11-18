part of '../butchery_library.dart';

/// A tile widget representing a category entry.
///
/// The [CategoryTile] displays a category's name and can be used for navigation or actions.
///
/// ### Example Usage
/// ```dart
/// CategoryTile(
///   name: 'Meat Cuts',
///   route: '/category/meat-cuts',
/// );
/// ```
class CategoryTile extends StatelessWidget {
  /// The name of the category to display.
  final String name;

  /// The route associated with the category.
  final String route;

  /// Creates a [CategoryTile].
  ///
  /// - [name]: The name of the category to display.
  /// - [route]: The route to navigate to when the tile is tapped.
  const CategoryTile({super.key, required this.name, required this.route});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: AppColors.white,
      title: Text(
        name,
        style: AppTheme.black500_14,
      ),
      trailing: SvgPicture.asset(
        'assets/svg/chevron-right-grey.svg',
        width: 24,
      ),
    );
  }
}
