part of 'butchery_library.dart';

/// A page displaying details of a specific butchery and its products.
///
/// The [ButcheryPage] retrieves and displays information about a selected butchery,
/// including categories, products, and order details.
///
/// ### Example Usage
/// ```dart
/// ButcheryPage(
///   id: '123',
///   charity: true,
/// );
/// ```
class ButcheryPage extends StatefulWidget {
  /// The ID of the butchery to display.
  final String id;

  /// Whether the order includes a charity option.
  final bool charity;

  /// Creates a [ButcheryPage].
  const ButcheryPage({super.key, required this.id, required this.charity});

  @override
  State<StatefulWidget> createState() => _ButcherPageState();
}

class _ButcherPageState extends State<ButcheryPage> {
  /// Tracks whether the data is still loading.
  bool isLoading = true;

  /// Tracks if an error occurred during data fetching.
  bool hasError = false;

  /// The title of the page, representing the butchery name.
  String title = '';

  /// Error message to display if fetching fails.
  late String errorMessage = '';

  /// The butchery details fetched from the server.
  late Butchery butchery;

  /// Whether the order includes charity.
  bool charity = false;

  @override
  void initState() {
    super.initState();
    getData();
    setState(() {
      charity = widget.charity;
    });
  }

  /// Categories of products in the butchery.
  Map categories = {};

  /// Translates category keys into readable names.
  ///
  /// - [key]: The category key.
  /// Returns a string representation of the category name.
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

  /// Fetches the butchery details by its ID.
  ///
  /// Sets the title, populates the [butchery] instance, and handles errors.
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
                                BottomToTopPageTransition(
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
