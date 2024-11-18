part of '../order_library.dart';

/// A widget that displays an individual menu item in an order.
///
/// The [OrderMenuItemTile] shows details about a menu item within an order,
/// including:
/// - Item image
/// - Name
/// - Price per unit
/// - Quantity
/// - Total price
///
/// ### Example Usage
/// ```dart
/// OrderMenuItemTile(
///   menuItem: MenuItem(
///     name: 'Lamb Meat',
///     price: 5000,
///     isWholeAnimal: false,
///     quantity: 2,
///     image: 'path/to/image.png',
///   ),
/// );
/// ```
class OrderMenuItemTile extends StatelessWidget {
  /// The menu item to display.
  final MenuItem menuItem;

  /// Creates an [OrderMenuItemTile] widget.
  const OrderMenuItemTile({
    super.key,
    required this.menuItem,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: AppColors.white,
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(
            'assets/images/meat.png',
            width: 80,
            height: 56,
            fit: BoxFit.contain,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      child: Text(
                        menuItem.name,
                        style: AppTheme.black500_14,
                      ),
                    ),
                    Text(
                      '${menuItem.price} ₸/${menuItem.isWholeAnimal ? 'гл' : 'кг'}',
                      style: AppTheme.darkGrey500_11,
                    ),
                  ],
                ),
                const Text(
                  'Реберная часть',
                  style: AppTheme.darkGrey500_11,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'х ${menuItem.quantity} ${menuItem.isWholeAnimal ? 'гл' : 'кг'}',
                      style: AppTheme.black400_12,
                    ),
                    Text(
                      '${menuItem.calculateItemPrice()} ₸',
                      style: AppTheme.blue700_14,
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
