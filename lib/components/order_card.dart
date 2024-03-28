import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hiba/values/app_colors.dart';
import 'package:hiba/values/app_theme.dart';

class OrderCard extends StatelessWidget {
  const OrderCard({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: ListTile(
        tileColor: AppColors.white,
        title: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTheme.bodyBlue600_14,
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
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
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Заказ №000003',
                    style: AppTheme.bodyBlack500_11,
                  ),
                  Text(
                    '158 200 ₸',
                    style: AppTheme.bodyBlue700_14,
                  ),
                ],
              ),
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Мкрн Самал-1, дом 16, 25 кв',
                  style: AppTheme.bodyBlack500_11,
                ),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 44,
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Детали заказа',
                    style: AppTheme.bodyBlue500_14,
                  ),
                  SvgPicture.asset('assets/svg/chevron-right-grey.svg')
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
