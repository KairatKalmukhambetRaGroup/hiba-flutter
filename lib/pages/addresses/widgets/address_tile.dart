// lib/pages/addresses/addresses_library.dart
part of '../addresses_library.dart';

/// `AddressTile` is a stateless widget that represents an individual address item in
/// the address list. It provides options to view or edit an address.
///
/// ### Features:
/// - Displays the address name and info.
/// - Allows the user to edit the address by navigating to the `NewAddressPage` with
///   the current address data pre-filled.
///
/// ### Usage:
/// - Used within `AddressesPage` to render each address as a list item.
/// - If the address is of type 'work' or 'home', specific labels like 'Работа' (Work)
///   or 'Дом' (Home) are displayed for user-friendly representation.
class AddressTile extends StatelessWidget {
  ///  The [Address] object to be displayed within the tile.
  final Address address;
  final Function() onNavigate;
  AddressTile({super.key, required this.address, required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      leading: Address.getIconByType(address.name),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            address.name == 'work'
                ? 'Работа'
                : address.name == 'home'
                    ? 'Дом'
                    : address.name,
            style: AppTheme.black500_14,
          ),
          const SizedBox(height: 4),
          Text(
            address.info,
            style: AppTheme.darkGrey500_11,
          ),
        ],
      ),
      trailing: IconButton(
        padding: EdgeInsets.zero,
        iconSize: 24,
        icon: SvgPicture.asset(
          'assets/svg/pencil-outline.svg',
          width: 24,
        ),
        onPressed: () {
          pushWithoutNavBar(
            context,
            MaterialPageRoute(
              fullscreenDialog: true,
              builder: (context) => NewAddressPage(
                editAddress: address,
              ),
            ),
          ).then((value) {
            if (value == true) {
              onNavigate();
            }
          });
        },
      ),
    );
  }
}
