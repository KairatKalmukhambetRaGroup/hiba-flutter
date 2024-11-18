part of '../courier_library.dart';

/// A widget that displays an individual item in the delivery order.
///
/// The [DeliveryItem] shows the item's image, name, price, and additional details.
///
/// ### Example Usage
/// ```dart
/// DeliveryItem(
///   menuItem: myMenuItem,
/// );
/// ```
class DeliveryItem extends StatelessWidget {
  /// The menu item to display.
  final MenuItem menuItem;
  const DeliveryItem({super.key, required this.menuItem});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(width: 1, color: AppColors.grey)),
      ),
      child: Row(
        children: [
          if (menuItem.image != null) ...[
            Image(
              image: MemoryImage(base64Decode(menuItem.image!)),
              height: 56,
              width: 80,
              fit: BoxFit.contain,
            ),
          ] else ...[
            Image.asset(
              'assets/images/meat.png',
              width: 80,
              height: 56,
              fit: BoxFit.contain,
            ),
          ],
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      menuItem.name,
                      style: AppTheme.black500_14,
                    ),
                    Text(
                      '${menuItem.price} ₸/${menuItem.isWholeAnimal ? 'гл' : 'кг'}',
                      style: AppTheme.blue700_14,
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                const Text(
                  'Реберная часть',
                  style: AppTheme.darkGrey500_11,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
