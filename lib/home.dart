import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hiba/pages/basket_page.dart';
import 'package:hiba/pages/home_page.dart';
import 'package:hiba/pages/profile/profile_page.dart';
import 'package:hiba/values/app_colors.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<StatefulWidget> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            _currentPageIndex = index;
          });
        },
        selectedIndex: _currentPageIndex,
        backgroundColor: AppColors.white,
        elevation: 0,
        indicatorColor: Colors.transparent,
        indicatorShape: null,
        destinations: [
          NavigationDestination(
            selectedIcon: SvgPicture.asset('assets/svg/home-outline-active.svg',
                width: 24),
            icon: SvgPicture.asset('assets/svg/home-outline.svg', width: 24),
            label: 'Главная',
          ),
          // NavigationDestination(
          //   selectedIcon:
          //       SvgPicture.asset('assets/svg/charity-active.svg', width: 24),
          //   icon: SvgPicture.asset('assets/svg/charity.svg', width: 24),
          //   label: 'Блог',
          // ),
          NavigationDestination(
            selectedIcon:
                SvgPicture.asset('assets/svg/Cart-active.svg', width: 24),
            icon: SvgPicture.asset('assets/svg/Cart.svg', width: 24),
            label: 'Корзина',
          ),
          NavigationDestination(
            selectedIcon:
                SvgPicture.asset('assets/svg/account-active.svg', width: 24),
            icon: SvgPicture.asset('assets/svg/account.svg', width: 24),
            label: 'Профиль',
          ),
        ],
      ),
      body: const <Widget>[
        HomePage(),
        BasketPage(),
        ProfilePage(),
      ][_currentPageIndex],
    );
  }
}
