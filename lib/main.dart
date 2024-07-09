import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hiba/pages/basket_page.dart';
import 'package:hiba/pages/courier/active_deliveries.dart';
import 'package:hiba/pages/courier/deliveries.dart';
import 'package:hiba/pages/home_page.dart';
import 'package:hiba/pages/profile/profile_page.dart';
import 'package:hiba/providers/address_state.dart';
import 'package:hiba/providers/chat_provider.dart';
import 'package:hiba/providers/navigation_bar_state.dart';
import 'package:hiba/providers/shopping_basket.dart';
import 'package:hiba/utils/helpers/navigation_helper.dart';
import 'package:hiba/utils/helpers/snackbar_helper.dart';
import 'package:hiba/values/app_colors.dart';
import 'package:hiba/values/app_strings.dart';
import 'package:hiba/values/app_theme.dart';
import 'package:hiba/utils/api/auth.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:provider/provider.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isAndroid) {
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  } else {
    // Set orientation in Info.plist for iOS (manual step)
  }

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await dotenv.load(fileName: '.env');
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => NavigationBarState()),
      ChangeNotifierProvider(create: (_) => AuthState()),
      ChangeNotifierProvider(create: (_) => ShoppingBasket()),
      ChangeNotifierProvider(create: (_) => ChatProvider()),
      ChangeNotifierProvider(create: (_) => AddressState()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    AuthState authState = Provider.of<AuthState>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppStrings.loginAndRegister,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
      ],
      supportedLocales: const [
        Locale('ru'),
        Locale('kk'),
      ],
      theme: AppTheme.themeData,
      // initialRoute: '/',
      home: authState.isClientUI
          ? PersistentTabView(
              stateManagement: false,
              tabs: [
                PersistentTabConfig(
                  screen: const HomePage(),
                  item: ItemConfig(
                    activeForegroundColor: AppColors.black,
                    inactiveForegroundColor: AppColors.black,
                    inactiveIcon: SvgPicture.asset(
                        'assets/svg/home-outline.svg',
                        width: 24),
                    icon: SvgPicture.asset('assets/svg/home-outline-active.svg',
                        width: 24),
                    title: "Главная",
                  ),
                ),
                PersistentTabConfig(
                  screen: const HomePage(),
                  item: ItemConfig(
                    icon: SvgPicture.asset('assets/svg/charity.svg', width: 24),
                    title: "Блог",
                  ),
                ),
                PersistentTabConfig(
                  screen: const BasketPage(),
                  item: ItemConfig(
                    activeForegroundColor: AppColors.black,
                    inactiveForegroundColor: AppColors.black,
                    inactiveIcon:
                        SvgPicture.asset('assets/svg/cart.svg', width: 24),
                    icon: SvgPicture.asset('assets/svg/cart-active.svg',
                        width: 24),
                    title: "Корзина",
                  ),
                ),
                PersistentTabConfig(
                  screen: const ProfilePage(),
                  item: ItemConfig(
                    activeForegroundColor: AppColors.black,
                    inactiveForegroundColor: AppColors.black,
                    icon: SvgPicture.asset('assets/svg/account-active.svg',
                        width: 24),
                    inactiveIcon: SvgPicture.asset(
                        'assets/svg/home-outline.svg',
                        width: 24),
                    title: "Профиль",
                  ),
                ),
              ],
              navBarBuilder: (navBarConfig) =>
                  Style1BottomNavBar(navBarConfig: navBarConfig),
            )
          : PersistentTabView(
              stateManagement: false,
              tabs: [
                PersistentTabConfig(
                  screen: ActiveDeliveries(),
                  item: ItemConfig(
                    activeForegroundColor: AppColors.black,
                    inactiveForegroundColor: AppColors.black,
                    icon: SvgPicture.asset('assets/svg/bookmark-active.svg',
                        width: 24),
                    inactiveIcon:
                        SvgPicture.asset('assets/svg/bookmark.svg', width: 24),
                    title: "Активные",
                  ),
                ),
                PersistentTabConfig(
                  screen: Deliveries(),
                  item: ItemConfig(
                    activeForegroundColor: AppColors.black,
                    inactiveForegroundColor: AppColors.black,
                    inactiveIcon:
                        SvgPicture.asset('assets/svg/file-plus.svg', width: 24),
                    icon: SvgPicture.asset('assets/svg/file-plus-active.svg',
                        width: 24),
                    title: "Заявки",
                  ),
                ),
                PersistentTabConfig(
                  screen: const BasketPage(),
                  item: ItemConfig(
                    activeForegroundColor: AppColors.black,
                    inactiveForegroundColor: AppColors.black,
                    inactiveIcon:
                        SvgPicture.asset('assets/svg/notifs.svg', width: 24),
                    icon: SvgPicture.asset('assets/svg/notifs-active.svg',
                        width: 24),
                    title: "Уведомления",
                  ),
                ),
                PersistentTabConfig(
                  screen: const ProfilePage(),
                  item: ItemConfig(
                    activeForegroundColor: AppColors.black,
                    inactiveForegroundColor: AppColors.black,
                    icon: SvgPicture.asset('assets/svg/account-active.svg',
                        width: 24),
                    inactiveIcon: SvgPicture.asset(
                        'assets/svg/home-outline.svg',
                        width: 24),
                    title: "Профиль",
                  ),
                ),
                // PersistentTabConfig(
                //   screen: const ProfilePage(),
                //   item: ItemConfig(
                //     activeForegroundColor: AppColors.black,
                //     inactiveForegroundColor: AppColors.black,
                //     icon:
                //         SvgPicture.asset('assets/svg/account-active.svg', width: 24),
                //     inactiveIcon:
                //         SvgPicture.asset('assets/svg/home-outline.svg', width: 24),
                //     title: "Профиль",
                //   ),
                // ),
              ],
              navBarBuilder: (navBarConfig) =>
                  Style1BottomNavBar(navBarConfig: navBarConfig),
            ),

      scaffoldMessengerKey: SnackbarHelper.key,
      navigatorKey: NavigationHelper.key,
    );
  }
}
