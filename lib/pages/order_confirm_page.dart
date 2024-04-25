import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hiba/components/app_text_form_field.dart';
import 'package:hiba/entities/address.dart';
import 'package:hiba/entities/order.dart';
import 'package:hiba/providers/address_state.dart';
import 'package:hiba/utils/api/orders.dart';
import 'package:hiba/values/app_colors.dart';
import 'package:hiba/values/app_theme.dart';
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
  final ValueNotifier<bool> recipientPhoneNotifier = ValueNotifier(true);

  late final TextEditingController recipientNameController;
  late final TextEditingController recipientPhoneController;

  Future<void> initializeControllers() async {
    recipientNameController = TextEditingController()
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
    super.initState();
  }

  @override
  void dispose() {
    disposeControllers();
    super.dispose();
  }

  void submitOrder() async {
    print(widget.order.address);
    if (widget.order.address != null) {
      try {
        int status = await createOrder(widget.order);
        print(status);
      } catch (e) {
        print(e);
      }
    }
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
                  Row(
                    children: [],
                  ),
                  const SizedBox(height: 24),
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
              ),
            ),
            const SizedBox(height: 16),
            Container(
              color: AppColors.white,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ADDRESS TILE
                  Consumer<AddressState>(
                      builder: (context, addressState, child) {
                    Address? address = addressState.addresses[0];
                    if (address != null) {
                      widget.order.setAddress(address);
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
            Container(
              color: AppColors.white,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Мясная продукция'),
                      Text(widget.order.calculatePrice().toString())
                    ],
                  ),
                  const SizedBox(height: 4),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Text('Доставка'), Text('Доставка')],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('На благотворительность'),
                      Text((100).toString())
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Общая сумма заказа:'),
                      Text((widget.order.calculatePrice() + 100).toString())
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
