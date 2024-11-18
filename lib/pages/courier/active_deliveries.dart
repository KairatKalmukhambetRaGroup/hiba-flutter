part of 'courier_library.dart';

/// A page for viewing active delivery orders for couriers.
///
/// The [ActiveDeliveries] screen allows couriers to view their active orders
/// either grouped by butcheries or as a flat list of all orders.
/// It includes options to toggle between the views and refresh the data.
///
/// ### Example Usage
/// ```dart
/// Navigator.push(
///   context,
///   MaterialPageRoute(
///     builder: (context) => const ActiveDeliveries(),
///   ),
/// );
/// ```
class ActiveDeliveries extends StatefulWidget {
  const ActiveDeliveries({super.key});

  @override
  State<StatefulWidget> createState() => _ActiveDeliveriesState();
}

class _ActiveDeliveriesState extends State<ActiveDeliveries> {
  bool _groupByButchery = false;

  List<Order> _orders = [];
  List<Butchery> _butcheries = [];

  bool _loading = true;

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
    setState(() {
      _loading = true;
    });
    if (_groupByButchery) {
      final data = await getCourierOrdersByButchery(true);
      if (data != null) {
        setState(() {
          _butcheries = data;
        });
      }
    } else {
      final data = await getCourierOrders(true);
      if (data != null) {
        setState(() {
          _orders = data;
        });
      }
    }
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        surfaceTintColor: AppColors.white,
        title: Container(
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.mainBlue, width: 1),
            borderRadius: BorderRadius.circular(4),
          ),
          clipBehavior: Clip.antiAlias,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    setState(() {
                      _groupByButchery = false;
                    });
                    if (_orders.isEmpty) {
                      fetchOrders();
                    }
                  },
                  child: Container(
                    color:
                        _groupByButchery ? AppColors.white : AppColors.mainBlue,
                    padding: const EdgeInsets.all(6),
                    child: Text(
                      "Все заявки",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 14,
                          color: _groupByButchery
                              ? AppColors.mainBlue
                              : AppColors.white,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    setState(() {
                      _groupByButchery = true;
                    });
                    if (_butcheries.isEmpty) {
                      fetchOrders();
                    }
                  },
                  child: Container(
                    color:
                        _groupByButchery ? AppColors.mainBlue : AppColors.white,
                    padding: const EdgeInsets.all(6),
                    child: Text(
                      "По скотобойням",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 14,
                          color: _groupByButchery
                              ? AppColors.white
                              : AppColors.mainBlue,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        shape:
            const Border(bottom: BorderSide(width: 1, color: AppColors.grey)),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: CustomRefresher(
          onRefresh: fetchOrders,
          child: _loading
              ? Skeletonizer(
                  child: ListView.builder(
                  itemCount: 5,
                  itemBuilder: (BuildContext context, int index) {
                    return _groupByButchery
                        ? DeliveryButcheryTile.skeleton()
                        : DeliveryTile.skeleton();
                  },
                ))
              : _groupByButchery
                  ? _butcheries.isEmpty
                      ? const Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Нет активных заказов",
                                style: AppTheme.black500_16,
                              ),
                            ],
                          ),
                        )
                      : ListView.builder(
                          itemBuilder: (BuildContext context, int index) {
                            return DeliveryButcheryTile(
                              butchery: _butcheries[index],
                              isActive: true,
                            );
                          },
                          itemCount: _butcheries.length,
                        )
                  : _orders.isEmpty
                      ? const Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Нет активных заказов",
                                style: AppTheme.black500_16,
                              ),
                            ],
                          ),
                        )
                      : ListView.builder(
                          itemBuilder: (BuildContext context, int index) {
                            return DeliveryTile(
                                order: _orders[index], isActive: true);
                          },
                          itemCount: _orders.length,
                        ),
        ),
      ),
    );
  }
}
