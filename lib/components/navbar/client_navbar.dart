import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hiba/pages/basket_page.dart';
import 'package:hiba/pages/home_page.dart';
import 'package:hiba/pages/profile/profile_library.dart' show ProfilePage;
import 'package:hiba/core_library.dart' show AppColors;

import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class ClientNavbar extends StatelessWidget {
  const ClientNavbar({super.key});

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      navBarHeight: 84,
      tabs: [
        PersistentTabConfig(
          screen: const HomePage(),
          item: ItemConfig(
            activeForegroundColor: AppColors.black,
            inactiveForegroundColor: AppColors.black,
            inactiveIcon:
                SvgPicture.asset('assets/svg/home-outline.svg', width: 24),
            icon: SvgPicture.asset('assets/svg/home-outline-active.svg',
                width: 24),
            title: "Главная",
          ),
        ),
        // TODO: Block page
        // PersistentTabConfig(
        //   screen: const HomePage(),
        //   item: ItemConfig(
        //     icon: SvgPicture.asset('assets/svg/charity.svg', width: 24),
        //     title: "Блог",
        //   ),
        // ),
        PersistentTabConfig(
          screen: const BasketPage(),
          item: ItemConfig(
            activeForegroundColor: AppColors.black,
            inactiveForegroundColor: AppColors.black,
            inactiveIcon: SvgPicture.asset('assets/svg/cart.svg', width: 24),
            icon: SvgPicture.asset('assets/svg/cart-active.svg', width: 24),
            title: "Корзина",
          ),
        ),
        PersistentTabConfig(
          screen: const ProfilePage(),
          item: ItemConfig(
            activeForegroundColor: AppColors.black,
            inactiveForegroundColor: AppColors.black,
            icon: SvgPicture.asset('assets/svg/account-active.svg', width: 24),
            inactiveIcon: SvgPicture.asset('assets/svg/account.svg', width: 24),
            title: "Профиль",
          ),
        ),
      ],
      navBarBuilder: (navBarConfig) => Style1BottomNavBar(
        navBarConfig: navBarConfig,
        navBarDecoration: const NavBarDecoration(
          border: Border(
            top: BorderSide(width: 1, color: AppColors.grey),
          ),
          padding: EdgeInsets.fromLTRB(16, 16, 16, 28),
        ),
      ),
    );
  }
}
