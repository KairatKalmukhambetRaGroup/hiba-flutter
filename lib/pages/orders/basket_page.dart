part of 'order_library.dart';

/// A page that displays the user's shopping basket.
///
/// The [BasketPage] shows all the items the user has added to their shopping basket.
/// If the basket is empty, it displays a message indicating that the basket is empty.
/// Users can proceed to confirm their orders or remove items from the basket.
///
/// ### Example Usage
/// ```dart
/// Navigator.push(
///   context,
///   MaterialPageRoute(
///     builder: (context) => const BasketPage(),
///   ),
/// );
/// ```
class BasketPage extends StatefulWidget {
  /// Creates a [BasketPage].
  const BasketPage({super.key});

  @override
  State<StatefulWidget> createState() => _BasketPageState();
}

class _BasketPageState extends State<BasketPage> {
  @override
  Widget build(BuildContext context) {
    final shoppingBasket = Provider.of<ShoppingBasket>(context);

    return CustomScaffold(
      backgroundColor: AppColors.bgLight,
      appBar: CustomAppBar(
        titleText: 'Корзина',
        context: context,
      ),
      body: shoppingBasket.orders.isEmpty
          ? Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 64),
                  SvgPicture.asset(
                    'assets/svg/shopping-cart-lg.svg',
                    width: 120,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Ваша корзина пуста',
                    style: AppTheme.black600_16,
                  )
                ],
              ),
            )
          : ListView.separated(
              itemBuilder: (context, i) {
                final order = shoppingBasket.orders[i];
                final items = order.items;
                return Container(
                  color: AppColors.white,
                  child: Column(
                    children: [
                      ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 16),
                        title: Text(
                          order.butchery.name,
                          style: AppTheme.blue600_16,
                        ),
                      ),
                      const Divider(height: 1, color: AppColors.grey),
                      const SizedBox(height: 8),
                      Text(
                        order.charity
                            ? 'На благотворительность'
                            : 'Для себя и близких',
                        style: AppTheme.blue500_14,
                      ),
                      const SizedBox(height: 8),
                      const Divider(height: 1, color: AppColors.grey),
                      for (final item in items)
                        MenuItemTile(
                            menuItem: item,
                            butchery: order.butchery,
                            charity: order.charity),
                      // ListView.separated(
                      //   itemBuilder: (context, j) {
                      //     final item = items[j];
                      //     return MenuItemTile(menuItem: item);
                      //   },
                      //   separatorBuilder: (context, j) => const Divider(
                      //     height: 1,
                      //     color: AppColors.grey,
                      //   ),
                      //   itemCount: items.length,
                      // ),
                      const Divider(height: 1, color: AppColors.darkGrey),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 24),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Общий вес заказа:'),
                                Text(
                                    '${order.calculateWeight().toString()} кг'),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Общая сумма:'),
                                Text('${order.calculatePrice().toString()} ₸'),
                              ],
                            ),
                            const SizedBox(height: 16),
                            TextButton(
                              onPressed: () {
                                pushWithoutNavBar(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            OrderConfirmPage(order: order)));
                              },
                              style: const ButtonStyle(
                                alignment: Alignment.center,
                                minimumSize:
                                    WidgetStatePropertyAll(Size.fromHeight(48)),
                                backgroundColor:
                                    WidgetStatePropertyAll(AppColors.mainBlue),
                              ),
                              child: const Text(
                                'Продолжить',
                                style: AppTheme.white600_16,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              },
              separatorBuilder: (context, i) => const SizedBox(height: 16),
              itemCount: shoppingBasket.orders.length),
    );
  }
}
