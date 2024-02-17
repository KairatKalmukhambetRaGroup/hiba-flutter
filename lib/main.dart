import 'package:flutter/material.dart';
import 'package:hiba/fluro_routes.dart';
import 'package:hiba/home.dart';
// import 'package:hiba/home.dart';
// import 'package:hiba/pages/login_page.dart';
import 'package:hiba/utils/helpers/navigation_helper.dart';
import 'package:hiba/utils/helpers/snackbar_helper.dart';
import 'package:hiba/values/app_strings.dart';
import 'package:hiba/values/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FluroRoutes.setupRouter();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppStrings.loginAndRegister,
      theme: AppTheme.themeData,
      // home: const LoginPage(),
      home: const Home(),
      // initialRoute: '/',
      scaffoldMessengerKey: SnackbarHelper.key,
      navigatorKey: NavigationHelper.key,
      onGenerateRoute: FluroRoutes.router.generator,
    );
  }
}
