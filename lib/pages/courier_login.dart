import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hiba/utils/api/auth.dart';
import 'package:hiba/values/app_theme.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:provider/provider.dart';

class CourierLogin extends StatelessWidget {
  const CourierLogin({super.key});

  @override
  Widget build(BuildContext context) {
    AuthState authState = Provider.of<AuthState>(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              const SizedBox(height: 80),
              SvgPicture.asset(
                'assets/svg/logo-text-small.svg',
                height: 24,
              ),
              const SizedBox(height: 128),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      authState.changeUItoClient();
                      Navigator.of(context).pushNamed("/");
                    },
                    child: Column(
                      children: [
                        SvgPicture.asset(
                          'assets/svg/clientchoose.svg',
                          height: 120,
                        ),
                        const SizedBox(height: 12),
                        const Text('Я - Покупатель',
                            style: AppTheme.bodyBlack500_14)
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  InkWell(
                    onTap: () {
                      authState.changeUItoCourier();
                      Navigator.of(context).pushNamed("/");
                    },
                    child: Column(
                      children: [
                        SvgPicture.asset(
                          'assets/svg/courierchoose.svg',
                          height: 120,
                        ),
                        const SizedBox(height: 12),
                        const Text('Я - Курьер',
                            style: AppTheme.bodyBlack500_14)
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
