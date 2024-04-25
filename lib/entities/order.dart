import 'package:hiba/entities/address.dart';
import 'package:hiba/entities/butchery.dart';
import 'package:hiba/entities/menu_item.dart';

class Order {
  late Address address;
  final Butchery butchery;
  final bool charity;
  final List<MenuItem> items = [];
  int? id;

  Order({required this.butchery, required this.charity});

  void setAddress(Address address) {
    this.address = address;
  }

  factory Order.fromJson(Map<String, dynamic> json) {
    print(json['id']);

    Order order = Order(
      butchery: Butchery.fromJson(json['butchery'] as Map<String, dynamic>),
      charity: json['charity'] as bool,
    );
    print(order.charity);

    // items: json['building'],
    order.setAddress(Address.fromJson(json['address'] as Map<String, dynamic>));
    order.id = json['id'];
    return order;
  }

  int calculateWeight() {
    int weight = 0;
    for (MenuItem item in items) {
      weight += item.weight * item.quantity;
    }
    return weight;
  }

  int calculatePrice() {
    int price = 0;
    for (MenuItem item in items) {
      price += item.price * item.quantity;
    }
    return price;
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};

    Map<String, int> menuItemsId = {};

    for (MenuItem item in items) {
      menuItemsId[item.id.toString()] = menuItemsId[item.id.toString()] == null
          ? 1
          : menuItemsId[item.id.toString()]! + 1;
    }

    json['address'] = {"id": address.id};
    json['butchery'] = {"id": butchery.id};
    json['charity'] = charity.toString();
    json['menuItemsId'] = menuItemsId;

    return json;
  }
}
