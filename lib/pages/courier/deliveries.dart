import 'package:flutter/material.dart';
import 'package:hiba/components/courier/delivery_butchery_tile.dart';
import 'package:hiba/components/courier/delivery_tile.dart';
import 'package:hiba/components/custom_scaffold.dart';
import 'package:hiba/entities/address.dart';
import 'package:hiba/entities/butchery.dart';
import 'package:hiba/entities/location.dart';
import 'package:hiba/entities/order.dart';
import 'package:hiba/entities/user.dart';
import 'package:hiba/values/app_colors.dart';

class Deliveries extends StatefulWidget {
  const Deliveries({super.key});

  @override
  State<StatefulWidget> createState() => _DeliveriesState();
}

class _DeliveriesState extends State<Deliveries> {
  bool _groupByButchery = false;

  final City almatyCity = const City(id: 1, name: "Almaty");

  final Butchery butchery = Butchery(
      id: 1,
      name: "ИП Green farm",
      address: "Райымбек батыра, 147",
      latitude: 47.1,
      longitude: 48.2,
      city: const City(id: 1, name: "Almaty"),
      image: null);
  late Order testOrder;
  List<Order> _orders = [];

  @override
  void initState() {
    super.initState();
    butchery.phone = '+7 (747) 755 8819';
    testOrder = Order(butchery: butchery, charity: false);
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
    testOrder.user =
        User(phone: '87775007060', avatar: null, id: 11, name: 'Arman');

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
        child: _groupByButchery
            ? ListView.separated(
                itemBuilder: (BuildContext context, int index) {
                  return DeliveryButcheryTile(
                      butchery: butchery, orders: _orders);
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const Divider(height: 1.0, color: AppColors.darkGrey);
                },
                itemCount: 2,
              )
            : ListView.separated(
                itemBuilder: (BuildContext context, int index) {
                  return DeliveryTile(order: testOrder);
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const Divider(height: 1.0, color: AppColors.darkGrey);
                },
                itemCount: 2,
              ),
      ),
    );
  }
}
