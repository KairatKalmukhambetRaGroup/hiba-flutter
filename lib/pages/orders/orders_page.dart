part of 'order_library.dart';

/// A page that displays the user's past orders.
///
/// The [OrdersPage] fetches and displays a list of the user's previous orders.
/// If there are no past orders, it shows a placeholder message indicating that no orders have been made.
///
/// ### Example Usage
/// ```dart
/// Navigator.push(
///   context,
///   MaterialPageRoute(
///     builder: (context) => const OrdersPage(),
///   ),
/// );
/// ```
/// {@category Orders}
class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<StatefulWidget> createState() => _OrdersPageState();
}

/// The state class for [OrdersPage].
///
/// Manages fetching the user's orders and updating the UI accordingly.
class _OrdersPageState extends State<OrdersPage> {
  /// List of the user's orders.
  List<Order> _orders = [];

  @override
  void initState() {
    super.initState();

    loadOrders();
  }

  /// Fetches the user's orders and updates the state.
  Future<void> loadOrders() async {
    final data = await getMyOrders();
    if (data != null) {
      setState(() {
        _orders = data;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgLight,
      appBar: CustomAppBar(
        titleText: 'Мои заказы',
        context: context,
      ),
      body: SafeArea(
          child: _orders.isNotEmpty
              ? ListView(
                  children:
                      _orders.map((order) => OrderCard(order: order)).toList(),
                )
              : Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 64),
                      SvgPicture.asset(
                        'assets/svg/orders-bg.svg',
                        width: 120,
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Заказов не было',
                        style: AppTheme.black600_16,
                      )
                    ],
                  ),
                )),
    );
  }
}
