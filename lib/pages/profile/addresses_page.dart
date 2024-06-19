import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hiba/components/custom_app_bar.dart';
import 'package:hiba/entities/address.dart';
import 'package:hiba/pages/profile/new_address_page.dart';
import 'package:hiba/providers/address_state.dart';
import 'package:hiba/utils/api/location.dart';
import 'package:hiba/values/app_colors.dart';
import 'package:hiba/values/app_theme.dart';
import 'package:provider/provider.dart';

class AddressesPage extends StatefulWidget {
  static const routeName = '/addresses';
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
                    child: Text('Нет данных', style: AppTheme.bodyBlue500_16),
                  )
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
                const WidgetStatePropertyAll<Color>(AppColors.mainBlue),
            shape: WidgetStatePropertyAll<RoundedRectangleBorder>(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
            minimumSize: const WidgetStatePropertyAll(Size.fromHeight(48)),
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
          Navigator.push(
              context,
              MaterialPageRoute(
                fullscreenDialog: true,
                builder: (context) => NewAddressPage(editAddress: address,),
              ),
            );
        },
      ),
    );
  }
}
