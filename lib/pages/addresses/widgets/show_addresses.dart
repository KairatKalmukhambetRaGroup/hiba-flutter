// lib/pages/addresses/addresses_library.dart
part of '../addresses_library.dart';

/// `ShowAddresses` is a stateful widget responsible for displaying a list
/// of user addresses in a scrollable, draggable sheet. This widget allows users
/// to view their saved addresses and select one as the current delivery address.
/// It also provides an option to add a new address.
///
/// This widget includes the following functionalities:
/// - Loading addresses asynchronously from the backend via `loadAddresses`.
/// - Refreshing the address list.
/// - Displaying a loading indicator while fetching data.
/// - Displaying each address as a `ListTile` using the `addressTile` helper method.
///
/// ### Structure:
/// - `_addresses`: Stores a list of `Address` objects to be displayed in the UI.
/// - `_sheet`: A `GlobalKey` used to reference the `DraggableScrollableSheet`.
/// - `_controller`: A `DraggableScrollableController` to control the sheet's size and position.
/// - `_loading`: A boolean flag indicating if addresses are currently being loaded.
///
/// ### Usage:
/// - Displayed in a parent container or page that requires address selection functionality.
/// - Uses `Provider` to update and retrieve the current address.
class ShowAddresses extends StatefulWidget {
  const ShowAddresses({super.key});

  @override
  State<StatefulWidget> createState() => _ShowAddressesState();
}

class _ShowAddressesState extends State<ShowAddresses> {
  final _sheet = GlobalKey();

  final _controller = DraggableScrollableController();

  List<Address> _addresses = [];

  bool _loading = true;

  @override
  void initState() {
    super.initState();
    loadAddresses();
    _controller.addListener(_onChanged);
  }

  /// Loads the list of addresses asynchronously from a backend service.
  /// Sets the `_loading` state to `true` during the loading process and `false` afterward.
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

  /// Refreshes the address list by calling `loadAddresses` again.
  void refresh() async {
    await loadAddresses();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  /// Listener method for changes in the sheet size, used to handle UI updates or animations.
  void _onChanged() {
    // ignore: unused_local_variable
    final currentSize = _controller.size;
    // if (currentSize <= 0.5) _collapse();
    // if (currentSize < 0.4) _hide();
  }

  // void _collapse() => _animateSheet(sheet.snapSizes!.first);

  // void _anchor() => _animateSheet(sheet.snapSizes!.last);

  // void _expand() => _animateSheet(sheet.maxChildSize);

  // void _hide() => _animateSheet(sheet.minChildSize);

  // void _animateSheet(double size) {
  //   _controller.animateTo(
  //     size,
  //     duration: const Duration(milliseconds: 50),
  //     curve: Curves.easeInOut,
  //   );
  // }

  /// Provides the reference to the current [DraggableScrollableSheet] widget.
  DraggableScrollableSheet get sheet =>
      (_sheet.currentWidget as DraggableScrollableSheet);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      AddressState addressState =
          Provider.of<AddressState>(context, listen: false);
      if (_addresses.isNotEmpty) {
        addressState.setAddresses(_addresses);
      }
      return DraggableScrollableSheet(
        key: _sheet,
        initialChildSize: 1,
        maxChildSize: 1,
        minChildSize: 0,
        expand: true,
        snap: true,
        // snapSizes: const [0.5],
        controller: _controller,
        builder: (BuildContext context, ScrollController scrollController) {
          return DecoratedBox(
            decoration: const BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
            child: SingleChildScrollView(
              controller: scrollController,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(
                        top: 24, left: 16, right: 16, bottom: 16),
                    child: Text(
                      'Адрес доставки',
                      style: AppTheme.black600_16,
                    ),
                  ),
                  _loading
                      ? const Center(
                          child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: CircularProgressIndicator(
                            color: AppColors.mainBlue,
                          ),
                        ))
                      : Column(
                          children: _addresses
                              .map((address) => addressTile(address))
                              .toList(),
                        ),
                  ListTile(
                    leading: SvgPicture.asset(
                      'assets/svg/plus-black.svg',
                      width: 24,
                    ),
                    title: const Text(
                      'Добавить новый адрес',
                      style: AppTheme.black600_14,
                    ),
                    onTap: () {
                      pushWithoutNavBar(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NewAddressPage()));
                    },
                  ),
                ],
              ),
            ),
          );
        },
      );
    });
  }

  /// Builds a `ListTile` widget for each address item in the `_addresses` list.
  /// Allows the user to select an address by updating the current address in `AddressState`.
  Widget addressTile(Address address) {
    AddressState addressState =
        Provider.of<AddressState>(context, listen: true);
    return ListTile(
      onTap: () {
        addressState.setCurrentAddress(address);
        Navigator.of(context).pop();
      },
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
      trailing: (addressState.currentAddress != null &&
              address.id == addressState.currentAddress!.id)
          ? IconButton(
              padding: EdgeInsets.zero,
              iconSize: 24,
              icon: SvgPicture.asset(
                'assets/svg/address-check.svg',
                width: 24,
              ),
              onPressed: () {
                pushWithoutNavBar(context,
                    MaterialPageRoute(builder: (context) => NewAddressPage()));
              },
            )
          : null,
    );
  }
}
