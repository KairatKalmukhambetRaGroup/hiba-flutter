part of '../core_library.dart';

/// The initial screen of the app, handling user authentication and navigation.
///
/// The [SplashPage] determines the user's authentication status and navigates
/// to the appropriate screen:
/// - If the user is connected and logged in:
///   - Navigates to the client UI ([ClientNavbar]) if the user is in client mode.
///   - Navigates to the courier UI ([CourierNavbar]) if the user is in courier mode.
/// - If the user is connected but not logged in:
///   - Navigates to the [LoginPage].
/// - If the user is not connected:
///   - Displays a splash screen image.
///
/// This page is typically displayed when the app is first launched to handle
/// initial setup and redirection.
class SplashPage extends StatefulWidget {
  /// Creates a [SplashPage].
  const SplashPage({super.key});

  @override
  State<StatefulWidget> createState() => _SplashPageState();
}

/// The state class for [SplashPage].
///
/// Manages the initialization and navigation logic based on the user's
/// authentication and connection status.
class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
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
