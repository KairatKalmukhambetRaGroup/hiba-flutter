import 'package:flutter/material.dart';
import 'package:hiba/components/order_card.dart';
import 'package:hiba/values/app_colors.dart';

class OrdersPage extends StatefulWidget {
  static const routeName = '/orders';
  const OrdersPage({super.key});

  @override
  State<StatefulWidget> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgLight,
      appBar: AppBar(
        title: const Text('Мои заказы'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            OrderCard(title: 'Доставлен'),
            OrderCard(title: 'Доставлен'),
          ],
        ),
      ),
    );
  }
}
