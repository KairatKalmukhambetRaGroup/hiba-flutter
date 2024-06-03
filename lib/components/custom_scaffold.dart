import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hiba/pages/login_page.dart';
import 'package:hiba/providers/navigation_bar_state.dart';
import 'package:hiba/providers/shopping_basket.dart';
import 'package:hiba/utils/api/auth.dart';
import 'package:hiba/values/app_colors.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class CustomScaffold extends StatefulWidget {
  final Widget body;
  Color? backgroundColor;
  PreferredSizeWidget? appBar;

  CustomScaffold(
      {super.key, required this.body, this.backgroundColor, this.appBar});

  @override
  State<CustomScaffold> createState() => _CustomScaffoldState();
}

class _CustomScaffoldState extends State<CustomScaffold> {
  bool loading = true;
  bool isUserLoggedIn = false;
  @override
  void initState() {
    super.initState();
    
  }

  final List<String> routes = ['/','/basket','/profile'];

  @override
  void dispose() {
    super.dispose();
  }

  void getUser() async {
    if (!mounted) return;
    setState(() {
      loading = true;
    });
    AuthState authState = Provider.of<AuthState>(context, listen: true);
    await authState.getUserData();
    if (!mounted) return;
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    AuthState authState = Provider.of<AuthState>(context, listen: true);
    ShoppingBasket shoppingBasket =
        Provider.of<ShoppingBasket>(context, listen: false);
    NavigationBarState navigationBarState =
        Provider.of<NavigationBarState>(context, listen: false);
    if (loading) {
      getUser();
    }
    bool isBasketEmpty() => shoppingBasket.items.isEmpty;

    return Scaffold(
      backgroundColor: widget.backgroundColor,
      appBar: widget.appBar,
      bottomNavigationBar: (loading || !authState.isLoggedIn)
          ? null
          : NavigationBar(
              onDestinationSelected: (int index) {
                String? currentRounte = ModalRoute.of(context)?.settings.name;
                navigationBarState.setCurrentPageIndex(index);

                if(currentRounte == null || currentRounte != routes[index]){
                  Navigator.of(context).pushReplacementNamed(routes[index]);
                }
              },
              selectedIndex: navigationBarState.currentPageIndex,
              backgroundColor: AppColors.white,
              elevation: 0,
              indicatorColor: Colors.transparent,
              indicatorShape: null,
              destinations: [
                NavigationDestination(
                  selectedIcon: SvgPicture.asset(
                      'assets/svg/home-outline-active.svg',
                      width: 24),
                  icon: SvgPicture.asset('assets/svg/home-outline.svg',
                      width: 24),
                  label: 'Главная',
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
                  label: 'Корзина',
                ),
                NavigationDestination(
                  selectedIcon: SvgPicture.asset(
                      'assets/svg/account-active.svg',
                      width: 24),
                  icon: SvgPicture.asset('assets/svg/account.svg', width: 24),
                  label: 'Профиль',
                ),
              ],
            ),
      body: loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : authState.isLoggedIn
              ? widget.body
              : const LoginPage(),
    );
  }
}
