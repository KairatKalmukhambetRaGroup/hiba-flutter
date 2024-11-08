import 'package:flutter/material.dart';
import 'package:hiba/components/navbar/client_navbar.dart';
import 'package:hiba/components/navbar/courier_navbar.dart';
import 'package:hiba/pages/auth/auth_library.dart' show LoginPage;
import 'package:hiba/providers/providers_library.dart';

import 'package:hiba/utils/api/api_library.dart';
import 'package:provider/provider.dart';

/// Initial screen of app, indicates that app is loading.
class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<StatefulWidget> createState() => SplashPageState();
}

/// [SplashPage] state class
class SplashPageState extends State<SplashPage> {
  AuthState? authState;
  @override
  void initState() {
    super.initState();
    authState = Provider.of<AuthState>(context);
  }

  @override
  Widget build(BuildContext context) {
    AuthState authState = Provider.of<AuthState>(context);
    UserConnectionState userConnectionState =
        Provider.of<UserConnectionState>(context);
    userConnectionState.checkConnection();

    if (userConnectionState.connectionStatus == ConnectionStatus.connected) {
      // Check if client is loggen in.
      if (authState.isLoggedIn) {
        if (authState.isClientUI) {
          // Renavigate to Client UI.
          return const ClientNavbar();
        } else {
          // Renavigate to Courier UI.
          return const CourierNavbar();
        }
      } else {
        // Renavigate to Login page.
        return const LoginPage();
      }
    } else {
      // Show splash screen.
      return Scaffold(
        body: SizedBox(
          width: MediaQuery.sizeOf(context).width,
          height: MediaQuery.sizeOf(context).height,
          child: Image.asset(
            'assets/splash.png',
          ),
        ),
      );
    }
  }
}
