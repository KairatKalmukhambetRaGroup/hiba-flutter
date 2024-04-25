import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hiba/components/order_card.dart';
import 'package:hiba/entities/order.dart';
import 'package:hiba/utils/api/orders.dart';
import 'package:hiba/values/app_colors.dart';
import 'package:hiba/values/app_theme.dart';

class OrdersPage extends StatefulWidget {
  static const routeName = '/orders';
  const OrdersPage({super.key});

  @override
  State<StatefulWidget> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  List<Order> _orders = [];

  @override
  void initState() {
    super.initState();
    loadOrders();
  }

  Future<void> loadOrders() async {
    final data = await getMyOrders();
    if (data != null) {
      setState(() {
        _orders = data;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgLight,
      appBar: AppBar(
        title: const Text('Мои заказы'),
      ),
      body: SafeArea(
          child: _orders.length > 0
              ? Column(
                  children: _orders
                      .map((order) => OrderCard(title: order.id.toString()))
                      .toList(),
                )
              : Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 64),
                      SvgPicture.asset(
                        'assets/svg/shopping-cart-lg.svg',
                        width: 120,
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Заказов не было',
                        style: AppTheme.headingBlack600_16,
                      )
                    ],
                  ),
                )),
    );
  }
}
