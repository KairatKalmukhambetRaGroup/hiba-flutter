import 'package:flutter/material.dart';
import 'package:hiba/values/app_colors.dart';
import 'package:hiba/values/app_theme.dart';

class NotificationsPage extends StatefulWidget {
  static const routeName = '/notifications';
  const NotificationsPage({super.key});

  @override
  State<StatefulWidget> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: const Text(
          'Уведомления',
          style: AppTheme.headingBlack600_16,
        ),
        centerTitle: true,
      ),
      body: const Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Сегодня',
                style: AppTheme.bodyBlue500_14,
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
                style: AppTheme.bodyDarkgrey500_11,
              ),
              const SizedBox(height: 8),
              Text(
                title,
                style: AppTheme.headingOrange500_16,
              ),
              const SizedBox(height: 8),
              Text(
                text,
                style: AppTheme.bodyBlack500_14,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
