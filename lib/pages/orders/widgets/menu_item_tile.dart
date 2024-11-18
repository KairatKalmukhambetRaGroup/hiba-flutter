part of '../order_library.dart';

/// A tile widget that displays a menu item with options to add or remove it from the shopping basket.
///
/// The [MenuItemTile] shows details about a [MenuItem], including its image, name, price, and category.
/// It allows users to add the item to their basket, remove it, or navigate to a detailed [MenuItemPage].
///
/// ### Example Usage
/// ```dart
/// MenuItemTile(
///   menuItem: myMenuItem,
///   butchery: myButchery,
///   charity: false,
/// );
/// ```
class MenuItemTile extends StatefulWidget {
  /// The menu item to display.
  final MenuItem menuItem;

  /// The butchery associated with the menu item.
  final Butchery butchery;

  /// Indicates whether the item is for charity.
  final bool charity;

  /// Creates a [MenuItemTile].
  const MenuItemTile(
      {super.key,
      required this.menuItem,
      required this.butchery,
      required this.charity});

  @override
  State<MenuItemTile> createState() => _MenuItemTileState();
}

/// The state class for [MenuItemTile].
///
/// Manages fetching the category of the menu item and handles user interactions such as adding or removing the item from the basket.

class _MenuItemTileState extends State<MenuItemTile> {
  /// The category of the menu item.
  Category? category;

  @override
  void initState() {
    super.initState();
    fetchCategory(widget.menuItem.categoryId);
  }

  /// Fetches the category of the menu item by its ID.
  ///
  /// - [id]: The ID of the category to fetch.
  fetchCategory(int id) async {
    try {
      Category? data = await getCategoryById(id);
      print(data);
      setState(() {
        category = data;
      });
    } catch (e) {
      // TODO: handle exception
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ShoppingBasket>(builder: (context, shoppingBasket, child) {
      MenuItem basketItem = widget.menuItem;
      final orderIndex =
          shoppingBasket.getOrderIndex(widget.butchery, widget.charity);
      if (orderIndex != -1) {
        basketItem = shoppingBasket.orders[orderIndex].items.firstWhere(
            (item) => item.id == widget.menuItem.id,
            orElse: () => widget.menuItem);
      }
      return Dismissible(
        key: UniqueKey(),
        direction: basketItem.quantity > 0
            ? DismissDirection.endToStart
            : DismissDirection.none,
        onDismissed: (direction) {
          if (direction == DismissDirection.endToStart) {
            shoppingBasket.deleteFromBasket(
                basketItem.id, widget.butchery, widget.charity);
          } else {
            return;
          }
        },
        dismissThresholds: const {DismissDirection.endToStart: 0.4},
        background: Container(
          color: AppColors.red,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SvgPicture.asset(
                'assets/svg/trash-can-outline-white.svg',
                width: 36,
              ),
              const SizedBox(width: 24),
            ],
          ),
        ),
        child: ListTile(
          onTap: () {
            pushWithoutNavBar(
              context,
              MaterialPageRoute(
                builder: (context) => MenuItemPage(
                  menuItem: widget.menuItem,
                  butchery: widget.butchery,
                  charity: widget.charity,
                  category: category,
                ),
              ),
            );
          },
          tileColor: AppColors.white,
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              if (widget.menuItem.image != null) ...[
                Image(
                  image: MemoryImage(base64Decode(widget.menuItem.image!)),
                  height: 56,
                  width: 80,
                  fit: BoxFit.contain,
                ),
              ] else ...[
                Image.asset(
                  'assets/images/meat.png',
                  width: 80,
                  height: 56,
                  fit: BoxFit.contain,
                ),
              ],
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            widget.menuItem.name,
                            style: AppTheme.black500_14,
                          ),
                        ),
                        Text(
                          '${widget.menuItem.price} ₸/${widget.menuItem.isWholeAnimal ? 'гл' : 'кг'}',
                          style: AppTheme.blue700_14,
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    if (category != null)
                      Text(
                        category!.name,
                        style: AppTheme.darkGrey500_11,
                      ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        basketItem.quantity == 0
                            ? TextButton(
                                onPressed: () {
                                  if (orderIndex != -1) {
                                    shoppingBasket.addItemByOrderIndex(
                                        widget.menuItem, orderIndex);
                                  } else {
                                    shoppingBasket.addItem(widget.menuItem,
                                        widget.butchery, widget.charity);
                                  }
                                },
                                style: const ButtonStyle(
                                  padding: WidgetStatePropertyAll(
                                      EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 5)),
                                  alignment: Alignment.center,
                                  backgroundColor: WidgetStatePropertyAll(
                                      AppColors.mainBlue),
                                ),
                                child: const Text(
                                  'В корзину',
                                  style: AppTheme.white600_11,
                                ))
                            : Row(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      shoppingBasket.removeItem(
                                          widget.menuItem.id,
                                          widget.butchery,
                                          widget.charity);
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
                                      widget.menuItem.isWholeAnimal
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
                                            widget.menuItem, orderIndex);
                                      } else {
                                        shoppingBasket.addItem(widget.menuItem,
                                            widget.butchery, widget.charity);
                                      }
                                    },
                                    icon: SvgPicture.asset(
                                        'assets/svg/round-plus.svg'),
                                    iconSize: 24,
                                  ),
                                ],
                              )
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
