import 'package:flutter/material.dart';
import 'package:hiba/components/navbar/client_navbar.dart';
import 'package:hiba/components/navbar/courier_navbar.dart';
import 'package:hiba/pages/connection_page.dart';
import 'package:hiba/pages/home_page.dart';
import 'package:hiba/pages/login_page.dart';
import 'package:hiba/providers/user_connection_state.dart';
import 'package:hiba/utils/api/auth.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:provider/provider.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const _Splash();
  }
}

class _Splash extends StatefulWidget {
  const _Splash({super.key});

  @override
  State<StatefulWidget> createState() => _SplashState();
}

class _SplashState extends State<_Splash> {
  @override
  void initState() {
    super.initState();
  }

// userConnectionState.connectionStatus == ConnectionStatus.connected
//           ? authState.isClientUI
//               ? const ClientNavbar()
//               : const CourierNavbar()
//           : userConnectionState.connectionStatus == ConnectionStatus.loading
//               ? const ConnectionPage(connectionStatus: ConnectionStatus.loading)
//               : const ConnectionPage(
//                   connectionStatus: ConnectionStatus.disconnected),
  @override
  Widget build(BuildContext context) {
    AuthState authState = Provider.of<AuthState>(context);
    UserConnectionState userConnectionState =
        Provider.of<UserConnectionState>(context);
    userConnectionState.checkConnection();

    if (userConnectionState.connectionStatus == ConnectionStatus.connected) {
      if (authState.isLoggedIn) {
        if (authState.isClientUI) {
          return const ClientNavbar();
        } else {
          return const CourierNavbar();
        }
      } else {
        return const LoginPage();
      }
    } else {
      // Navigator.pushReplacement(
      //   context,
      //   MaterialPageRoute(
      //     builder: (ctx) => ConnectionPage(
      //       connectionStatus: userConnectionState.connectionStatus,
      //     ),
      //   ),
      // );
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
