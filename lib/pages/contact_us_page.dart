import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hiba/values/app_colors.dart';
import 'package:hiba/values/app_theme.dart';

class ContactUsPage extends StatelessWidget {
  static const routeName = '/contact-us';
  const ContactUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        shape:
            const Border(bottom: BorderSide(color: AppColors.grey, width: 1)),
        title: const Text(
          'Связаться с нами',
          style: AppTheme.headingBlack600_16,
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              SizedBox(
                height: 120,
                child: SvgPicture.asset(
                  '/assets/svg/contact-us-bg.svg',
                  width: 120,
                ),
              ),
              const SizedBox(height: 25),
              const Text(
                'Связаться с поддержкой',
                style: AppTheme.headingBlack600_16,
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () {},
                style: const ButtonStyle(
                  alignment: Alignment.center,
                  minimumSize: MaterialStatePropertyAll(Size.fromHeight(48)),
                  backgroundColor: MaterialStatePropertyAll(AppColors.red),
                ),
                child: const Text(
                  'Позвонить',
                  style: AppTheme.bodyWhite500_14,
                ),
              ),
              const SizedBox(height: 8),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/support-chat');
                },
                style: const ButtonStyle(
                  alignment: Alignment.center,
                  minimumSize: MaterialStatePropertyAll(Size.fromHeight(48)),
                  backgroundColor: MaterialStatePropertyAll(AppColors.mainBlue),
                ),
                child: const Text(
                  'Написать в чат',
                  style: AppTheme.bodyWhite500_14,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}