import 'package:flutter/material.dart';
import 'package:hiba/pages/butchery_page.dart';
import 'package:hiba/providers/shopping_basket.dart';
import 'package:hiba/values/app_colors.dart';
import 'package:hiba/values/app_theme.dart';
import 'package:provider/provider.dart';

class BasketPage extends StatefulWidget {
  static const routeName = 'basket';
  const BasketPage({super.key});

  @override
  State<StatefulWidget> createState() => _BasketPageState();
}

class _BasketPageState extends State<BasketPage> {
  @override
  Widget build(BuildContext context) {
    final shoppingBasket = Provider.of<ShoppingBasket>(context);

    return Scaffold(
      backgroundColor: AppColors.bgLight,
      appBar: AppBar(
        // leading: SvgPicture.asset(
        //   'assets/svg/chevron-left.svg',
        //   width: 24,
        // ),
        title: const Text(
          'Корзина',
          style: AppTheme.headingBlack600_16,
        ),
        centerTitle: true,
      ),
      body: ListView.separated(
        itemBuilder: (context, index) {
          final item = shoppingBasket.items[index];
          return MenuItemTile(menuItem: item);
        },
        separatorBuilder: (context, index) => const Divider(
          height: 1,
          color: AppColors.grey,
        ),
        itemCount: shoppingBasket.items.length,
      ),
    );
  }
}
