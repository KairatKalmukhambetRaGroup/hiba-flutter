part of 'butchery_library.dart';

class ButcheryPage extends StatefulWidget {
  static const routeName = '/butchery';

  const ButcheryPage({super.key, required this.id, required this.charity});
  final String id;
  final bool charity;

  @override
  State<StatefulWidget> createState() => _ButcherPageState();
}

class _ButcherPageState extends State<ButcheryPage> {
  bool isLoading = true;
  bool hasError = false;
  String title = '';
  late String errorMessage = '';

  late Butchery butchery;
  bool charity = false;

  @override
  void initState() {
    super.initState();
    getData();
    setState(() {
      charity = widget.charity;
    });
  }

  Map categories = {};

  getCategoryTranslations(String key) {
    switch (key) {
      case 'sheep':
        return 'Баран';
      case 'cow':
        return 'Корова';
      case 'horse':
        return 'Лошадь';
      case 'birds':
        return 'Птицы';
      default:
        return '';
    }
  }

  getData() async {
    setState(() {
      isLoading = true;
    });
    try {
      butchery = (await getButcheryById(widget.id))!;
      setState(() {
        title = butchery.name;
      });
    } catch (e) {
      errorMessage = 'error';
      hasError = true;
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        backgroundColor: AppColors.bgLight,
        appBar: CustomAppBar(
          titleText: title,
          context: context,
        ),
        body: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      ShoppingBasket shoppingBasket = Provider.of<ShoppingBasket>(context);
      Order? order;
      int index = shoppingBasket.getOrderIndex(butchery, charity);
      if (index >= 0) order = shoppingBasket.orders[index];
      return Scaffold(
        backgroundColor: AppColors.bgLight,
        appBar: CustomAppBar(
          titleText: title,
          context: context,
        ),
        body: hasError
            ? Center(
                child: Text(errorMessage),
              )
            : SingleChildScrollView(
                child: Column(
                  children: [
                    if (butchery.image != null) ...[
                      Image(
                        image: MemoryImage(base64Decode(butchery.image!)),
                        height: 200,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ],
                    const SizedBox(height: 16),
                    // info

                    ListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            fullscreenDialog: false,
                            builder: (context) =>
                                ButcheryDetails(butchery: butchery),
                          ),
                        );
                      },
                      tileColor: AppColors.white,
                      trailing: SvgPicture.asset(
                        'assets/svg/chevron-right-grey.svg',
                        width: 24,
                      ),
                      title: Row(
                        children: [
                          Flexible(
                            child: Text(
                              butchery.name,
                              style: AppTheme.blue600_16,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),
                    Column(
                      children: List.generate(
                        butchery.categories.length,
                        (index) {
                          ButcheryCategory category =
                              butchery.categories[index];
                          return ExpansionTile(
                            backgroundColor: AppColors.white,
                            collapsedBackgroundColor: AppColors.white,
                            title: Text(
                              getCategoryTranslations(category.name),
                              style: AppTheme.blue600_16,
                            ),
                            children: List.generate(
                              category.menuItems.length,
                              (j) => MenuItemTile(
                                menuItem: category.menuItems[j],
                                butchery: butchery,
                                charity: charity,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
        bottomNavigationBar: order == null
            ? null
            : Container(
                height: 180,
                color: AppColors.white,
                padding: const EdgeInsets.symmetric(
                    vertical: 24.0, horizontal: 16.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Общий вес заказа:",
                          style: AppTheme.black500_14,
                        ),
                        Text(
                          "${order.calculateWeight()} кг",
                          style: AppTheme.black500_14,
                        ),
                      ],
                    ),
                    const SizedBox(height: 8.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Общая сумма:",
                          style: AppTheme.blue500_16,
                        ),
                        Text(
                          "${order.calculatePrice()} ₸",
                          style: AppTheme.red600_16,
                        ),
                      ],
                    ),
                    const SizedBox(height: 16.0),
                    Row(
                      children: [
                        Expanded(
                          child: TextButton(
                            onPressed: () {
                              pushWithoutNavBar(
                                context,
                                CustomPageTransition(
                                  child: OrderConfirmPage(order: order!),
                                ),
                              );
                            },
                            style: const ButtonStyle(
                              padding:
                                  WidgetStatePropertyAll(EdgeInsets.all(12)),
                              alignment: Alignment.center,
                              backgroundColor:
                                  WidgetStatePropertyAll(AppColors.mainBlue),
                            ),
                            child: const Text(
                              'Купить',
                              style: AppTheme.white600_16,
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
      );
    }
  }
}

class CustomPageTransition extends MaterialPageRoute {
  CustomPageTransition({required Widget child})
      : super(builder: (BuildContext context) => child);

  @override
  Duration get transitionDuration => const Duration(milliseconds: 200);

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    var begin = const Offset(0.0, 1.0);
    var end = Offset.zero;
    var tween = Tween(begin: begin, end: end);
    var offsetAnimation = animation.drive(tween);
    return SlideTransition(
      position: offsetAnimation,
      child: child,
    );
  }
}
