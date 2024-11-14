part of '../courier_library.dart';

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

class NotificationMessage extends StatelessWidget {
  const NotificationMessage(
      {super.key,
      required this.title,
      required this.text,
      required this.orderId});
  final String title;
  final String text;
  final String orderId;

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
