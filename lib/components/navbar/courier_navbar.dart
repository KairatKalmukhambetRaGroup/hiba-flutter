import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hiba/pages/courier/courier_notifications.dart';
import 'package:hiba/pages/courier/deliveries.dart';
import 'package:hiba/pages/profile/profile_page.dart';
import 'package:hiba/values/app_colors.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class CourierNavbar extends StatelessWidget {
  const CourierNavbar({super.key});

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      navBarHeight: 84,
      stateManagement: false,
      tabs: [
        PersistentTabConfig(
          screen: const Deliveries(isActive: true),
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
          screen: const Deliveries(isActive: false),
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
