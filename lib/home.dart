import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hiba/pages/basket_page.dart';
import 'package:hiba/pages/home_page.dart';
import 'package:hiba/pages/profile/profile_page.dart';
import 'package:hiba/providers/shopping_basket.dart';
import 'package:hiba/values/app_colors.dart';
import 'package:provider/provider.dart';

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
    final shoppingBasket = Provider.of<ShoppingBasket>(context, listen: false);

    bool isBasketEmpty() => shoppingBasket.items.isEmpty;

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
            label: AppLocalizations.of(context)!.navbarHome,
          ),
          // NavigationDestination(
          //   selectedIcon:
          //       SvgPicture.asset('assets/svg/charity-active.svg', width: 24),
          //   icon: SvgPicture.asset('assets/svg/charity.svg', width: 24),
          //   label: AppLocalizations.of(context)!.navbarBlog,
          // ),
          NavigationDestination(
            selectedIcon:
                SvgPicture.asset('assets/svg/cart-active.svg', width: 24),
            icon: isBasketEmpty()
                ? SvgPicture.asset('assets/svg/cart.svg', width: 24)
                : SvgPicture.asset('assets/svg/cart-full.svg', width: 24),
            label: AppLocalizations.of(context)!.navbarBasket,
          ),
          NavigationDestination(
            selectedIcon:
                SvgPicture.asset('assets/svg/account-active.svg', width: 24),
            icon: SvgPicture.asset('assets/svg/account.svg', width: 24),
            label: AppLocalizations.of(context)!.navbarProfile,
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
