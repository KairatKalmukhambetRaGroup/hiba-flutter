import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hiba/entities/butchery.dart';
import 'package:hiba/entities/order.dart';
import 'package:hiba/values/app_theme.dart';

class DeliveryButcheryTile extends StatelessWidget {
  final Butchery butchery;
  final List<Order> orders;

  const DeliveryButcheryTile({
    super.key,
    required this.butchery,
    required this.orders,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                butchery.name,
                style: AppTheme.headingBlack600_16,
              ),
              Text(
                "${orders.length} заказов",
                style: AppTheme.bodyDarkGrey500_14,
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset('assets/svg/location.svg',
                  width: 24, height: 24),
              const SizedBox(width: 8),
              Text("г. ${butchery.city?.name}, ${butchery.address}")
            ],
          ),
          const SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset('assets/svg/phone.svg', width: 24, height: 24),
              const SizedBox(width: 8),
              Text("${butchery.phone}")
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {},
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "Доступные заявки",
                      style: AppTheme.bodyBlue600_14,
                    ),
                    SvgPicture.asset('assets/svg/chevron-right-blue.svg')
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
