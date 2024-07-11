import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hiba/components/courier/delivery_popup.dart';
import 'package:hiba/entities/order.dart';
import 'package:hiba/pages/courier/delivery.dart';
import 'package:hiba/values/app_colors.dart';
import 'package:hiba/values/app_theme.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class DeliveryTile extends StatelessWidget {
  final Order order;
  bool? fromButchery = false;
  final bool isActive;
  DeliveryTile({
    super.key,
    required this.order,
    this.fromButchery,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 1, color: AppColors.grey),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Заказ №${order.id}",
                style: AppTheme.black600_14,
              ),
              TextButton(
                onPressed: () {
                  pushWithoutNavBar(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Delivery(order: order),
                    ),
                  );
                },
                child: const Text(
                  "Подробнее",
                  style: AppTheme.blue600_14,
                ),
              )
            ],
          ),
          Text(
            "от 28.07.2024",
            style: AppTheme.darkGrey600_11,
          ),
          const SizedBox(height: 16),
          if (fromButchery == null || fromButchery == false) ...[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SvgPicture.asset('assets/svg/dotA.svg', width: 24, height: 24),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      order.butchery.name,
                      style: AppTheme.darkGrey500_11,
                    ),
                    Text(
                        "г. ${order.butchery.city?.name}, ${order.butchery.address}")
                  ],
                )
              ],
            ),
            const SizedBox(height: 8),
          ],
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SvgPicture.asset('assets/svg/dotB.svg', width: 24, height: 24),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${order.user?.name}",
                    style: AppTheme.darkGrey500_11,
                  ),
                  Text(
                      "г. ${order.address?.city.name}, ${order.address?.address}, дом ${order.address?.building}, кв ${order.address?.apartment}")
                ],
              )
            ],
          ),
          const SizedBox(height: 16),
          TextButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return DeliveryPopup(status: order.status);
                },
              );
            },
            child: Container(
              width: double.maxFinite,
              decoration: BoxDecoration(
                color: order.status == "ON_THE_WAY"
                    ? AppColors.red
                    : AppColors.mainBlue,
                borderRadius: BorderRadius.circular(8.0),
              ),
              padding: const EdgeInsets.all(8.0),
              child: Text(
                textAlign: TextAlign.center,
                order.status == 'PREPARING_FOR_DELIVERY'
                    ? "Принять"
                    : order.status == 'RECIEVED'
                        ? "Подтвердить получение"
                        : "Завершить доставку",
                style: AppTheme.white600_16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
