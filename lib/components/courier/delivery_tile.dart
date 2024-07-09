import 'package:flutter/material.dart';
import 'package:hiba/entities/order.dart';
import 'package:hiba/values/app_colors.dart';
import 'package:hiba/values/app_theme.dart';

class DeliveryTile extends StatelessWidget {
  final Order order;
  const DeliveryTile({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Заказ №${order.id}",
                style: AppTheme.bodyBlack600_14,
              ),
              TextButton(
                onPressed: () {},
                child: const Text(
                  "Подробнее",
                  style: AppTheme.bodyBlue600_14,
                ),
              )
            ],
          ),
          Text(
            "от 28.07.2024",
            style: AppTheme.bodyDarkGrey600_11,
          ),
          const SizedBox(height: 16),
          const SizedBox(height: 8),
          const SizedBox(height: 16),
          TextButton(
            onPressed: () {},
            child: Container(
              width: double.maxFinite,
              decoration: BoxDecoration(
                color: AppColors.mainBlue,
                borderRadius: BorderRadius.circular(8.0),
              ),
              padding: const EdgeInsets.all(8.0),
              child: const Text(
                textAlign: TextAlign.center,
                "Принять",
                style: AppTheme.bodyWhite600_16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
