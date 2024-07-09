import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hiba/entities/order.dart';
import 'package:hiba/pages/orders/order_page.dart';
import 'package:hiba/values/app_colors.dart';
import 'package:hiba/values/app_theme.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class OrderCard extends StatelessWidget {
  const OrderCard({super.key, required this.order});
  final Order order;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        tileColor: AppColors.white,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                order.orderStatus,
                style: AppTheme.bodyBlue600_14,
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              // child: SingleChildScrollView(
              //   scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Image.asset(
                    'assets/images/meat.png',
                    width: 96,
                    height: 64,
                    fit: BoxFit.contain,
                  ),
                  Image.asset(
                    'assets/images/meat.png',
                    width: 96,
                    height: 64,
                    fit: BoxFit.contain,
                  ),
                  Image.asset(
                    'assets/images/meat.png',
                    width: 96,
                    height: 64,
                    fit: BoxFit.contain,
                  ),
                ],
                // ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Заказ №${order.id}',
                    style: AppTheme.bodyBlack500_11,
                  ),
                  // ignore: prefer_const_constructors
                  Text(
                    '${order.totalPrice} ₸',
                    style: AppTheme.bodyBlue700_14,
                  ),
                ],
              ),
            ),
            if (order.address != null)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  order.address!.info,
                  style: AppTheme.bodyBlack500_11,
                ),
              ),
            const SizedBox(height: 16),
            const Divider(height: 1, color: AppColors.grey),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SizedBox(
                height: 44,
                width: double.infinity,
                child: InkResponse(
                  onTap: () {
                    pushWithNavBar(
                      context,
                      MaterialPageRoute(
                          fullscreenDialog: false,
                          builder: (context) => OrderPage(order: order)),
                    );
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Детали заказа',
                        style: AppTheme.bodyBlue500_14,
                      ),
                      SvgPicture.asset(
                        'assets/svg/chevron-right-grey.svg',
                        width: 24,
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
