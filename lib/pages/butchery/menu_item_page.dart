import 'package:flutter/material.dart';
import 'package:hiba/entities/menu_item.dart';
import 'package:hiba/values/app_colors.dart';
import 'package:hiba/values/app_theme.dart';

class MenuItemPage extends StatefulWidget {
  // static const routeName = '/butchery/menu';

  final MenuItem menuItem;
  const MenuItemPage({super.key, required this.menuItem});

  @override
  State<StatefulWidget> createState() => _MenuItemPageState();
}

class _MenuItemPageState extends State<MenuItemPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgLight,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        shape:
            const Border(bottom: BorderSide(color: AppColors.grey, width: 1)),
        title: Text(
          widget.menuItem.name,
          style: AppTheme.headingBlack600_16,
        ),
        centerTitle: true,
      ),
    );
  }
}
