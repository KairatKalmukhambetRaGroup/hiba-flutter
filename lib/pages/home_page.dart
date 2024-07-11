import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hiba/components/active_orders.dart';
import 'package:hiba/components/custom_scaffold.dart';
import 'package:hiba/components/promotion_carousel.dart';
import 'package:hiba/components/show_addresses.dart';
import 'package:hiba/pages/butchery/search_page.dart';
import 'package:hiba/providers/address_state.dart';
import 'package:hiba/values/app_colors.dart';
import 'package:hiba/values/app_theme.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  static const routeName = '/';
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // AuthState authState = Provider.of<AuthState>(context);
    // User? user = authState.user;

    AddressState addressState =
        Provider.of<AddressState>(context, listen: true);

    // if (addressState.currentAddress == null) {
    //   addressState.openHomeAddresses();
    // }

    return CustomScaffold(
      backgroundColor: AppColors.bgLight,
      body: SafeArea(
        child: ListView(
          children: [
            ListTile(
              tileColor: AppColors.white,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SvgPicture.asset(
                    'assets/svg/location.svg',
                    width: 24,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    addressState.currentAddress == null
                        ? 'Выберите адрес'
                        : addressState.currentAddress!.city.name,
                    style: AppTheme.black500_14,
                  ),
                ],
              ),
              trailing: SvgPicture.asset(
                'assets/svg/chevron-right-grey.svg',
                width: 24,
              ),
              onTap: () {
                showModalBottomSheet(
                  isDismissible: true,
                  backgroundColor: Colors.transparent,
                  // isScrollControlled: true,
                  context: context,
                  builder: (context) {
                    return const ShowAddresses();
                  },
                );
              },
            ),
            const PromotionCarousel(),
            const ActiveOrders(),
            ListTile(
              contentPadding: const EdgeInsets.all(16),
              tileColor: AppColors.white,
              title: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      'С HIBA легко заказать домой свежее постное мясо и делать благие дела',
                      style: AppTheme.black600_14,
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      pushWithNavBar(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const SearchPage(charity: true)));
                    },
                    style: const ButtonStyle(
                      alignment: Alignment.center,
                      minimumSize: WidgetStatePropertyAll(Size.fromHeight(48)),
                      backgroundColor: WidgetStatePropertyAll(AppColors.red),
                    ),
                    child: const Text(
                      'На благотворительность',
                      style: AppTheme.white500_14,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextButton(
                    onPressed: () {
                      pushWithNavBar(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const SearchPage(charity: false)));
                    },
                    style: const ButtonStyle(
                      alignment: Alignment.center,
                      minimumSize: WidgetStatePropertyAll(Size.fromHeight(48)),
                      backgroundColor:
                          WidgetStatePropertyAll(AppColors.mainBlue),
                    ),
                    child: const Text(
                      'Для себя или близких',
                      style: AppTheme.white500_14,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
