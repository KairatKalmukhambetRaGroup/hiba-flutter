import 'package:hiba/entities/address.dart';
import 'package:hiba/entities/butchery.dart';
import 'package:hiba/entities/menu_item.dart';

class Order {
  Address? address;
  final Butchery butchery;
  final bool charity;
  final List<MenuItem> items = [];
  late String orderStatus;
  late int id;
  late double price = 0;
  late double totalPrice = 0;
  late double deliveryPrice = 0;
  late double donation = 0;
  late DateTime deliveryDate;
  String? senderName;

  Order({required this.butchery, required this.charity});

  void setAddress(Address address) {
    this.address = address;
  }

  factory Order.fromJson(Map<String, dynamic> json) {
    Order order = Order(
      butchery: Butchery.fromJson(json['butchery'] as Map<String, dynamic>),
      charity: json['charity'] as bool,
    );

    order.setAddress(Address.fromJson(json['address'] as Map<String, dynamic>));
    order.id = json['id'];
    order.orderStatus = json['orderStatus'];

    if (json.containsKey('totalPrice')) {
      order.totalPrice = json['totalPrice'];
    }
    if (json.containsKey('deliveryPrice')) {
      order.deliveryPrice = json['deliveryPrice'];
    }
    if (json.containsKey('donation')) {
      order.donation = json['donation'];
    }
    if (json.containsKey('deliveryDate')) {
      order.deliveryDate = DateTime.parse(json['deliveryDate']);
    }

    if (json.containsKey('menuItems')) {
      final menuItems = json['menuItems'];
      order.setMenuItemsFromJson(menuItems);
    }

    return order;
  }

  void setDonation(double donation) {
    this.donation = donation;
    calculateTotalPrice();
  }

  void setDeliveryPrice(double deliveryPrice) {
    this.deliveryPrice = deliveryPrice;
    calculateTotalPrice();
  }

  void calculateTotalPrice() {
    totalPrice = price + deliveryPrice + donation;
  }

  void setMenuItemsFromJson(Map<String, dynamic> json) {
    items.clear();
    for (final key in json.keys) {
      int value = json[key];
      // Extract relevant parts using regular expression (optional improvement)
      String idString,
          name,
          weightString,
          isWholeAnimalString,
          priceString,
          categoryIdString;
      final regex = RegExp(
          r'id=(.*?), name=(.*?), weight=(\d+), isWholeAnimal=(.*?), price=(\d+), butcheryCategoryId=(\d+), categoryId=(\d+)');
      final match = regex.firstMatch(key);

      if (match != null) {
        idString = match.group(1)!;
        name = match.group(2)!;
        weightString = match.group(3)!;
        isWholeAnimalString = match.group(4)!;
        priceString = match.group(5)!;
        categoryIdString = match.group(7)!;
      } else {
        // Handle invalid key format (throw exception, log error, etc.)
        throw Exception('Invalid key format for Menu object creation');
      }

      final id = int.parse(idString);
      final weight = int.parse(weightString);
      final isWholeAnimal = isWholeAnimalString ==
          'true'; // Assuming string values for true/false
      final price = int.parse(priceString);
      final categoryId = int.parse(categoryIdString);
// ... (similarly parse other values)

// Create the Menu object
      final menu = MenuItem(
        id: id,
        name: name,
        weight: weight,
        isWholeAnimal: isWholeAnimal,
        price: price, // Assuming parsed values assigned here
        categoryId: categoryId,
      );
      menu.quantity = value;
      items.add(menu);
    }
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
    this.price = price.toDouble();
    calculateTotalPrice();
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

    json['address'] = {"id": address?.id};
    json['butchery'] = {"id": butchery.id};
    json['charity'] = charity.toString();
    json['menuItemsId'] = menuItemsId;

    json['deliveryDate'] = deliveryDate.millisecondsSinceEpoch;
    json['sender'] = senderName;
    json['totalPrice'] = totalPrice;
    json['deliveryPrice'] = deliveryPrice;
    json['donation'] = donation;
    return json;
  }
}
