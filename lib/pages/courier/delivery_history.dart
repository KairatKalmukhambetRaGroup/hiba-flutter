import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hiba/components/courier/delivery_tile.dart';
import 'package:hiba/components/custom_app_bar.dart';
import 'package:hiba/components/custom_scaffold.dart';
import 'package:hiba/entities/entities_library.dart';
import 'package:hiba/values/app_colors.dart';
import 'package:hiba/values/app_theme.dart';
import 'package:intl/intl.dart';

enum DateFilter { month, quarter, half, year }

class DeliveryHistory extends StatefulWidget {
  const DeliveryHistory({super.key});

  @override
  State<StatefulWidget> createState() => _DeliveryHistoryState();
}

class _DeliveryHistoryState extends State<DeliveryHistory> {
  DateTime now = DateTime.now();

  late DateTime startDate;
  late DateTime endDate;
  DateFilter _filter = DateFilter.month;

  final City almatyCity = const City(id: 1, name: "Almaty");

  final List<Order> _orders = [];

  final Butchery butchery = Butchery(
      id: 1,
      name: "ИП Green farm",
      address: "Райымбек батыра, 147",
      latitude: 47.1,
      longitude: 48.2,
      city: const City(id: 1, name: "Almaty"),
      image: null);

  late Order testOrder;

  @override
  void initState() {
    super.initState();

    startDate = DateTime(now.year, now.month - 1, now.day, 0, 0);
    endDate = DateTime(now.year, now.month, now.day, 23, 59);

    butchery.phone = '+7 (747) 755 8819';

    testOrder = Order(butchery: butchery, charity: false);
    testOrder.deliveryPrice = 100;
    testOrder.price = 4000;
    testOrder.id = 1;
    testOrder.address = Address(
      id: 1,
      name: 'home',
      street: ' Жетысу - 1',
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

    MenuItem menuItem1 = MenuItem(
      id: 1,
      name: 'Казы',
      weight: 2,
      isWholeAnimal: false,
      categoryId: 1,
      price: 1000,
    );
    menuItem1.quantity = 2;

    testOrder.items.add(menuItem1);

    setState(() {
      _orders.add(testOrder);
    });
  }

  void changeFilter(DateFilter? newValue) {
    if (newValue != null) {
      setState(() {
        _filter = newValue;
        switch (newValue) {
          case DateFilter.month:
            startDate = DateTime(now.year, now.month - 1, now.day, 0, 0);
            break;
          case DateFilter.quarter:
            startDate = DateTime(now.year, now.month - 3, now.day, 0, 0);
            break;
          case DateFilter.half:
            startDate = DateTime(now.year, now.month - 6, now.day, 0, 0);
            break;
          case DateFilter.year:
            startDate = DateTime(now.year - 1, now.month, now.day, 0, 0);
            break;
        }
      });
    }
    Navigator.pop(context);
  }

  String formatFilter() {
    return "${DateFormat(startDate.year == endDate.year ? 'd MMMM' : 'd MMMM, yyyy').format(startDate)} - ${DateFormat(startDate.year == endDate.year ? 'd MMMM' : 'd MMMM, yyyy').format(endDate)}";
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        backgroundColor: AppColors.white,
        appBar: CustomAppBar(
          context: context,
          titleText: "История доставок",
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ListView(
            children: [
              InkWell(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return Container(
                        height: 260,
                        decoration: const BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20)),
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              RadioListTile(
                                value: DateFilter.month,
                                activeColor: AppColors.mainBlue,
                                groupValue: _filter,
                                onChanged: (DateFilter? value) {
                                  changeFilter(value);
                                },
                                title: Text(
                                  "За месяц",
                                  style: _filter == DateFilter.month
                                      ? AppTheme.blue500_14
                                      : AppTheme.black500_14,
                                ),
                              ),
                              RadioListTile(
                                value: DateFilter.quarter,
                                activeColor: AppColors.mainBlue,
                                groupValue: _filter,
                                onChanged: (DateFilter? value) {
                                  changeFilter(value);
                                },
                                title: Text(
                                  "За три месяца",
                                  style: _filter == DateFilter.quarter
                                      ? AppTheme.blue500_14
                                      : AppTheme.black500_14,
                                ),
                              ),
                              RadioListTile(
                                value: DateFilter.half,
                                activeColor: AppColors.mainBlue,
                                groupValue: _filter,
                                onChanged: (DateFilter? value) {
                                  changeFilter(value);
                                },
                                title: Text(
                                  "За пол года",
                                  style: _filter == DateFilter.half
                                      ? AppTheme.blue500_14
                                      : AppTheme.black500_14,
                                ),
                              ),
                              RadioListTile(
                                value: DateFilter.year,
                                activeColor: AppColors.mainBlue,
                                groupValue: _filter,
                                onChanged: (DateFilter? value) {
                                  changeFilter(value);
                                },
                                title: Text(
                                  "За год",
                                  style: _filter == DateFilter.year
                                      ? AppTheme.blue500_14
                                      : AppTheme.black500_14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: const BoxDecoration(
                    color: AppColors.white,
                    border: Border(
                      bottom: BorderSide(width: 1, color: AppColors.grey),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/svg/calendar-range.svg',
                        width: 24,
                        height: 24,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        formatFilter(),
                        style: AppTheme.black500_14,
                      ),
                    ],
                  ),
                ),
              ),
              for (var index = 0; index < _orders.length; index++) ...[
                DeliveryTile(
                    order: _orders[index], isActive: false, isDone: true)
              ]
            ],
          ),
        ));
  }
}
