import 'package:flutter/material.dart';
import 'package:hiba/components/courier/delivery_tile.dart';
import 'package:hiba/components/custom_scaffold.dart';
import 'package:hiba/entities/butchery.dart';
import 'package:hiba/entities/location.dart';
import 'package:hiba/entities/order.dart';
import 'package:hiba/values/app_colors.dart';
import 'package:hiba/values/app_theme.dart';

class Deliveries extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DeliveriesState();
}

class _DeliveriesState extends State<Deliveries> {
  bool _groupByButchery = false;

  final Order testOrder = Order(
      butchery: Butchery(
          id: 1,
          name: "Tesst",
          address: "Address",
          latitude: 47.1,
          longitude: 48.2,
          city: const City(id: 1, name: "Almaty"),
          image: null),
      charity: false);

  @override
  void initState() {
    super.initState();
    testOrder.deliveryPrice = 100;
    testOrder.price = 4000;
    testOrder.id = 1;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      backgroundColor: AppColors.bgLight,
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: ListView.separated(
          separatorBuilder: (BuildContext context, int index) {
            return DeliveryTile(order: testOrder);
          },
          itemBuilder: (BuildContext context, int index) {
            return const Divider(height: 1.0, color: AppColors.darkGrey);
          },
          itemCount: 1,
        ),
      ),
    );
  }
}
