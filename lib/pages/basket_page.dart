import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hiba/components/custom_app_bar.dart';
import 'package:hiba/components/custom_scaffold.dart';
import 'package:hiba/components/menu_item_tile.dart';
import 'package:hiba/pages/orders/order_confirm_page.dart';
import 'package:hiba/providers/providers_library.dart';

import 'package:hiba/values/app_colors.dart';
import 'package:hiba/values/app_theme.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:provider/provider.dart';

class BasketPage extends StatefulWidget {
  static const routeName = '/basket';
  const BasketPage({super.key});

  @override
  State<StatefulWidget> createState() => _BasketPageState();
}

class _BasketPageState extends State<BasketPage> {
  @override
  Widget build(BuildContext context) {
    final shoppingBasket = Provider.of<ShoppingBasket>(context);

    return CustomScaffold(
      backgroundColor: AppColors.bgLight,
      appBar: CustomAppBar(
        titleText: 'Корзина',
        context: context,
      ),
      body: shoppingBasket.orders.isEmpty
          ? Center(
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
                    'Ваша корзина пуста',
                    style: AppTheme.black600_16,
                  )
                ],
              ),
            )
          : ListView.separated(
              itemBuilder: (context, i) {
                final order = shoppingBasket.orders[i];
                final items = order.items;
                return Container(
                  color: AppColors.white,
                  child: Column(
                    children: [
                      ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 16),
                        title: Text(
                          order.butchery.name,
                          style: AppTheme.blue600_16,
                        ),
                      ),
                      const Divider(height: 1, color: AppColors.grey),
                      const SizedBox(height: 8),
                      Text(
                        order.charity
                            ? 'На благотворительность'
                            : 'Для себя и близких',
                        style: AppTheme.blue500_14,
                      ),
                      const SizedBox(height: 8),
                      const Divider(height: 1, color: AppColors.grey),
                      for (final item in items)
                        MenuItemTile(
                            menuItem: item,
                            butchery: order.butchery,
                            charity: order.charity),
                      // ListView.separated(
                      //   itemBuilder: (context, j) {
                      //     final item = items[j];
                      //     return MenuItemTile(menuItem: item);
                      //   },
                      //   separatorBuilder: (context, j) => const Divider(
                      //     height: 1,
                      //     color: AppColors.grey,
                      //   ),
                      //   itemCount: items.length,
                      // ),
                      const Divider(height: 1, color: AppColors.darkGrey),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 24),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Общий вес заказа:'),
                                Text(
                                    '${order.calculateWeight().toString()} кг'),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Общая сумма:'),
                                Text('${order.calculatePrice().toString()} ₸'),
                              ],
                            ),
                            const SizedBox(height: 16),
                            TextButton(
                              onPressed: () {
                                pushWithoutNavBar(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            OrderConfirmPage(order: order)));
                              },
                              style: const ButtonStyle(
                                alignment: Alignment.center,
                                minimumSize:
                                    WidgetStatePropertyAll(Size.fromHeight(48)),
                                backgroundColor:
                                    WidgetStatePropertyAll(AppColors.mainBlue),
                              ),
                              child: const Text(
                                'Продолжить',
                                style: AppTheme.white600_16,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              },
              separatorBuilder: (context, i) => const SizedBox(height: 16),
              itemCount: shoppingBasket.orders.length),
    );
  }
}
