import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hiba/entities/address.dart';
import 'package:hiba/pages/profile/new_address_page.dart';
import 'package:hiba/utils/api/location.dart';
import 'package:hiba/values/app_colors.dart';
import 'package:hiba/values/app_theme.dart';

class AddressesPage extends StatefulWidget {
  static const routeName = '/addresses';
  const AddressesPage({super.key});

  @override
  State<StatefulWidget> createState() => _AddressesPageState();
}

class _AddressesPageState extends State<AddressesPage> {
  List<Address> _addresses = [];

  @override
  void initState() {
    loadAddresses();
    super.initState();
  }

  Future<void> loadAddresses() async {
    final data = await getAddresses();
    if (data != null) {
      setState(() {
        _addresses = data;
      });
    }
  }

  void refresh() async {
    await loadAddresses();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: const Text(
          'Мои адреса',
          style: AppTheme.headingBlack600_16,
        ),
        shape:
            const Border(bottom: BorderSide(width: 1, color: AppColors.grey)),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 8.0),
        child: _addresses.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : ListView.separated(
                itemBuilder: (context, index) {
                  return AddressTile(address: _addresses[index]);
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
            Navigator.of(context)
                .pushNamed(NewAddressPage.routeName)
                .then((value) {
              if (value == true) {
                refresh();
              }
            });
          },
          style: ButtonStyle(
            backgroundColor:
                const MaterialStatePropertyAll<Color>(AppColors.mainBlue),
            shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
            minimumSize: const MaterialStatePropertyAll(Size.fromHeight(48)),
          ),
          child: const Text(
            'Добавить адресс',
            style: AppTheme.headingWhite500_16,
          ),
        ),
      ),
    );
  }
}

class AddressTile extends StatelessWidget {
  final Address address;
  const AddressTile({super.key, required this.address});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      leading: SvgPicture.asset(
        'assets/svg/address-home-filled.svg',
        width: 36,
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            address.toString(),
            style: AppTheme.bodyBlack500_14,
          ),
          const SizedBox(height: 4),
          Text(
            address.info,
            style: AppTheme.bodyDarkgrey500_11,
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
          Navigator.of(context).pushNamed(NewAddressPage.routeName);
        },
      ),
    );
  }
}
