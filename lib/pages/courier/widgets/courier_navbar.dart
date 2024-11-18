part of '../courier_library.dart';

/// A bottom navigation bar for the courier application.
///
/// The [CourierNavbar] provides navigation between the main screens of the courier
/// interface: Active Deliveries, Delivery Requests, Notifications, and Profile.
///
/// ### Example Usage
/// ```dart
/// Scaffold(
///   body: const CourierNavbar(),
/// );
/// ```
class CourierNavbar extends StatelessWidget {
  const CourierNavbar({super.key});

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      navBarHeight: 84,
      tabs: [
        PersistentTabConfig(
          screen: const ActiveDeliveries(),
          item: ItemConfig(
            activeForegroundColor: AppColors.black,
            inactiveForegroundColor: AppColors.black,
            icon: SvgPicture.asset('assets/svg/bookmark-active.svg', width: 24),
            inactiveIcon:
                SvgPicture.asset('assets/svg/bookmark.svg', width: 24),
            title: "Активные",
          ),
        ),
        PersistentTabConfig(
          screen: const Deliveries(),
          item: ItemConfig(
            activeForegroundColor: AppColors.black,
            inactiveForegroundColor: AppColors.black,
            inactiveIcon:
                SvgPicture.asset('assets/svg/file-plus.svg', width: 24),
            icon:
                SvgPicture.asset('assets/svg/file-plus-active.svg', width: 24),
            title: "Заявки",
          ),
        ),
        PersistentTabConfig(
          screen: const CourierNotifications(),
          item: ItemConfig(
            activeForegroundColor: AppColors.black,
            inactiveForegroundColor: AppColors.black,
            inactiveIcon: SvgPicture.asset('assets/svg/notifs.svg', width: 24),
            icon: SvgPicture.asset('assets/svg/notifs-active.svg', width: 24),
            title: "Уведомления",
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
