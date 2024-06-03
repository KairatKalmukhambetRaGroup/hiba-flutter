import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hiba/components/custom_app_bar.dart';
import 'package:hiba/entities/butchery.dart';
import 'package:hiba/entities/menu_item.dart';
import 'package:hiba/providers/shopping_basket.dart';
import 'package:hiba/values/app_colors.dart';
import 'package:hiba/values/app_theme.dart';
import 'package:provider/provider.dart';

class MenuItemPage extends StatelessWidget {
  final MenuItem menuItem;
  final Butchery butchery;
  final bool charity;
  const MenuItemPage({
    super.key,
    required this.menuItem,
    required this.butchery,
    required this.charity,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<ShoppingBasket>(builder: (context, shoppingBasket, child) {
      MenuItem basketItem = menuItem;
      final orderIndex = shoppingBasket.getOrderIndex(butchery, charity);
      if (orderIndex != -1) {
        basketItem = shoppingBasket.orders[orderIndex].items.firstWhere(
            (item) => item.id == menuItem.id,
            orElse: () => menuItem);
      }
      return Scaffold(
        backgroundColor: AppColors.bgLight,
        appBar: CustomAppBar(
          titleText: menuItem.name,
          context: context,
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  Image.asset(
                    'assets/images/meat.png',
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 16),
                  Container(
                    color: AppColors.white,
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              menuItem.name,
                              style: AppTheme.headingBlack600_16,
                            ),
                            Text(
                              '${menuItem.price} ₸/${menuItem.isWholeAnimal ? 'гл' : 'кг'}',
                              style: AppTheme.headingBlue700_16,
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        // ignore: prefer_const_constructors
                        Text(
                          '',
                          style: AppTheme.bodyDarkgrey500_11,
                        ),
                        if (menuItem.description.isNotEmpty)
                          Column(
                            children: [
                              const SizedBox(height: 16),
                              const Text(
                                'Описание',
                                style: AppTheme.headingBlack600_14,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                menuItem.description,
                                style: AppTheme.bodyBlack500_11,
                              )
                            ],
                          ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Вид',
                              style: AppTheme.bodyDarkgrey500_11,
                            ),
                            Text(
                              menuItem.categoryId.toString(),
                              style: AppTheme.bodyBlack500_11,
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
            Container(
              width: double.maxFinite,
              color: AppColors.white,
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: basketItem.quantity == 0
                  ? TextButton(
                      onPressed: () {
                        if (orderIndex != -1) {
                          shoppingBasket.addItemByOrderIndex(
                              menuItem, orderIndex);
                        } else {
                          shoppingBasket.addItem(menuItem, butchery, charity);
                        }
                      },
                      style: const ButtonStyle(
                        padding: MaterialStatePropertyAll(EdgeInsets.all(12)),
                        alignment: Alignment.center,
                        backgroundColor:
                            MaterialStatePropertyAll(AppColors.mainBlue),
                      ),
                      child: const Text(
                        'В корзину',
                        style: AppTheme.bodyWhite600_16,
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${(basketItem.price * basketItem.quantity).toString()} ₸',
                            style: AppTheme.headingBlue700_16,
                          ),
                          Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  shoppingBasket.removeItem(
                                      menuItem.id, butchery, charity);
                                },
                                icon: basketItem.quantity == 1
                                    ? SvgPicture.asset(
                                        'assets/svg/trash-can-outline.svg',
                                        width: 24,
                                      )
                                    : SvgPicture.asset(
                                        'assets/svg/round-minus.svg',
                                        width: 24,
                                      ),
                                iconSize: 24,
                              ),
                              SizedBox(
                                width: 76,
                                child: Text(
                                  menuItem.isWholeAnimal
                                      ? '${basketItem.quantity} гл'
                                      : '${basketItem.quantity} кг',
                                  style: AppTheme.bodyBlack500_14,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  if (orderIndex != -1) {
                                    shoppingBasket.addItemByOrderIndex(
                                        menuItem, orderIndex);
                                  } else {
                                    shoppingBasket.addItem(
                                        menuItem, butchery, charity);
                                  }
                                },
                                icon: SvgPicture.asset(
                                    'assets/svg/round-plus.svg'),
                                iconSize: 24,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
            )
          ],
        ),
      );
    });
  }
}
