import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hiba/entities/butchery.dart';
import 'package:hiba/entities/menu_item.dart';
import 'package:hiba/pages/butchery/menu_item_page.dart';
import 'package:hiba/providers/providers_library.dart';

import 'package:hiba/values/app_colors.dart';
import 'package:hiba/values/app_theme.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:provider/provider.dart';

class MenuItemTile extends StatelessWidget {
  final MenuItem menuItem;
  final Butchery butchery;
  final bool charity;
  const MenuItemTile(
      {super.key,
      required this.menuItem,
      required this.butchery,
      required this.charity});

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
      return Dismissible(
        key: UniqueKey(),
        direction: basketItem.quantity > 0
            ? DismissDirection.endToStart
            : DismissDirection.none,
        onDismissed: (direction) {
          if (direction == DismissDirection.endToStart) {
            shoppingBasket.deleteFromBasket(basketItem.id, butchery, charity);
          } else {
            return;
          }
        },
        dismissThresholds: const {DismissDirection.endToStart: 0.4},
        background: Container(
          color: AppColors.red,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SvgPicture.asset(
                'assets/svg/trash-can-outline-white.svg',
                width: 36,
              ),
              const SizedBox(width: 24),
            ],
          ),
        ),
        child: ListTile(
          onTap: () {
            pushWithoutNavBar(
              context,
              MaterialPageRoute(
                builder: (context) => MenuItemPage(
                  menuItem: menuItem,
                  butchery: butchery,
                  charity: charity,
                ),
              ),
            );
          },
          tileColor: AppColors.white,
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              if (menuItem.image != null) ...[
                Image(
                  image: MemoryImage(base64Decode(menuItem.image!)),
                  height: 56,
                  width: 80,
                  fit: BoxFit.contain,
                ),
              ] else ...[
                Image.asset(
                  'assets/images/meat.png',
                  width: 80,
                  height: 56,
                  fit: BoxFit.contain,
                ),
              ],
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
                          style: AppTheme.black500_14,
                        ),
                        Text(
                          '${menuItem.price} ₸/${menuItem.isWholeAnimal ? 'гл' : 'кг'}',
                          style: AppTheme.blue700_14,
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Реберная часть',
                      style: AppTheme.darkGrey500_11,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        basketItem.quantity == 0
                            ? TextButton(
                                onPressed: () {
                                  if (orderIndex != -1) {
                                    shoppingBasket.addItemByOrderIndex(
                                        menuItem, orderIndex);
                                  } else {
                                    shoppingBasket.addItem(
                                        menuItem, butchery, charity);
                                  }
                                },
                                style: const ButtonStyle(
                                  padding: WidgetStatePropertyAll(
                                      EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 5)),
                                  alignment: Alignment.center,
                                  backgroundColor: WidgetStatePropertyAll(
                                      AppColors.mainBlue),
                                ),
                                child: const Text(
                                  'В корзину',
                                  style: AppTheme.white600_11,
                                ))
                            : Row(
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
                                      style: AppTheme.black500_14,
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
                              )
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
