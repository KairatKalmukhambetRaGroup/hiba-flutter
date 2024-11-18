part of '../notifications_library.dart';

/// A screen displaying notifications for couriers.
///
/// The [CourierNotifications] screen lists recent notifications related to
/// deliveries, such as order status updates or important messages.
///
/// ### Example Usage
/// ```dart
/// Navigator.push(
///   context,
///   MaterialPageRoute(
///     builder: (context) => const CourierNotifications(),
///   ),
/// );
/// ```
class CourierNotifications extends StatefulWidget {
  const CourierNotifications({super.key});

  @override
  State<StatefulWidget> createState() => _CourierNotificationsState();
}

class _CourierNotificationsState extends State<CourierNotifications> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      backgroundColor: AppColors.white,
      body: const SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Сегодня',
                  style: AppTheme.blue500_14,
                )
              ],
            ),
            NotificationMessage(
              title: 'Ваш заказ передан в службу доставки ',
              text:
                  'Ваш заказ будет доставлен 12 февраля. Курьер с вами заранее свяжется',
              orderId: '000001',
            ),
            SizedBox(height: 12),
            NotificationMessage(
              title: 'Заказ доставлен ',
              text: 'Поздравляем с покупкой. Спасибо что выбираете нас!',
              orderId: '000001',
            ),
          ],
        ),
      ),
    );
  }
}
