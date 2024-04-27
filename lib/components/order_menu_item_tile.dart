import 'package:flutter/material.dart';
import 'package:hiba/entities/menu_item.dart';
import 'package:hiba/values/app_colors.dart';
import 'package:hiba/values/app_theme.dart';

class OrderMenuItemTile extends StatelessWidget {
  final MenuItem menuItem;
  const OrderMenuItemTile({
    super.key,
    required this.menuItem,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: AppColors.white,
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(
            'assets/images/meat.png',
            width: 80,
            height: 56,
            fit: BoxFit.contain,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      menuItem.name,
                      style: AppTheme.bodyBlack500_14,
                    ),
                    Text(
                      '${menuItem.price} ₸/${menuItem.isWholeAnimal ? 'гл' : 'кг'}',
                      style: AppTheme.bodyBlue700_14,
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                const Text(
                  'Реберная часть',
                  style: AppTheme.bodyDarkgrey500_11,
                ),
                const SizedBox(height: 8),
              ],
            ),
          )
        ],
      ),
    );
  }
}
