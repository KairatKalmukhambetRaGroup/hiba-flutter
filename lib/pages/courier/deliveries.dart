import 'package:flutter/material.dart';
import 'package:hiba/components/courier/delivery_butchery_tile.dart';
import 'package:hiba/components/courier/delivery_tile.dart';
import 'package:hiba/components/custom_scaffold.dart';
import 'package:hiba/entities/address.dart';
import 'package:hiba/entities/butchery.dart';
import 'package:hiba/entities/location.dart';
import 'package:hiba/entities/menu_item.dart';
import 'package:hiba/entities/order.dart';
import 'package:hiba/entities/user.dart';
import 'package:hiba/values/app_colors.dart';

class Deliveries extends StatefulWidget {
  final bool isActive;
  const Deliveries({super.key, required this.isActive});

  @override
  State<StatefulWidget> createState() => _DeliveriesState();
}

class _DeliveriesState extends State<Deliveries> {
  bool _groupByButchery = false;

  final City almatyCity = const City(id: 1, name: "Almaty");

  final Butchery butchery1 = Butchery(
      id: 1,
      name: "ИП Green farm",
      address: "Райымбек батыра, 147",
      latitude: 47.1,
      longitude: 48.2,
      city: const City(id: 1, name: "Almaty"),
      image: null);
  final Butchery butchery2 = Butchery(
      id: 2,
      name: "ТОО Sweet Meat",
      address: "Абая, 1",
      latitude: 47.1,
      longitude: 48.2,
      city: const City(id: 1, name: "Almaty"),
      image: null);
  late Order testOrder1;
  late Order testOrder2;
  late Order testOrder3;
  final List<Order> _orders = [];
  final List<Butchery> _butcheries = [];

  @override
  void initState() {
    super.initState();
    butchery1.phone = '+7 (747) 755 8819';
    butchery2.phone = '+7 (747) 755 1234';

    testOrder1 = Order(butchery: butchery1, charity: false);
    testOrder1.deliveryPrice = 100;
    testOrder1.price = 4000;
    testOrder1.id = 1;
    testOrder1.address = Address(
      id: 1,
      name: 'home',
      address: ' Жетысу - 1',
      building: '25',
      apartment: '77',
      entrance: '1',
      floor: '2',
      city: almatyCity,
    );
    testOrder1.user = const User(
      phone: '87775007060',
      avatar: null,
      id: 11,
      name: 'Arman',
    );

    MenuItem menuItem1 = MenuItem(
      id: 1,
      name: 'Казы',
      weight: 2,
      isWholeAnimal: false,
      categoryId: 1,
      price: 1000,
    );
    menuItem1.quantity = 2;

    testOrder1.items.add(menuItem1);

    testOrder2 = Order(butchery: butchery2, charity: true);
    testOrder2.deliveryPrice = 100;
    testOrder2.price = 4000;
    testOrder2.id = 2;
    testOrder2.status = 'RECIEVED';
    testOrder2.address = Address(
      id: 2,
      name: 'home',
      address: 'Розыбакиева',
      building: '28',
      apartment: '15',
      entrance: '1',
      floor: '3',
      city: almatyCity,
    );
    testOrder2.user = const User(
      phone: '87775007060',
      avatar: null,
      id: 11,
      name: 'Arman',
    );

    testOrder3 = Order(butchery: butchery2, charity: true);
    testOrder3.deliveryPrice = 100;
    testOrder3.price = 4000;
    testOrder3.id = 2;
    testOrder3.status = 'ON_THE_WAY';
    testOrder3.address = Address(
      id: 2,
      name: 'home',
      address: 'Розыбакиева',
      building: '28',
      apartment: '15',
      entrance: '1',
      floor: '3',
      city: almatyCity,
    );
    testOrder3.user = const User(
      phone: '87775007060',
      avatar: null,
      id: 11,
      name: 'Arman',
    );

    setState(() {
      _orders.add(testOrder1);
      _orders.add(testOrder2);
      _orders.add(testOrder3);

      _butcheries.add(butchery1);
      _butcheries.add(butchery2);
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
            ? ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return DeliveryButcheryTile(
                    butchery: _butcheries[index],
                    orders: _orders,
                    isActive: widget.isActive,
                  );
                },
                itemCount: _butcheries.length,
              )
            : ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return DeliveryTile(
                      order: _orders[index], isActive: widget.isActive);
                },
                itemCount: _orders.length,
              ),
      ),
    );
  }
}
