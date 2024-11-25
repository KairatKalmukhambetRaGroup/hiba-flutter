part of 'butchery_library.dart';

/// A page displaying details of a specific menu item.
///
/// The [MenuItemPage] provides detailed information about a menu item,
/// including its name, image, price, description, and category.
/// It also allows users to add or remove the item from their shopping basket.
///
/// ### Example Usage
/// ```dart
/// MenuItemPage(
///   menuItem: MenuItem(
///     id: 1,
///     name: 'Lamb Meat',
///     price: 5000,
///     isWholeAnimal: false,
///     description: 'Fresh lamb meat from local farms.',
///   ),
///   butchery: Butchery(
///     id: 101,
///     name: 'Halal Butchery',
///   ),
///   charity: false,
///   category: Category(
///     id: 10,
///     name: 'Sheep',
///   ),
/// );
/// ```
class MenuItemPage extends StatelessWidget {
  /// The menu item to display.
  final MenuItem menuItem;

  /// The butchery associated with the menu item.
  final Butchery butchery;

  /// Whether the purchase is for charity.
  final bool charity;

  /// The category of the menu item (optional).
  final Category? category;

  /// Creates a [MenuItemPage].
  ///
  /// - [menuItem]: The menu item details to display.
  /// - [butchery]: The butchery offering the menu item.
  /// - [charity]: Indicates if the purchase is for charity.
  /// - [category]: The category of the menu item (optional).
  const MenuItemPage(
      {super.key,
      required this.menuItem,
      required this.butchery,
      required this.charity,
      this.category});

  @override
  Widget build(BuildContext context) {
    return Consumer<ShoppingBasket>(builder: (context, shoppingBasket, child) {
      MenuItem basketItem = menuItem;
      final orderIndex = shoppingBasket.getOrderIndex(butchery, charity);
      if (orderIndex != -1) {
        basketItem = shoppingBasket.orders[orderIndex].items.firstWhere(
            (item) => item.id == menuItem.id,
            orElse: () => menuItem);
      }
      return Scaffold(
        backgroundColor: AppColors.bgLight,
        appBar: CustomAppBar(
          titleText: menuItem.name,
          context: context,
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  if (menuItem.image != null) ...[
                    Image(
                      image: MemoryImage(base64Decode(menuItem.image!)),
                      fit: BoxFit.cover,
                      height: 200,
                      width: double.infinity,
                    )
                  ] else ...[
                    Image.asset(
                      'assets/images/meat.png',
                      fit: BoxFit.cover,
                      height: 200,
                      width: double.infinity,
                    ),
                  ],
                  const SizedBox(height: 16),
                  Container(
                    color: AppColors.white,
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Text(
                                menuItem.name,
                                style: AppTheme.blue700_16,
                              ),
                            ),
                            Text(
                              '${menuItem.price} ₸/${menuItem.isWholeAnimal ? 'гл' : 'кг'}',
                              style: AppTheme.blue700_16,
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Вид',
                              style: AppTheme.darkGrey500_11,
                            ),
                            if (category != null)
                              Text(
                                category!.name,
                                style: AppTheme.darkGrey500_11,
                              ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        if (menuItem.description.isNotEmpty)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 16),
                              const Text(
                                'Описание',
                                textAlign: TextAlign.left,
                                style: AppTheme.blue700_16,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                menuItem.description,
                                style: AppTheme.black500_11,
                              )
                            ],
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
            Container(
              width: double.maxFinite,
              color: AppColors.white,
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: basketItem.quantity == 0
                  ? TextButton(
                      onPressed: () {
                        if (orderIndex != -1) {
                          shoppingBasket.addItemByOrderIndex(
                              menuItem, orderIndex);
                        } else {
                          shoppingBasket.addItem(menuItem, butchery, charity);
                        }
                      },
                      style: const ButtonStyle(
                        padding: WidgetStatePropertyAll(EdgeInsets.all(12)),
                        alignment: Alignment.center,
                        backgroundColor:
                            WidgetStatePropertyAll(AppColors.mainBlue),
                      ),
                      child: const Text(
                        'В корзину',
                        style: AppTheme.white600_16,
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${(basketItem.price * basketItem.quantity).toString()} ₸',
                            style: AppTheme.blue700_16,
                          ),
                          Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  shoppingBasket.removeItem(
                                      menuItem.id, butchery, charity);
                                },
                                icon: basketItem.quantity == 1
                                    ? SvgPicture.asset(
                                        'assets/svg/trash-can-outline.svg',
                                        width: 24,
                                      )
                                    : SvgPicture.asset(
                                        'assets/svg/round-minus.svg',
                                        width: 24,
                                      ),
                                iconSize: 24,
                              ),
                              SizedBox(
                                width: 76,
                                child: Text(
                                  menuItem.isWholeAnimal
                                      ? '${basketItem.quantity} гл'
                                      : '${basketItem.quantity} кг',
                                  style: AppTheme.black500_14,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  if (orderIndex != -1) {
                                    shoppingBasket.addItemByOrderIndex(
                                        menuItem, orderIndex);
                                  } else {
                                    shoppingBasket.addItem(
                                        menuItem, butchery, charity);
                                  }
                                },
                                icon: SvgPicture.asset(
                                    'assets/svg/round-plus.svg'),
                                iconSize: 24,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
            )
          ],
        ),
      );
    });
  }
}
