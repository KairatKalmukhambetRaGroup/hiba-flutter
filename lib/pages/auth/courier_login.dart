/// lib/pages/auth/auth_library.dart
part of 'auth_library.dart';

/// A page for couriers to log in and switch between courier and client interfaces.
///
/// The [CourierLogin] page is accessible only to users registered as couriers
/// through the admin panel. It allows couriers to:
/// - Switch to the client UI for shopping.
/// - Remain in the courier UI for deliveries.
///
/// ### Example Usage
/// ```dart
/// Navigator.push(
///   context,
///   MaterialPageRoute(
///     builder: (context) => const CourierLogin(),
///   ),
/// );
/// ```
class CourierLogin extends StatelessWidget {
  const CourierLogin({super.key});

  @override
  Widget build(BuildContext context) {
    AuthState authState = Provider.of<AuthState>(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              const SizedBox(height: 80),
              SvgPicture.asset(
                'assets/svg/logo-text-small.svg',
                height: 24,
              ),
              const SizedBox(height: 128),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      authState.changeUItoClient();
                      Navigator.of(context).pushNamed("/");
                    },
                    child: Column(
                      children: [
                        SvgPicture.asset(
                          'assets/svg/clientchoose.svg',
                          height: 120,
                        ),
                        const SizedBox(height: 12),
                        const Text('Я - Покупатель',
                            style: AppTheme.black500_14)
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  InkWell(
                    onTap: () {
                      authState.changeUItoCourier();
                      Navigator.of(context).pushNamed("/");
                    },
                    child: Column(
                      children: [
                        SvgPicture.asset(
                          'assets/svg/courierchoose.svg',
                          height: 120,
                        ),
                        const SizedBox(height: 12),
                        const Text('Я - Курьер', style: AppTheme.black500_14)
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
