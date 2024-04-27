import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hiba/entities/butchery_small.dart';
import 'package:hiba/pages/butchery/butchery_page.dart';
import 'package:hiba/utils/api/butchery.dart';
import 'package:hiba/values/app_colors.dart';
import 'package:hiba/values/app_theme.dart';

class SearchPage extends StatefulWidget {
  static const routeName = '/search';

  const SearchPage({super.key, required this.charity});
  final bool charity;

  @override
  State<StatefulWidget> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<Map<String, dynamic>> _butcheries = [];
  bool isCharity = false;

  @override
  void initState() {
    super.initState();
    loadJsonData();
    setState(() {
      isCharity = widget.charity;
    });
  }

  Future<void> loadJsonData() async {
    final data = await getButcheries();
    if (data != null) {
      setState(() {
        _butcheries = data;
      });
    }
  }

  final List<String> categories = List<String>.from(['Говядина']);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgLight,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        shape:
            const Border(bottom: BorderSide(color: AppColors.grey, width: 1)),
        title: Text(
          isCharity ? 'На благотворительность' : 'Для себя и близких',
          style: AppTheme.headingBlack600_16,
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 8.0),
        child: _butcheries.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : ListView.separated(
                itemBuilder: (context, index) {
                  final butchery = ButcherySmall.fromJson(_butcheries[index]);
                  return ButcheryTile(
                    butchery: butchery,
                    isCharity: isCharity,
                  );
                },
                itemCount: _butcheries.length,
                separatorBuilder: (context, index) =>
                    const Divider(height: 1, color: AppColors.grey),
              ),
      ),
    );
  }
}

class CategoryTile extends StatelessWidget {
  const CategoryTile({super.key, required this.name, required this.route});
  final String name;
  final String route;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: AppColors.white,
      title: Text(
        name,
        style: AppTheme.bodyBlack500_14,
      ),
      trailing: SvgPicture.asset(
        'assets/svg/chevron-right-grey.svg',
        width: 24,
      ),
    );
  }
}

class ButcheryTile extends StatelessWidget {
  const ButcheryTile(
      {super.key, required this.butchery, required this.isCharity});
  final ButcherySmall butchery;
  final bool isCharity;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: AppColors.white,
      title: Text(
        butchery.name,
        style: AppTheme.bodyBlack500_14,
      ),
      // subtitle: Text(
      //   butchery.categories.join(', '),
      //   style: AppTheme.bodyDarkgrey500_11,
      // ),
      trailing: SvgPicture.asset(
        'assets/svg/chevron-right-grey.svg',
        width: 24,
      ),
      onTap: () => {
        // print(isCharity)
        Navigator.of(context).pushNamed(
            '${ButcheryPage.routeName}/${butchery.id}?charity=$isCharity')
      },
    );
  }
}
