part of '../core_library.dart';

/// A navigation bar for the client side of the application.
///
/// The [ClientNavbar] widget uses [PersistentTabView] to create a bottom navigation bar with three tabs: Home, Basket, and Profile.
/// Each tab displays a different screen corresponding to the user's selection.
///
/// {@category Core}
/// ## Example Usage
/// ```dart
/// ClientNavbar();
/// ```
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
