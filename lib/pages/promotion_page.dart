import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hiba/components/custom_app_bar.dart';
import 'package:hiba/entities/promotion.dart';
import 'package:hiba/values/app_colors.dart';
import 'package:hiba/values/app_theme.dart';

class PromotionPage extends StatelessWidget {
  const PromotionPage({super.key, required this.promotion});
  final Promotion promotion;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgLight,
      appBar: CustomAppBar(
        context: context,
        titleText: 'Акция',
      ),
      body: ListView(
        children: [
          Image.memory(base64Decode(promotion.image)),
          const SizedBox(height: 16),
          Container(
            color: AppColors.white,
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            child: Text(
              promotion.title,
              style: AppTheme.headingBlue600_16,
            ),
          ),
          const Divider(
            height: 1,
            color: AppColors.grey,
          ),
          Container(
            color: AppColors.white,
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            child: Text(
              promotion.description,
              style: AppTheme.bodyBlack500_14,
            ),
          ),
        ],
      ),
    );
  }
}
