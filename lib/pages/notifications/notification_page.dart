part of 'notifications_library.dart';

/// A page that displays user notifications.
///
/// The [NotificationsPage] shows a list of notifications to the user,
/// such as order updates or important messages. It includes an app bar
/// with the title 'Уведомления' and a list of [NotificationMessage] widgets.
///
/// ### Example Usage
/// ```dart
/// Navigator.push(
///   context,
///   MaterialPageRoute(
///     builder: (context) => const NotificationsPage(),
///   ),
/// );
/// ```
class NotificationsPage extends StatefulWidget {
  /// Creates a [NotificationsPage].
  const NotificationsPage({super.key});

  @override
  State<StatefulWidget> createState() => _NotificationsPageState();
}

/// The state class for [NotificationsPage].
///
/// Manages the display of notifications and builds the UI accordingly.
class _NotificationsPageState extends State<NotificationsPage> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      backgroundColor: AppColors.white,
      appBar: CustomAppBar(
        titleText: 'Уведомления',
        context: context,
      ),
      body: const Column(
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
    );
  }
}
