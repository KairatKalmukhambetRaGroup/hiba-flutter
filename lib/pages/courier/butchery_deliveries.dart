import 'package:flutter/material.dart';
import 'package:hiba/components/courier/delivery_tile.dart';
import 'package:hiba/components/custom_app_bar.dart';
import 'package:hiba/components/custom_scaffold.dart';
import 'package:hiba/entities/butchery.dart';
import 'package:hiba/entities/order.dart';
import 'package:hiba/utils/api/api_library.dart';
import 'package:hiba/values/app_colors.dart';

class ButcheryDeliveries extends StatefulWidget {
  final Butchery butchery;
  final bool isActive;
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
