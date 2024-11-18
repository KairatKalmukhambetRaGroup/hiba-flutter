part of '../notifications_library.dart';

/// A widget representing an individual notification message.
///
/// The [NotificationMessage] displays details about a notification, including:
/// - The title.
/// - The text body.
/// - The associated order ID.
///
/// ### Example Usage
/// ```dart
/// NotificationMessage(
///   title: 'Order Status Changed',
///   text: 'Your order has been shipped.',
///   orderId: '123456',
/// );
/// ```
class NotificationMessage extends StatelessWidget {
  /// The title of the notification.
  final String title;

  /// The detailed text of the notification.
  final String text;

  /// The order ID associated with the notification.
  final String orderId;

  /// Creates a [NotificationMessage].
  ///
  /// - [title]: The title of the notification.
  /// - [text]: The description or details of the notification.
  /// - [orderId]: The associated order ID.
  const NotificationMessage(
      {super.key,
      required this.title,
      required this.text,
      required this.orderId});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 44),
      child: Container(
        color: AppColors.bgLight,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Статус заказа №$orderId изменен',
                style: AppTheme.darkGrey500_11,
              ),
              const SizedBox(height: 8),
              Text(
                title,
                style: AppTheme.orange500_16,
              ),
              const SizedBox(height: 8),
              Text(
                text,
                style: AppTheme.black500_14,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
