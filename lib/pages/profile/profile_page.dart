// lib/pages/profile/profile_library.dart
part of 'profile_library.dart';

/// A page displaying the user's profile information.
///
/// The [ProfilePage] presents the user's avatar, name, and various profile options
/// such as viewing orders, addresses, switching between client and courier modes,
/// and logging out. It adapts its content based on the user's role (client or courier).
///
/// ### Example Usage
/// ```dart
/// Navigator.push(
///   context,
///   MaterialPageRoute(
///     builder: (context) => const ProfilePage(),
///   ),
/// );
/// ```
class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<StatefulWidget> createState() => _ProfilePageState();
}

/// The state class for [ProfilePage].
///
/// Manages user data retrieval and navigation to profile-related pages.
class _ProfilePageState extends State<ProfilePage> {
  /// The current user.
  User? user;

  @override
  Widget build(BuildContext context) {
    AuthState authState = Provider.of<AuthState>(context, listen: true);
    user ??= authState.user;

    return CustomScaffold(
      backgroundColor: AppColors.bgLight,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: AppColors.white,
                        backgroundImage: user!.avatar != null
                            ? MemoryImage(base64Decode(user!.avatar!))
                            : const AssetImage('assets/images/avatar.png')
                                as ImageProvider,
                      ),
                      const SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user!.name,
                            style: AppTheme.blue600_16,
                          ),
                          const Text(
                            'Мои данные',
                            style: TextStyle(
                              color: AppColors.darkGrey,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  IconButton(
                    icon: Transform.flip(
                      flipX: true,
                      child: SvgPicture.asset(
                        'assets/svg/chevron-left.svg',
                        width: 24,
                      ),
                    ),
                    onPressed: () {
                      pushWithoutNavBar(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const UserInfoPage()));
                    },
                  ),
                ],
              ),
            ),
            if (authState.isClientUI)
              ListTile(
                shape: const BorderDirectional(
                    bottom: BorderSide(
                  color: AppColors.grey,
                  width: 0.5,
                  style: BorderStyle.solid,
                )),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                tileColor: AppColors.white,
                leading: SvgPicture.asset(
                  'assets/svg/orders.svg',
                  width: 24,
                ),
                title: const Text('Мои заказы', style: AppTheme.black500_14),
                trailing: SvgPicture.asset(
                  'assets/svg/chevron-right-grey.svg',
                  width: 24,
                ),
                onTap: () {
                  pushWithNavBar(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const OrdersPage()));
                },
              ),
            if (authState.isClientUI)
              ListTile(
                shape: const BorderDirectional(
                    bottom: BorderSide(
                  color: AppColors.grey,
                  width: 0.5,
                  style: BorderStyle.solid,
                )),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                tileColor: AppColors.white,
                leading: SvgPicture.asset(
                  'assets/svg/map-marker-outline.svg',
                  width: 24,
                ),
                title: const Text('Мои адреса', style: AppTheme.black500_14),
                trailing: SvgPicture.asset(
                  'assets/svg/chevron-right-grey.svg',
                  width: 24,
                ),
                onTap: () {
                  pushWithoutNavBar(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AddressesPage()));
                },
              ),

            // ListTile(
            //   shape: const BorderDirectional(
            //       bottom: BorderSide(
            //     color: AppColors.grey,
            //     width: 0.5,
            //     style: BorderStyle.solid,
            //   )),
            //   contentPadding: const EdgeInsets.symmetric(horizontal: 16),
            //   tileColor: AppColors.white,
            //   leading: SvgPicture.asset(
            //     'assets/svg/bell-outline.svg',
            //     width: 24,
            //   ),
            //   title: const Text('Уведомления', style: AppTheme.black500_14),
            //   trailing: SvgPicture.asset(
            //     'assets/svg/chevron-right-grey.svg',
            //     width: 24,
            //   ),
            //   onTap: () {
            //     pushWithNavBar(context, MaterialPageRoute(builder: (context)=> const NotificationsPage()));
            //   },
            // ),

            if (!authState.isClientUI)
              ListTile(
                shape: const BorderDirectional(
                    bottom: BorderSide(
                  color: AppColors.grey,
                  width: 0.5,
                  style: BorderStyle.solid,
                )),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                tileColor: AppColors.white,
                leading: SvgPicture.asset(
                  'assets/svg/orders.svg',
                  width: 24,
                ),
                title:
                    const Text('История доставок', style: AppTheme.black500_14),
                trailing: SvgPicture.asset(
                  'assets/svg/chevron-right-grey.svg',
                  width: 24,
                ),
                onTap: () {
                  pushWithoutNavBar(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const DeliveryHistory()));
                },
              ),

            ListTile(
              shape: const BorderDirectional(
                  bottom: BorderSide(
                color: AppColors.grey,
                width: 0.5,
                style: BorderStyle.solid,
              )),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              tileColor: AppColors.white,
              leading: SvgPicture.asset(
                'assets/svg/phone-in-talk-outline.svg',
                width: 24,
              ),
              title:
                  const Text('Связаться с нами', style: AppTheme.black500_14),
              trailing: SvgPicture.asset(
                'assets/svg/chevron-right-grey.svg',
                width: 24,
              ),
              onTap: () {
                pushWithNavBar(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ContactUsPage()));
              },
            ),
            if (authState.isCourier && authState.isClientUI)
              ListTile(
                shape: const BorderDirectional(
                    bottom: BorderSide(
                  color: AppColors.grey,
                  width: 0.5,
                  style: BorderStyle.solid,
                )),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                tileColor: AppColors.white,
                leading: SvgPicture.asset(
                  'assets/svg/truck-delivery-outline.svg',
                  width: 24,
                ),
                title:
                    const Text('Войти как курьер', style: AppTheme.black500_14),
                onTap: () {
                  authState.changeUItoCourier();
                  Navigator.of(context).pushNamed("/");
                },
              ),
            if (authState.isCourier && !authState.isClientUI)
              ListTile(
                shape: const BorderDirectional(
                    bottom: BorderSide(
                  color: AppColors.grey,
                  width: 0.5,
                  style: BorderStyle.solid,
                )),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                tileColor: AppColors.white,
                leading: SvgPicture.asset(
                  'assets/svg/toclient.svg',
                  width: 24,
                ),
                title: const Text('Войти как покупатель',
                    style: AppTheme.black500_14),
                onTap: () {
                  authState.changeUItoClient();
                  Navigator.of(context).pushNamed("/");
                },
              ),
            ListTile(
              shape: const BorderDirectional(
                  bottom: BorderSide(
                color: AppColors.grey,
                width: 0.5,
                style: BorderStyle.solid,
              )),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              tileColor: AppColors.white,
              leading: SvgPicture.asset(
                'assets/svg/exit-to-app.svg',
                width: 24,
              ),
              title: const Text('Выйти', style: AppTheme.black500_14),
              onTap: () async {
                authState.logout();
              },
            ),
          ],
        ),
      ),
    );
  }
}
