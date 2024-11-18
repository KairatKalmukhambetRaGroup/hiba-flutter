part of '../order_library.dart';

/// A widget that displays the user's active orders in a carousel slider.
///
/// The [ActiveOrders] widget fetches the user's active orders and displays them
/// in a carousel format. If there are no active orders, it shows an empty space.
/// Users can tap on an order to navigate to its detailed [OrderPage].
///
/// ### Example Usage
/// ```dart
/// ActiveOrders();
/// ```
class ActiveOrders extends StatefulWidget {
  /// Creates an [ActiveOrders] widget.
  const ActiveOrders({super.key});

  @override
  State<StatefulWidget> createState() => _ActiveOrdersState();
}

/// The state class for [ActiveOrders].
///
/// Manages fetching active orders, tracking the current carousel index, and handling state updates.
class _ActiveOrdersState extends State<ActiveOrders> {
  /// List of active orders fetched from the server
  List<Order> _orders = [];

  /// The index of the currently displayed order in the carousel.
  int _current = 0;

  @override
  void initState() {
    super.initState();
    loadOrders();
  }

  @override
  void dispose() {
    super.dispose();
  }

  /// Fetches the user's active orders and updates the state.
  Future<void> loadOrders() async {
    final data = await getMyActiveOrders();
    if (data != null) {
      if (!mounted) return;
      setState(() {
        _orders = data;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return _orders.isEmpty
        ? const Padding(padding: EdgeInsets.zero)
        : Column(
            // padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            children: [
              CarouselSlider(
                options: CarouselOptions(
                    aspectRatio: 328 / 110,
                    height: 110,
                    enableInfiniteScroll: _orders.length > 1,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _current = index;
                      });
                    }),
                items: _orders
                    .map(
                      (order) => Builder(builder: (context) {
                        return InkWell(
                          onTap: () {
                            pushWithNavBar(
                              context,
                              MaterialPageRoute(
                                fullscreenDialog: false,
                                builder: (context) => OrderPage(order: order),
                              ),
                            );
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            color: AppColors.white,
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Заказ №${order.id}',
                                      style: AppTheme.black500_11,
                                    ),
                                    const Text(
                                      'подробнее',
                                      style: AppTheme.darkGrey500_11,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  order.orderStatus,
                                  style: AppTheme.orange600_14,
                                ),
                                const SizedBox(height: 4),
                                SingleChildScrollView(
                                  child: Row(
                                    children: order.items
                                        .map((item) => Text(item.name))
                                        .toList(),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      }),
                    )
                    .toList(),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: _orders.asMap().entries.map((entry) {
                  return Container(
                    width: 8,
                    height: 8,
                    margin: const EdgeInsets.symmetric(horizontal: 6),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _current == entry.key
                          ? AppColors.mainBlue
                          : AppColors.grey,
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),
            ],
          );
  }
}
