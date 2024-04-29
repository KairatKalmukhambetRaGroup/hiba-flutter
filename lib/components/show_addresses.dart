import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hiba/entities/address.dart';
import 'package:hiba/pages/profile/new_address_page.dart';
import 'package:hiba/providers/address_state.dart';
import 'package:hiba/values/app_colors.dart';
import 'package:hiba/values/app_theme.dart';
import 'package:provider/provider.dart';

class ShowAddresses extends StatefulWidget {
  const ShowAddresses({super.key});

  @override
  State<StatefulWidget> createState() => _ShowAddressesState();
}

class _ShowAddressesState extends State<ShowAddresses> {
  final _sheet = GlobalKey();
  final _controller = DraggableScrollableController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onChanged);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  void _onChanged() {
    final currentSize = _controller.size;
    // if (currentSize <= 0.5) _collapse();
    // if (currentSize < 0.4) _hide();
  }

  void _collapse() => _animateSheet(sheet.snapSizes!.first);

  void _anchor() => _animateSheet(sheet.snapSizes!.last);

  void _expand() => _animateSheet(sheet.maxChildSize);

  void _hide() => _animateSheet(sheet.minChildSize);

  void _animateSheet(double size) {
    _controller.animateTo(
      size,
      duration: const Duration(milliseconds: 50),
      curve: Curves.easeInOut,
    );
  }

  DraggableScrollableSheet get sheet =>
      (_sheet.currentWidget as DraggableScrollableSheet);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      AddressState addressState = Provider.of<AddressState>(context);
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
                      style: AppTheme.headingBlack600_16,
                    ),
                  ),
                  Column(
                    children: addressState.addresses
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
                      style: AppTheme.headingBlack600_14,
                    ),
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed(NewAddressPage.routeName)
                          .then((value) {
                        // if (value == true) {
                        //   refresh();
                        // }
                      });
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

  Widget addressTile(Address address) => ListTile(
        title: Text(address.name),
      );
}
