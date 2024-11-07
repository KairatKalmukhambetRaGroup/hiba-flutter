import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hiba/entities/address.dart';
import 'package:hiba/pages/profile/new_address_page.dart';
import 'package:hiba/providers/providers_library.dart';

import 'package:hiba/utils/api/location.dart';
import 'package:hiba/values/app_colors.dart';
import 'package:hiba/values/app_theme.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:provider/provider.dart';

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

  void refresh() async {
    await loadAddresses();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

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
