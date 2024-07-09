import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hiba/components/custom_scaffold.dart';
import 'package:hiba/entities/user.dart';
import 'package:hiba/pages/contact_us_page.dart';
import 'package:hiba/pages/profile/addresses_page.dart';
import 'package:hiba/pages/orders/orders_page.dart';
import 'package:hiba/pages/profile/user_info_page.dart';
import 'package:hiba/values/app_colors.dart';
import 'package:hiba/values/app_theme.dart';

import 'package:hiba/utils/api/auth.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  static const routeName = '/profile';
  const ProfilePage({super.key});

  @override
  State<StatefulWidget> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  User? user;

  @override
  Widget build(BuildContext context) {
    AuthState authState = Provider.of<AuthState>(context, listen: true);
    user ??= authState.user;

    return CustomScaffold(
      backgroundColor: AppColors.bgLight,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: AppColors.white,
                        backgroundImage: user!.avatar != null
                            ? MemoryImage(base64Decode(user!.avatar!))
                            : const AssetImage('assets/images/avatar.png')
                                as ImageProvider,
                      ),
                      const SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user!.name,
                            style: AppTheme.headingBlue600_16,
                          ),
                          const Text(
                            'Мои данные',
                            style: TextStyle(
                              color: AppColors.darkGrey,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  IconButton(
                    icon: Transform.flip(
                      flipX: true,
                      child: SvgPicture.asset(
                        'assets/svg/chevron-left.svg',
                        width: 24,
                      ),
                    ),
                    onPressed: () {
                      pushWithoutNavBar(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const UserInfoPage()));
                    },
                  ),
                ],
              ),
            ),
            ListTile(
              shape: const BorderDirectional(
                  bottom: BorderSide(
                color: AppColors.grey,
                width: 0.5,
                style: BorderStyle.solid,
              )),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              tileColor: AppColors.white,
              leading: SvgPicture.asset(
                'assets/svg/orders.svg',
                width: 24,
              ),
              title: const Text('Мои заказы', style: AppTheme.bodyBlack500_14),
              trailing: SvgPicture.asset(
                'assets/svg/chevron-right-grey.svg',
                width: 24,
              ),
              onTap: () {
                pushWithoutNavBar(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const OrdersPage()));
              },
            ),
            ListTile(
              shape: const BorderDirectional(
                  bottom: BorderSide(
                color: AppColors.grey,
                width: 0.5,
                style: BorderStyle.solid,
              )),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              tileColor: AppColors.white,
              leading: SvgPicture.asset(
                'assets/svg/map-marker-outline.svg',
                width: 24,
              ),
              title: const Text('Мои адреса', style: AppTheme.bodyBlack500_14),
              trailing: SvgPicture.asset(
                'assets/svg/chevron-right-grey.svg',
                width: 24,
              ),
              onTap: () {
                pushWithoutNavBar(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AddressesPage()));
              },
            ),

            // ListTile(
            //   shape: const BorderDirectional(
            //       bottom: BorderSide(
            //     color: AppColors.grey,
            //     width: 0.5,
            //     style: BorderStyle.solid,
            //   )),
            //   contentPadding: const EdgeInsets.symmetric(horizontal: 16),
            //   tileColor: AppColors.white,
            //   leading: SvgPicture.asset(
            //     'assets/svg/bell-outline.svg',
            //     width: 24,
            //   ),
            //   title: const Text('Уведомления', style: AppTheme.bodyBlack500_14),
            //   trailing: SvgPicture.asset(
            //     'assets/svg/chevron-right-grey.svg',
            //     width: 24,
            //   ),
            //   onTap: () {
            //     pushWithNavBar(context, MaterialPageRoute(builder: (context)=> const NotificationsPage()));
            //   },
            // ),

            ListTile(
              shape: const BorderDirectional(
                  bottom: BorderSide(
                color: AppColors.grey,
                width: 0.5,
                style: BorderStyle.solid,
              )),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              tileColor: AppColors.white,
              leading: SvgPicture.asset(
                'assets/svg/phone-in-talk-outline.svg',
                width: 24,
              ),
              title: const Text('Связаться с нами',
                  style: AppTheme.bodyBlack500_14),
              trailing: SvgPicture.asset(
                'assets/svg/chevron-right-grey.svg',
                width: 24,
              ),
              onTap: () {
                pushWithNavBar(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ContactUsPage()));
              },
            ),
            // if (authState.isCourier && authState.isClientUI)
            ListTile(
              shape: const BorderDirectional(
                  bottom: BorderSide(
                color: AppColors.grey,
                width: 0.5,
                style: BorderStyle.solid,
              )),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              tileColor: AppColors.white,
              leading: SvgPicture.asset(
                'assets/svg/truck-delivery-outline.svg',
                width: 24,
              ),
              title: const Text('Войти как курьер',
                  style: AppTheme.bodyBlack500_14),
              onTap: () {
                authState.changeUItoCourier();
                Navigator.of(context).pushNamed("/");
              },
            ),
            ListTile(
              shape: const BorderDirectional(
                  bottom: BorderSide(
                color: AppColors.grey,
                width: 0.5,
                style: BorderStyle.solid,
              )),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              tileColor: AppColors.white,
              leading: SvgPicture.asset(
                'assets/svg/exit-to-app.svg',
                width: 24,
              ),
              title: const Text('Выйти', style: AppTheme.bodyBlack500_14),
              onTap: () async {
                authState.logout();
              },
            ),
          ],
        ),
      ),
    );
  }
}
