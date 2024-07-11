import 'package:flutter/material.dart';
import 'package:hiba/components/courier/delivery_tile.dart';
import 'package:hiba/components/custom_app_bar.dart';
import 'package:hiba/components/custom_scaffold.dart';
import 'package:hiba/entities/address.dart';
import 'package:hiba/entities/butchery.dart';
import 'package:hiba/entities/location.dart';
import 'package:hiba/entities/order.dart';
import 'package:hiba/entities/user.dart';
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
  final City almatyCity = const City(id: 1, name: "Almaty");

  late Order testOrder;
  final List<Order> _orders = [];

  @override
  void initState() {
    super.initState();

    testOrder = Order(butchery: widget.butchery, charity: false);
    testOrder.deliveryPrice = 100;
    testOrder.price = 4000;
    testOrder.id = 1;
    testOrder.address = Address(
      id: 1,
      name: 'home',
      address: ' Жетысу - 1',
      building: '25',
      apartment: '77',
      entrance: '1',
      floor: '2',
      city: almatyCity,
    );
    testOrder.user = const User(
      phone: '87775007060',
      avatar: null,
      id: 11,
      name: 'Arman',
    );

    setState(() {
      _orders.add(testOrder);
    });
  }

  @override
  void dispose() {
    super.dispose();
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
              order: testOrder,
              fromButchery: true,
              isActive: widget.isActive,
            );
          },
          itemCount: 2,
        ),
      ),
    );
  }
}
