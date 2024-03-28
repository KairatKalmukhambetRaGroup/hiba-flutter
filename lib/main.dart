import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/material.dart';
import 'package:hiba/fluro_routes.dart';
import 'package:hiba/home.dart';
import 'package:hiba/pages/login_page.dart';
import 'package:hiba/providers/shopping_basket.dart';
// import 'package:hiba/home.dart';
// import 'package:hiba/pages/login_page.dart';
import 'package:hiba/utils/helpers/navigation_helper.dart';
import 'package:hiba/utils/helpers/snackbar_helper.dart';
import 'package:hiba/values/app_strings.dart';
import 'package:hiba/values/app_theme.dart';
import 'package:hiba/utils/api/auth.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FluroRoutes.setupRouter();

  await dotenv.load(fileName: '.env');
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => AuthState()),
      ChangeNotifierProvider(create: (_) => ShoppingBasket()),
    ],
    child: const MyApp(),
  ));
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
      home: Consumer<AuthState>(
        builder: (context, authState, _) {
          authState.getUserData();
          return authState.user == null ? const LoginPage() : const Home();
        },
      ),
      // initialRoute: '/',
      scaffoldMessengerKey: SnackbarHelper.key,
      navigatorKey: NavigationHelper.key,
      onGenerateRoute: FluroRoutes.router.generator,
    );
  }
}
