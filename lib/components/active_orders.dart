import 'package:carousel_slider_plus/carousel_slider_plus.dart';
import 'package:flutter/material.dart';
import 'package:hiba/entities/entities_library.dart';
import 'package:hiba/pages/orders/order_page.dart';
import 'package:hiba/utils/api/api_library.dart';
import 'package:hiba/values/app_colors.dart';
import 'package:hiba/values/app_theme.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class ActiveOrders extends StatefulWidget {
  const ActiveOrders({super.key});

  @override
  State<StatefulWidget> createState() => _ActiveOrdersState();
}

class _ActiveOrdersState extends State<ActiveOrders> {
  List<Order> _orders = [];

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
