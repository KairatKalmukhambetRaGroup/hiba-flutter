import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hiba/entities/butchery.dart';
import 'package:hiba/entities/butchery_category.dart';
import 'package:hiba/components/menu_item_tile.dart';
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
        return AppLocalizations.of(context)!.sheep;
      case 'cow':
        return AppLocalizations.of(context)!.cow;
      case 'horse':
        return AppLocalizations.of(context)!.horse;
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
      print('$e');
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
      appBar: AppBar(
        backgroundColor: AppColors.white,
        shape:
            const Border(bottom: BorderSide(color: AppColors.grey, width: 1)),
        title: Text(
          title,
          style: AppTheme.headingBlack600_16,
        ),
        centerTitle: true,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : hasError
              ? Center(
                  child: Text(errorMessage),
                )
              : ListView(
                  children: [
                    Image.network(
                      'https://picsum.photos/250?image=9',
                      width: double.infinity,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(height: 16),
                    // info
                    Column(
                      children: [
                        ListTile(
                          tileColor: AppColors.white,
                          title: Text(
                            butchery.name,
                            style: AppTheme.headingBlue600_16,
                          ),
                        ),
                        const Divider(
                          height: 1,
                          color: AppColors.grey,
                        ),
                        ExpansionTile(
                          backgroundColor: AppColors.white,
                          collapsedBackgroundColor: AppColors.white,
                          leading: SvgPicture.asset(
                            'assets/svg/food-halal.svg',
                            width: 24,
                          ),
                          title: const Text(
                            'Сертификат соответствия',
                            style: AppTheme.bodyBlack500_14,
                          ),
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 8),
                              child: Row(
                                children: [
                                  Image.asset(
                                    'assets/images/halal-certificate-mock.png',
                                    width: 120,
                                    height: 80,
                                    fit: BoxFit.cover,
                                  ),
                                  const SizedBox(width: 8),
                                  Image.asset(
                                    'assets/images/halal-certificate-mock.png',
                                    width: 120,
                                    height: 80,
                                    fit: BoxFit.cover,
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        const Divider(
                          height: 1,
                          color: AppColors.grey,
                        ),
                        ListTile(
                          tileColor: AppColors.white,
                          title: Text(
                            butchery.address,
                            style: AppTheme.bodyBlack500_14,
                          ),
                          leading: SvgPicture.asset(
                            'assets/svg/location.svg',
                            width: 24,
                          ),
                        ),
                        const Divider(
                          height: 1,
                          color: AppColors.grey,
                        ),
                        ListTile(
                          tileColor: AppColors.white,
                          title: Text(
                            '+7 (777) 123 4567',
                            style: AppTheme.bodyBlack500_14,
                          ),
                          leading: SvgPicture.asset(
                            'assets/svg/phone.svg',
                            width: 24,
                          ),
                        ),
                        const Divider(
                          height: 1,
                          color: AppColors.grey,
                        ),
                        ListTile(
                          tileColor: AppColors.white,
                          title: Text(
                            'Доставка в течении 3 дней',
                            style: AppTheme.bodyBlack500_14,
                          ),
                          leading: SvgPicture.asset(
                            'assets/svg/moped-outline.svg',
                            width: 24,
                          ),
                        ),
                        const Divider(
                          height: 1,
                          color: AppColors.grey,
                        ),
                        ExpansionTile(
                          backgroundColor: AppColors.white,
                          collapsedBackgroundColor: AppColors.white,
                          leading: SvgPicture.asset(
                            'assets/svg/clock-outline.svg',
                            width: 24,
                          ),
                          title: const Text(
                            '09:00 - 22:00',
                            style: AppTheme.bodyBlack500_14,
                          ),
                          children: const [
                            ListTile(
                              title: Text(
                                'Будние дни',
                                style: AppTheme.bodyBlack500_14,
                              ),
                              trailing: Text(
                                '09:00 - 22:00',
                                style: AppTheme.bodyBlack500_14,
                              ),
                            ),
                            Divider(
                              height: 1,
                              color: AppColors.grey,
                            ),
                            ListTile(
                              title: Text(
                                'Суббота',
                                style: AppTheme.bodyBlack500_14,
                              ),
                              trailing: Text(
                                '09:00 - 18:00',
                                style: AppTheme.bodyBlack500_14,
                              ),
                            ),
                            Divider(
                              height: 1,
                              color: AppColors.grey,
                            ),
                            ListTile(
                              title: Text(
                                'Воскресенье',
                                style: AppTheme.bodyBlack500_14,
                              ),
                              trailing: Text(
                                'выходной',
                                style: AppTheme.bodyBlack500_14,
                              ),
                            ),
                          ],
                        ),
                      ],
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
                              style: AppTheme.headingBlue600_16,
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
                    // ListView.separated(
                    //   itemBuilder: (context, index) {
                    //     return Text('f');
                    //   },
                    //   separatorBuilder: (context, index) =>
                    //       const SizedBox(height: 8),
                    //   itemCount: 2,
                    // ),
                    // ListView.separated(
                    //   itemBuilder: (context, index) {
                    //     ButcheryCategory? category =
                    //         butchery?.categories[index];
                    //     if (category == null) return Text('non');
                    //     return ExpansionTile(
                    //       backgroundColor: AppColors.white,
                    //       collapsedBackgroundColor: AppColors.white,
                    //       title: Text(
                    //         '${category.name}',
                    //         style: AppTheme.headingBlue600_16,
                    //       ),
                    //       children: [
                    //         MenuItem(),
                    //         MenuItem(),
                    //         MenuItem(),
                    //         MenuItem(),
                    //       ],
                    //     );
                    //     // return ButcheryTile(butchery: butchery);
                    //   },
                    //   itemCount: butchery!.categories.length,
                    //   separatorBuilder: (context, index) =>
                    //       const SizedBox(height: 8),
                    // ),

                    // const Column(
                    //   children: [
                    //     ExpansionTile(
                    //       backgroundColor: AppColors.white,
                    //       collapsedBackgroundColor: AppColors.white,
                    //       title: Text(
                    //         'Конина',
                    //         style: AppTheme.headingBlue600_16,
                    //       ),
                    //       children: [
                    //         MenuItemTile(),
                    //         MenuItemTile(),
                    //         MenuItemTile(),
                    //         MenuItemTile(),
                    //       ],
                    //     ),
                    //     SizedBox(height: 8),
                    //     ExpansionTile(
                    //       backgroundColor: AppColors.white,
                    //       collapsedBackgroundColor: AppColors.white,
                    //       title: Text(
                    //         'Говядина',
                    //         style: AppTheme.headingBlue600_16,
                    //       ),
                    //       children: [
                    //         MenuItemTile(),
                    //         MenuItemTile(),
                    //         MenuItemTile(),
                    //         MenuItemTile(),
                    //       ],
                    //     ),
                    //   ],
                    // )
                  ],
                ),
    );
  }
}
