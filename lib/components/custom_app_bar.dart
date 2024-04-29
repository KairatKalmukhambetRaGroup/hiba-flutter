import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hiba/values/app_colors.dart';
import 'package:hiba/values/app_theme.dart';

class CustomAppBar extends AppBar {
  final String? titleText;
  final BuildContext context;
  CustomAppBar({super.key, this.titleText, required this.context})
      : super(
          automaticallyImplyLeading: true,
          leadingWidth: 48,
          leading: Navigator.of(context).canPop()
              ? IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: SvgPicture.asset('assets/svg/chevron-left-grey.svg'),
                )
              : null,
          backgroundColor: AppColors.white,
          title: titleText == null
              ? null
              : Text(
                  titleText,
                  style: AppTheme.headingBlack600_16,
                ),
          shape:
              const Border(bottom: BorderSide(width: 1, color: AppColors.grey)),
          centerTitle: true,
        );
}
