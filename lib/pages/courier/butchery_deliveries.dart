part of 'courier_library.dart';

/// A page for viewing delivery orders for a specific butchery.
///
/// The [ButcheryDeliveries] screen lists the delivery orders for the selected butchery.
/// It shows orders based on their active status and provides details for each order.
///
/// ### Example Usage
/// ```dart
/// Navigator.push(
///   context,
///   MaterialPageRoute(
///     builder: (context) => ButcheryDeliveries(
///       butchery: Butchery(name: 'Halal Butchery', id: 1),
///       isActive: true,
///     ),
///   ),
/// );
/// ```
class ButcheryDeliveries extends StatefulWidget {
  /// The butchery for which the delivery orders are displayed.
  final Butchery butchery;

  /// Indicates whether to display active orders or completed ones.
  final bool isActive;

  /// Creates a [ButcheryDeliveries] page.
  const ButcheryDeliveries({
    super.key,
    required this.butchery,
    required this.isActive,
  });

  @override
  State<StatefulWidget> createState() => _ButcheryDeliveriesState();
}

class _ButcheryDeliveriesState extends State<ButcheryDeliveries> {
  List<Order> _orders = [];

  @override
  void initState() {
    super.initState();
    fetchOrders();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> fetchOrders() async {
    final data =
        await getCourierOrdersByButcheryId(widget.isActive, widget.butchery.id);
    if (data != null) {
      setState(() {
        _orders = data;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      backgroundColor: AppColors.white,
      appBar: CustomAppBar(
        context: context,
        titleText: widget.butchery.name,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            return DeliveryTile(
              order: _orders[index],
              fromButchery: true,
              isActive: widget.isActive,
            );
          },
          itemCount: _orders.length,
        ),
      ),
    );
  }
}
