part of 'courier_library.dart';

class Deliveries extends StatefulWidget {
  const Deliveries({super.key});

  @override
  State<StatefulWidget> createState() => _DeliveriesState();
}

class _DeliveriesState extends State<Deliveries> {
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
      final data = await getCourierOrdersByButchery(false);
      if (data != null) {
        setState(() {
          _butcheries = data;
          _loading = false;
        });
      }
    } else {
      final data = await getCourierOrders(false);
      if (data != null) {
        setState(() {
          _orders = data;
          _loading = false;
        });
      }
    }
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
              ? ListView.builder(
                  itemCount: 5,
                  itemBuilder: (BuildContext context, int index) {
                    return _groupByButchery
                        ? DeliveryButcheryTile.skeleton()
                        : DeliveryTile.skeleton();
                  },
                )
              : _groupByButchery
                  ? ListView.builder(
                      physics: const AlwaysScrollableScrollPhysics(
                        parent: ClampingScrollPhysics(),
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        return DeliveryButcheryTile(
                          butchery: _butcheries[index],
                          isActive: false,
                        );
                      },
                      itemCount: _butcheries.length,
                    )
                  : ListView.builder(
                      physics: const AlwaysScrollableScrollPhysics(
                        parent: ClampingScrollPhysics(),
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        return DeliveryTile(
                            order: _orders[index], isActive: false);
                      },
                      itemCount: _orders.length,
                    ),
        ),
      ),
    );
  }
}
