// lib/pages/addresses/addresses_library.dart
part of 'addresses_library.dart';

/// `AddressesPage` is a stateful widget that displays a list of user addresses,
/// allowing the user to view and select an address, or add a new one.
///
/// ### Structure:
/// - `_addresses`: Stores a list of `Address` objects to be displayed in the UI.
/// - `_loading`: A flag to indicate if the addresses are still loading.
/// - `loadAddresses`: An asynchronous method that retrieves the list of addresses
///   from the backend and updates `_addresses`.
///
/// ### Features:
/// - Retrieves and displays user addresses on the screen.
/// - Shows a loading indicator while fetching data.
/// - Displays a "No data" message if no addresses are available.
/// - Provides an option to add a new address, which opens the `NewAddressPage`.
///
/// ### Usage:
/// - This widget relies on [Provider] to update and display the addresses list,
///   as well as to set the currently selected address.
///
/// ### Bottom Navigation:
/// - Contains a `TextButton` at the bottom, enabling the user to add a new address.
///   After adding, it refreshes the list of addresses.
class AddressesPage extends StatefulWidget {
  const AddressesPage({super.key});

  @override
  State<StatefulWidget> createState() => _AddressesPageState();
}

class _AddressesPageState extends State<AddressesPage> {
  List<Address> _addresses = [];

  bool _loading = true;

  @override
  void initState() {
    loadAddresses();
    super.initState();
  }

  /// Loads the list of addresses asynchronously from a backend service.
  /// Updates `_addresses` with the retrieved data and refreshes the UI.
  Future<void> loadAddresses() async {
    setState(() {
      _loading = true;
    });
    final data = await getAddresses();

    if (data != null) {
      setState(() {
        _addresses = data;
      });
    }
    setState(() {
      _loading = false;
    });
  }

  /// Refreshes the addresses by reloading them.
  void refresh() async {
    await loadAddresses();
  }

  @override
  Widget build(BuildContext context) {
    AddressState addressState =
        Provider.of<AddressState>(context, listen: true);
    if (addressState.addresses.isEmpty && _addresses.isNotEmpty) {
      addressState.setAddresses(_addresses);
    }
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CustomAppBar(
        titleText: 'Мои адреса',
        context: context,
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 8.0),
        child: _loading
            ? const Center(child: CircularProgressIndicator())
            : _addresses.isEmpty
                ? const Center(
                    child: Text('Нет данных', style: AppTheme.blue500_16),
                  )
                : ListView.separated(
                    itemBuilder: (context, index) {
                      return AddressTile(
                          address: _addresses[index],
                          onNavigate: () {
                            refresh();
                          });
                    },
                    itemCount: _addresses.length,
                    separatorBuilder: (context, index) =>
                        const Divider(height: 1, color: AppColors.grey),
                  ),
      ),
      bottomNavigationBar: ListTile(
        contentPadding: const EdgeInsets.all(16),
        title: TextButton(
          onPressed: () {
            pushWithoutNavBar(context,
                    MaterialPageRoute(builder: (context) => NewAddressPage()))
                .then((value) {
              if (value == true) {
                refresh();
              }
            });
          },
          style: ButtonStyle(
            backgroundColor:
                const WidgetStatePropertyAll<Color>(AppColors.mainBlue),
            shape: WidgetStatePropertyAll<RoundedRectangleBorder>(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
            minimumSize: const WidgetStatePropertyAll(Size.fromHeight(48)),
          ),
          child: const Text(
            'Добавить адресс',
            style: AppTheme.white500_16,
          ),
        ),
      ),
    );
  }
}
