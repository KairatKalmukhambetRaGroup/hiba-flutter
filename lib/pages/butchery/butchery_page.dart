import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hiba/components/custom_app_bar.dart';
import 'package:hiba/entities/butchery.dart';
import 'package:hiba/entities/butchery_category.dart';
import 'package:hiba/components/menu_item_tile.dart';
import 'package:hiba/pages/butchery/butchery_details.dart';
import 'package:hiba/utils/api/butchery.dart';
import 'package:hiba/values/app_colors.dart';
import 'package:hiba/values/app_theme.dart';

class ButcheryPage extends StatefulWidget {
  static const routeName = '/butchery';

  const ButcheryPage({super.key, required this.id, required this.charity});
  final String id;
  final bool charity;

  @override
  State<StatefulWidget> createState() => _ButcherPageState();
}

class _ButcherPageState extends State<ButcheryPage> {
  bool isLoading = true;
  bool hasError = false;
  String title = '';
  late String errorMessage = '';

  late Butchery butchery;
  bool charity = false;

  @override
  void initState() {
    super.initState();
    getData();
    setState(() {
      charity = widget.charity;
    });
  }

  Map categories = {};

  getCategoryTranslations(String key) {
    switch (key) {
      case 'sheep':
        return 'Баран';
      case 'cow':
        return 'Корова';
      case 'horse':
        return 'Лошадь';
      case 'birds':
        return 'Птицы';
      default:
        return '';
    }
  }

  getData() async {
    setState(() {
      isLoading = true;
    });
    try {
      butchery = (await getButcheryById(widget.id))!;
      setState(() {
        title = butchery.name;
      });
    } catch (e) {
      errorMessage = 'error';
      hasError = true;
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgLight,
      appBar: CustomAppBar(
        titleText: title,
        context: context,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : hasError
              ? Center(
                  child: Text(errorMessage),
                )
              : ListView(
                  children: [
                    if (butchery.image != null) ...[
                      Image(
                        image: MemoryImage(base64Decode(butchery.image!)),
                        height: 200,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ],
                    const SizedBox(height: 16),
                    // info

                    ListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            fullscreenDialog: false,
                            builder: (context) =>
                                ButcheryDetails(butchery: butchery),
                          ),
                        );
                      },
                      tileColor: AppColors.white,
                      title: Text(
                        butchery.name,
                        style: AppTheme.blue600_16,
                      ),
                    ),

                    const SizedBox(height: 16),
                    Column(
                      children: List.generate(
                        butchery.categories.length,
                        (index) {
                          ButcheryCategory category =
                              butchery.categories[index];
                          return ExpansionTile(
                            backgroundColor: AppColors.white,
                            collapsedBackgroundColor: AppColors.white,
                            title: Text(
                              getCategoryTranslations(category.name),
                              style: AppTheme.blue600_16,
                            ),
                            children: List.generate(
                                category.menuItems.length,
                                (j) => MenuItemTile(
                                      menuItem: category.menuItems[j],
                                      butchery: butchery,
                                      charity: charity,
                                    )),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
    );
  }
}
