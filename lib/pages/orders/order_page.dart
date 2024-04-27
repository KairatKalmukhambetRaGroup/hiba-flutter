import 'package:flutter/material.dart';
import 'package:hiba/components/order_menu_item_tile.dart';
import 'package:hiba/entities/order.dart';
import 'package:hiba/values/app_colors.dart';
import 'package:hiba/values/app_theme.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({super.key, required this.order});
  final Order order;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgLight,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        automaticallyImplyLeading: true,
        title: Text(
          'Заказ №${order.id}',
          style: AppTheme.headingBlack600_16,
        ),
        centerTitle: true,
        shape:
            const Border(bottom: BorderSide(width: 1, color: AppColors.grey)),
      ),
      body: ListView(
        children: [
          ListTile(
            tileColor: AppColors.white,
            title: Text(
              order.orderStatus,
              style: AppTheme.headingBlue600_16,
            ),
            subtitle: Text(
              'data',
              style: AppTheme.bodyDarkGrey500_14,
            ),
          ),
          if (order.address != null)
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: ListTile(
                tileColor: AppColors.white,
                title: const Text(
                  'Адрес доставки',
                  style: AppTheme.bodyDarkgrey500_11,
                ),
                subtitle: Text(
                  order.address!.info,
                  style: AppTheme.headingBlack600_14,
                ),
              ),
            ),
          const SizedBox(height: 16),
          ExpansionTile(
            initiallyExpanded: true,
            shape: const Border.fromBorderSide(BorderSide.none),
            collapsedBackgroundColor: AppColors.white,
            backgroundColor: AppColors.white,
            title: Text(
              order.butchery.name,
              style: AppTheme.headingBlue600_16,
            ),
            children: order.items
                .map((item) => OrderMenuItemTile(menuItem: item))
                .toList(),
          ),
          Container(
            color: AppColors.white,
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Мясная продукция',
                      style: AppTheme.bodyBlack500_14,
                    ),
                    Text(
                      order.calculatePrice().toString(),
                      style: AppTheme.bodyBlack500_14,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Доставка',
                      style: AppTheme.bodyBlack500_14,
                    ),
                    Text(
                      order.deliveryPrice == 0
                          ? 'бесплатно'
                          : order.deliveryPrice.toString(),
                      style: AppTheme.bodyBlack500_14,
                    ),
                  ],
                ),
                if (order.donation != 0)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'На благотворительность',
                        style: AppTheme.bodyBlack500_14,
                      ),
                      Text(
                        '${order.donation.toString()} ₸',
                        style: AppTheme.bodyBlack500_14,
                      ),
                    ],
                  ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Общая сумма заказа:',
                      style: AppTheme.bodyRed500_16,
                    ),
                    Text(
                      '${order.totalPrice.toString()} ₸',
                      style: AppTheme.headingRed700_16,
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
