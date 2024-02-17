import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hiba/values/app_colors.dart';
import 'package:hiba/values/app_theme.dart';

class ProfilePage extends StatefulWidget {
  static const routeName = '/profile';
  const ProfilePage({super.key});

  @override
  State<StatefulWidget> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgLight,
      body: SafeArea(
        child: Column(
          children: [
            // USER INFO
            Container(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: AppColors.white,
                        backgroundImage: AssetImage('assets/images/avatar.png')
                            as ImageProvider,
                      ),
                      SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Name Surname',
                            style: AppTheme.headingBlue600_16,
                          ),
                          Text(
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
                    onPressed: () {},
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
                'assets/svg/clipboard-text-clock-outline.svg',
                width: 24,
              ),
              title: const Text('Мои заказы', style: AppTheme.bodyBlack500_14),
              trailing: SvgPicture.asset(
                'assets/svg/chevron-right-grey.svg',
                width: 24,
              ),
              onTap: () {},
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
                'assets/svg/clipboard-text-clock-outline.svg',
                width: 24,
              ),
              title: const Text('Мои адреса', style: AppTheme.bodyBlack500_14),
              trailing: SvgPicture.asset(
                'assets/svg/chevron-right-grey.svg',
                width: 24,
              ),
              onTap: () {},
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
                'assets/svg/notifications.svg',
                width: 24,
              ),
              title: const Text('Уведомления', style: AppTheme.bodyBlack500_14),
              trailing: SvgPicture.asset(
                'assets/svg/chevron-right-grey.svg',
                width: 24,
              ),
              onTap: () {},
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
                'assets/svg/phone-in-talk-outline.svg',
                width: 24,
              ),
              title: const Text('Связаться с нами',
                  style: AppTheme.bodyBlack500_14),
              trailing: SvgPicture.asset(
                'assets/svg/chevron-right-grey.svg',
                width: 24,
              ),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
