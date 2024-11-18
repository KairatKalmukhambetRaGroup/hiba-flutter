part of '../butchery_library.dart';

/// A tile widget representing a small butchery entry.
///
/// The [ButcheryTile] displays a butchery's name and allows navigation
/// to its detailed [ButcheryPage] when tapped.
///
/// ### Example Usage
/// ```dart
/// ButcheryTile(
///   butchery: ButcherySmall(
///     id: 1,
///     name: 'Halal Butchery',
///   ),
///   isCharity: true,
/// );
/// ```
class ButcheryTile extends StatelessWidget {
  /// The [ButcherySmall] instance containing the butchery details.
  final ButcherySmall butchery;

  /// Indicates if the navigation should include charity mode.
  final bool isCharity;

  /// Creates a [ButcheryTile].
  ///
  /// - [butchery]: The small butchery details to display.
  /// - [isCharity]: Whether the charity mode is enabled for the navigation.
  const ButcheryTile(
      {super.key, required this.butchery, required this.isCharity});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: AppColors.white,
      title: Text(
        butchery.name,
        style: AppTheme.black500_14,
      ),
      // subtitle: Text(
      //   butchery.categories.join(', '),
      //   style: AppTheme.darkGrey500_11,
      // ),
      trailing: SvgPicture.asset(
        'assets/svg/chevron-right-grey.svg',
        width: 24,
      ),
      onTap: () => {
        // print(isCharity)
        pushWithoutNavBar(
            context,
            MaterialPageRoute(
                builder: (context) => ButcheryPage(
                    id: butchery.id.toString(), charity: isCharity)))
      },
    );
  }
}
