part of 'order_library.dart';

/// A page for confirming and submitting an order.
///
/// The [OrderConfirmPage] allows users to:
/// - Review their order details.
/// - Select delivery dates.
/// - Choose delivery options like splitting the order into packages.
/// - Add a donation amount to their order.
/// - Provide recipient information.
/// - Submit the order for processing.
///
/// It handles both charity and regular orders, adapting the available options accordingly.
///
/// ### Example Usage
/// ```dart
/// Navigator.push(
///   context,
///   MaterialPageRoute(
///     builder: (context) => OrderConfirmPage(order: myOrder),
///   ),
/// );
/// ```
/// {@category Orders}
class OrderConfirmPage extends StatefulWidget {
  /// The order to be confirmed and submitted.
  final Order order;

  /// Creates an [OrderConfirmPage].
  const OrderConfirmPage({super.key, required this.order});

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
  late final TextEditingController donationController;

  late ShoppingBasket shoppingBasket;

  int _packagesNumber = 1;
  int _donation = 0;

  late Order _order;

  bool isAnonym = false;
  DateTime? selectedDate;

  List<DateTime> futureDates = [];
  List<int> donations = [0, 100, 200, 500];

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
    donationController = TextEditingController();
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
    _order.packages = _packagesNumber;
    // _order.donation = _donation as double;
    if (senderNameController.text.isNotEmpty) {
      _order.senderName = senderNameController.text;
    }

    try {
      // ignore: unused_local_variable
      int status = await createOrder(_order);
      if (status == 200) {
        shoppingBasket.deleteOrder(_order.butchery, _order.charity);
        // ignore: use_build_context_synchronously
        pushReplacementWithNavBar(context,
            MaterialPageRoute(builder: (context) => const SplashPage()));
      }
      // ignore: empty_catches
    } catch (e) {}
  }

  List<DateTime> getFutureDates() {
    final now = DateTime.now().toUtc();
    DateTime todayUTC = DateTime.utc(now.year, now.month, now.day);
    final futureDates = List<DateTime>.generate(3, (index) {
      return todayUTC.add(Duration(days: index + 2));
    });
    return futureDates;
  }

  setUserDataOnInputs(AuthState authState) async {
    User? user = await authState.getUserData();

    if (user != null) {
      recipientNameController.text = user.name;
      recipientPhoneController.text = user.phone;
    }
  }

  @override
  Widget build(BuildContext context) {
    shoppingBasket = Provider.of<ShoppingBasket>(context);

    AuthState authState = Provider.of(context);
    setUserDataOnInputs(authState);
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColors.bgLight,
      appBar: CustomAppBar(
        titleText: 'Оформление заказа',
        context: context,
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
                    style: AppTheme.black600_16,
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
                                    ? AppTheme.blue500_14
                                    : AppTheme.darkGrey500_14,
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
                                  style: AppTheme.black500_14,
                                ),
                                SizedBox(
                                  height: 20,
                                  width: 40,
                                  child: FittedBox(
                                    fit: BoxFit.cover,
                                    child: Switch(
                                        trackOutlineColor:
                                            const WidgetStatePropertyAll(
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
                                      style: AppTheme.black600_16,
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
                                  style: AppTheme.black500_14,
                                ),
                                Row(
                                  children: [
                                    DropdownButton<int>(
                                      dropdownColor: AppColors.bgLight,
                                      style: AppTheme.black500_14,
                                      elevation: 0,
                                      value: _packagesNumber,
                                      padding: const EdgeInsets.all(4),
                                      items: [1, 2, 3, 4, 5]
                                          .map((element) => DropdownMenuItem(
                                                value: element,
                                                child: Text(
                                                  element.toString(),
                                                  style: AppTheme.black500_14,
                                                ),
                                              ))
                                          .toList(),
                                      onChanged: (newValue) {
                                        setState(() {
                                          _packagesNumber = newValue!;
                                        });
                                      },
                                    ),
                                    const SizedBox(width: 8),
                                    const Text(
                                      'пакетов',
                                      style: AppTheme.black500_14,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 24),
                            const Text(
                              'Вы можете оставить любую сумму на благотворительнось',
                              style: AppTheme.black600_16,
                            ),
                            const SizedBox(height: 16),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  ...donations.map(
                                    (donation) => Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 2),
                                      child: InkWell(
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 12, vertical: 6),
                                          decoration: BoxDecoration(
                                              color: AppColors.white,
                                              border: _donation == donation
                                                  ? Border.all(
                                                      width: 1,
                                                      color: AppColors.mainBlue,
                                                    )
                                                  : Border.all(
                                                      width: 1,
                                                      color: AppColors.grey,
                                                    ),
                                              borderRadius:
                                                  BorderRadius.circular(16)),
                                          child: Text(
                                            '$donation ₸',
                                            style: _donation == donation
                                                ? AppTheme.blue500_14
                                                : AppTheme.darkGrey500_14,
                                          ),
                                        ),
                                        onTap: () {
                                          setState(() {
                                            _order.donation = double.parse(
                                                donation.toString());
                                            _donation = donation;
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 2),
                                    child: SizedBox(
                                      width: 100,
                                      child: TextField(
                                        textAlign: TextAlign.center,
                                        controller: donationController,
                                        keyboardType: TextInputType.number,
                                        // padding: const EdgeInsets.symmetric(
                                        //     horizontal: 12, vertical: 6),
                                        textInputAction: TextInputAction.done,
                                        decoration: InputDecoration(
                                          fillColor: AppColors.white,
                                          border: OutlineInputBorder(
                                            borderSide: _donation ==
                                                    int.tryParse(
                                                        donationController.text)
                                                ? const BorderSide(
                                                    width: 1,
                                                    color: AppColors.mainBlue,
                                                  )
                                                : const BorderSide(
                                                    width: 1,
                                                    color: AppColors.grey,
                                                  ),
                                            borderRadius:
                                                BorderRadius.circular(16),
                                          ),
                                          hintText: 'другая сумма',
                                          hintStyle: AppTheme.darkGrey500_14,
                                          contentPadding:
                                              const EdgeInsets.all(0),
                                        ),
                                        scrollPadding: EdgeInsets.zero,
                                        onSubmitted: (value) {
                                          if (value.isEmpty) return;
                                          int? don = int.tryParse(value);
                                          if (don == null) return;
                                          setState(() {
                                            _order.donation =
                                                double.parse(value);
                                            _donation = don;
                                          });
                                          if (donations.contains(don)) {
                                            donationController.clear();
                                          }
                                        },
                                        onChanged: (_) {},
                                        onTapOutside: (event) =>
                                            FocusScope.of(context).unfocus(),
                                        style: _donation ==
                                                int.tryParse(
                                                    donationController.text)
                                            ? AppTheme.blue500_14
                                            : AppTheme.darkGrey500_14,

                                        // child: TextField(
                                        //   '$donation ₸',
                                        //   style: _donation == donation
                                        //       ? AppTheme.blue500_14
                                        //       : AppTheme.darkGrey500_14,
                                        // ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
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
                      Address? address = addressState.addresses.isEmpty
                          ? null
                          : addressState.currentAddress;
                      if (address != null) {
                        _order.setAddress(address);
                      }
                      // print(address.name);
                      return address == null
                          ? ListTile(
                              onTap: () {
                                showModalBottomSheet(
                                  isDismissible: true,
                                  backgroundColor: Colors.transparent,
                                  // isScrollControlled: true,
                                  context: context,
                                  builder: (context) {
                                    return const ShowAddresses();
                                  },
                                );
                              },
                              title: const Text('Выберите адрес'),
                            )
                          : ListTile(
                              onTap: () {
                                showModalBottomSheet(
                                  isDismissible: true,
                                  backgroundColor: Colors.transparent,
                                  // isScrollControlled: true,
                                  context: context,
                                  builder: (context) {
                                    return const ShowAddresses();
                                  },
                                );
                              },
                              tileColor: AppColors.bgLight,
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
                                    style: AppTheme.black500_14,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    address.info,
                                    style: AppTheme.darkGrey500_11,
                                  ),
                                ],
                              ),
                              trailing: SvgPicture.asset(
                                'assets/svg/chevron-right-grey.svg',
                                width: 24,
                              ),
                            );
                    }),
                    const SizedBox(height: 24),
                    const Text(
                      'Получатель',
                      style: AppTheme.black600_16,
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
                style: AppTheme.blue600_16,
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
                        style: AppTheme.black500_14,
                      )
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Доставка',
                        style: AppTheme.black500_14,
                      ),
                      Text(
                        _order.deliveryPrice == 0
                            ? 'бесплатно'
                            : _order.deliveryPrice.toString(),
                        style: AppTheme.black500_14,
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
                            style: AppTheme.black500_14,
                          ),
                          Text(
                            '${_order.donation.toString()} ₸',
                            style: AppTheme.black500_14,
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
                        style: AppTheme.red500_16,
                      ),
                      Text(
                        '${_order.totalPrice.toString()} ₸',
                        style: AppTheme.red700_16,
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
                const WidgetStatePropertyAll<Color>(AppColors.mainBlue),
            shape: WidgetStatePropertyAll<RoundedRectangleBorder>(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
            minimumSize: const WidgetStatePropertyAll(Size.fromHeight(48)),
          ),
          child: const Text(
            'Продолжить',
            style: AppTheme.white500_16,
          ),
        ),
      ),
    );
  }
}
