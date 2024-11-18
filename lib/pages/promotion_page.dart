part of '../core_library.dart';

/// A page that displays detailed information about a promotion.
///
/// The [PromotionPage] presents the promotion's image, title, and description.
/// It allows users to view the full details of a specific promotion.
///
/// ### Example Usage
/// ```dart
/// Navigator.push(
///   context,
///   MaterialPageRoute(
///     builder: (context) => PromotionPage(promotion: myPromotion),
///   ),
/// );
/// ```
class PromotionPage extends StatelessWidget {
  /// The promotion to display.
  final Promotion promotion;

  /// Creates a [PromotionPage].
  ///
  /// - [promotion]: The [Promotion] object containing the details to display.
  const PromotionPage({super.key, required this.promotion});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgLight,
      appBar: CustomAppBar(
        context: context,
        titleText: 'Акция',
      ),
      body: ListView(
        children: [
          Image.memory(base64Decode(promotion.image)),
          const SizedBox(height: 16),
          Container(
            color: AppColors.white,
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            child: Text(
              promotion.title,
              style: AppTheme.blue600_16,
            ),
          ),
          const Divider(
            height: 1,
            color: AppColors.grey,
          ),
          Container(
            color: AppColors.white,
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            child: Text(
              promotion.description,
              style: AppTheme.black500_14,
            ),
          ),
        ],
      ),
    );
  }
}
