import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hiba/components/app_text_form_field.dart';
import 'package:hiba/components/order_menu_item_tile.dart';
import 'package:hiba/entities/address.dart';
import 'package:hiba/entities/order.dart';
import 'package:hiba/providers/address_state.dart';
import 'package:hiba/utils/api/orders.dart';
import 'package:hiba/values/app_colors.dart';
import 'package:hiba/values/app_theme.dart';
import 'package:intl/intl.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

class OrderConfirmPage extends StatefulWidget {
  const OrderConfirmPage({super.key, required this.order});
  final Order order;

  @override
  State<StatefulWidget> createState() => _OrderConfirmPageState();
}

class _OrderConfirmPageState extends State<OrderConfirmPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final ValueNotifier<bool> recipientNameNotifier = ValueNotifier(true);
  final ValueNotifier<bool> senderNameNotifier = ValueNotifier(true);
  final ValueNotifier<bool> recipientPhoneNotifier = ValueNotifier(true);

  late final TextEditingController recipientNameController;
  late final TextEditingController senderNameController;
  late final TextEditingController recipientPhoneController;

  late Order _order;

  bool isAnonym = false;
  DateTime? selectedDate = null;

  List<DateTime> futureDates = [];

  void _handleAnonymChange(bool value) {
    setState(() {
      isAnonym = value;
      if (value == true) senderNameController.clear();
    });
  }

  Future<void> initializeControllers() async {
    recipientNameController = TextEditingController()
      ..addListener(controllerListener);
    senderNameController = TextEditingController()
      ..addListener(controllerListener);
    recipientPhoneController = TextEditingController()
      ..addListener(controllerListener);
  }

  void disposeControllers() {
    recipientNameController.dispose();
    recipientPhoneController.dispose();
  }

  void controllerListener() {
    final recipientName = recipientNameController.text;
    final recipientPhone = recipientPhoneController.text;

    if (recipientName.isEmpty) return;
    recipientNameNotifier.value = true;

    if (recipientPhone.isEmpty) return;
    recipientPhoneNotifier.value = true;
  }

  @override
  void initState() {
    initializeControllers();
    futureDates = getFutureDates();
    super.initState();
    _order = widget.order;
  }

  @override
  void dispose() {
    disposeControllers();
    super.dispose();
  }

  void submitOrder() async {
    if (!_order.charity && _order.address == null) return;
    if (selectedDate == null) {
      return;
    } else {
      _order.deliveryDate = selectedDate!;
    }
    if (senderNameController.text.isNotEmpty) {
      _order.senderName = senderNameController.text;
    }

    try {
      int status = await createOrder(_order);
      print(status);
    } catch (e) {
      print(e);
    }
  }

  List<DateTime> getFutureDates() {
    final today = DateTime.now().toUtc();
    final futureDates = List<DateTime>.generate(3, (index) {
      return today.add(Duration(days: index + 2));
    });
    return futureDates;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColors.bgLight,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        automaticallyImplyLeading: true,
        title: const Text(
          'Оформление заказа',
          style: AppTheme.headingBlack600_16,
        ),
        centerTitle: true,
      ),
      body: Form(
        child: ListView(
          children: [
            const SizedBox(height: 16),
            Container(
              color: AppColors.white,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: Column(
                children: [
                  const Text(
                    'Выберите дату доставки',
                    style: AppTheme.headingBlack600_16,
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 4,
                    children: futureDates
                        .map(
                          (date) => InkWell(
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                  color: AppColors.white,
                                  border: selectedDate?.compareTo(date) == 0
                                      ? Border.all(
                                          width: 1, color: AppColors.mainBlue)
                                      : Border.all(
                                          width: 1, color: AppColors.grey),
                                  borderRadius: BorderRadius.circular(16)),
                              child: Text(
                                DateFormat('dd-MMMM').format(date),
                                style: selectedDate?.compareTo(date) == 0
                                    ? AppTheme.bodyBlue500_14
                                    : AppTheme.bodyDarkGrey500_14,
                              ),
                            ),
                            onTap: () {
                              setState(() {
                                selectedDate = date;
                              });
                            },
                          ),
                        )
                        .toList(),
                  ),
                  const SizedBox(height: 24),
                  _order.charity == true
                      ? Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Сделать благотворительность анонимно',
                                  style: AppTheme.bodyBlack500_14,
                                ),
                                SizedBox(
                                  height: 20,
                                  width: 40,
                                  child: FittedBox(
                                    fit: BoxFit.cover,
                                    child: Switch(
                                        trackOutlineColor:
                                            const MaterialStatePropertyAll(
                                                Colors.transparent),
                                        inactiveThumbColor: AppColors.white,
                                        inactiveTrackColor: AppColors.grey,
                                        activeColor: AppColors.white,
                                        activeTrackColor: AppColors.mainBlue,
                                        value: isAnonym,
                                        onChanged: _handleAnonymChange),
                                  ),
                                )
                              ],
                            ),
                            if (!isAnonym)
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 24),
                                    const Text(
                                      'Отправитель',
                                      style: AppTheme.headingBlack600_16,
                                    ),
                                    const SizedBox(height: 8),
                                    AppTextFormField(
                                      autofocus: true,
                                      controller: senderNameController,
                                      placeholder: 'Имя Фамилия',
                                      keyboardType: TextInputType.text,
                                      textInputAction: TextInputAction.next,
                                      onChanged: (_) =>
                                          _formKey.currentState?.validate(),
                                      validator: (value) {
                                        return value!.isEmpty
                                            ? ''
                                            : value.length < 4
                                                ? ''
                                                : null;
                                      },
                                    ),
                                  ]),
                          ],
                        )
                      : Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Разделить заказ на',
                                  style: AppTheme.bodyBlack500_14,
                                ),
                                const Text(
                                  'пакетов',
                                  style: AppTheme.bodyBlack500_14,
                                ),
                              ],
                            ),
                            const SizedBox(height: 24),
                            const Text(
                              'Вы можете оставить любую сумму на благотворительнось',
                              style: AppTheme.headingBlack600_16,
                            ),
                            const SizedBox(height: 16),
                            Row(
                              children: [],
                            ),
                          ],
                        )
                ],
              ),
            ),
            const SizedBox(height: 16),
            if (_order.charity == false)
              Container(
                color: AppColors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ADDRESS TILE
                    Consumer<AddressState>(
                        builder: (context, addressState, child) {
                      Address? address = addressState.addresses[0];
                      if (address != null) {
                        _order.setAddress(address);
                      }
                      // print(address.name);
                      return address == null
                          ? ListTile(
                              onTap: () {
                                // if (addressState.addresses.isNotEmpty) {
                                //   addressState.setCurrentAddress(
                                //       addressState.addresses[0]);
                                // }
                              },
                              title: Text('Выберите адрес'),
                            )
                          : ListTile(
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
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
                            );
                    }),
                    const SizedBox(height: 24),
                    const Text(
                      'Получатель',
                      style: AppTheme.headingBlack600_16,
                    ),
                    const SizedBox(height: 16),
                    AppTextFormField(
                      autofocus: true,
                      controller: recipientNameController,
                      placeholder: 'Имя',
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      onChanged: (_) => _formKey.currentState?.validate(),
                      validator: (value) {
                        return value!.isEmpty
                            ? ''
                            : value.length < 4
                                ? ''
                                : null;
                      },
                    ),
                    const SizedBox(height: 8),
                    AppTextFormField(
                      autofocus: true,
                      controller: recipientPhoneController,
                      placeholder: '+ 7 (___) ___ __ __',
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      onChanged: (_) => _formKey.currentState?.validate(),
                      validator: (value) {
                        return value!.isEmpty
                            ? ''
                            : value.length < 4
                                ? ''
                                : null;
                      },
                    ),
                  ],
                ),
              ),
            const SizedBox(height: 16),
            ExpansionTile(
              initiallyExpanded: true,
              shape: const Border.fromBorderSide(BorderSide.none),
              collapsedBackgroundColor: AppColors.white,
              backgroundColor: AppColors.white,
              title: Text(
                _order.butchery.name,
                style: AppTheme.headingBlue600_16,
              ),
              children: _order.items
                  .map((item) => OrderMenuItemTile(menuItem: item))
                  .toList(),
            ),
            Container(
              color: AppColors.white,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Мясная продукция'),
                      Text(
                        _order.calculatePrice().toString(),
                        style: AppTheme.bodyBlack500_14,
                      )
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Доставка',
                        style: AppTheme.bodyBlack500_14,
                      ),
                      Text(
                        _order.deliveryPrice == 0
                            ? 'бесплатно'
                            : _order.deliveryPrice.toString(),
                        style: AppTheme.bodyBlack500_14,
                      ),
                    ],
                  ),
                  if (!_order.charity)
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'На благотворительность',
                            style: AppTheme.bodyBlack500_14,
                          ),
                          Text(
                            '${_order.donation.toString()} ₸',
                            style: AppTheme.bodyBlack500_14,
                          ),
                        ],
                      ),
                    ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Общая сумма заказа:',
                        style: AppTheme.bodyRed500_16,
                      ),
                      Text(
                        '${_order.totalPrice.toString()} ₸',
                        style: AppTheme.headingRed700_16,
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: ListTile(
        tileColor: AppColors.white,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        title: TextButton(
          onPressed: () {
            submitOrder();
            // printFormInputs();
          },
          style: ButtonStyle(
            backgroundColor:
                const MaterialStatePropertyAll<Color>(AppColors.mainBlue),
            shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
            minimumSize: const MaterialStatePropertyAll(Size.fromHeight(48)),
          ),
          child: const Text(
            'Сохранить',
            style: AppTheme.headingWhite500_16,
          ),
        ),
      ),
    );
  }
}
