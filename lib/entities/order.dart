/// lib/entities/entities_library.dart
part of 'entities_library.dart';

/// An `Order` object represents an order taken by [User] to [Butchery], with all specific details.
class Order {
  /// Destination address of this order.
  /// Typically address of an [User].
  Address? address;

  /// Butchery this order taken to.
  final Butchery butchery;

  /// Whether this order is for charity or not.
  final bool charity;

  /// List of `menu items` this order containing.
  final List<MenuItem> items = [];

  /// Status of this order.
  late String orderStatus;

  /// Unique identifier of this order.
  late int id;

  /// Number of packages of this order.
  int packages = 1;

  /// Price of [MenuItem]s of this order.
  late double price = 0;

  /// Delivery price of this order.
  late double deliveryPrice = 0;

  /// Total price of this order.
  late double totalPrice = 0;

  /// Donated sum of money with this order.
  late double donation = 0;

  /// Date of delivery of this order.
  late DateTime deliveryDate;

  /// User this order belongs to.
  User? user;

  /// Name of sender this order belongs to.
  /// [senderName] can be different than [user]'s name, as order can be anonymous in case of charity order.
  String? senderName;

  /// Create new `Order` instance.
  Order({required this.butchery, required this.charity});

  void setAddress(Address address) {
    this.address = address;
  }

  /// Create new `Order` instance from JSON object.
  factory Order.fromJson(Map<String, dynamic> json) {
    Order order = Order(
      butchery: Butchery.fromJson(json['butchery'] as Map<String, dynamic>),
      charity: json['charity'] as bool,
    );

    if (json.containsKey('address') && json['address'] != null) {
      order.setAddress(
          Address.fromJson(json['address'] as Map<String, dynamic>));
    }
    order.id = json['id'];
    order.orderStatus = json['orderStatus'];

    if (json.containsKey('packages') && json['packages'] != null) {
      order.packages = json['packages'];
    }

    if (json.containsKey('totalPrice') && json['totalPrice'] != null) {
      order.totalPrice = json['totalPrice'];
    }
    if (json.containsKey('deliveryPrice') && json['deliveryPrice'] != null) {
      order.deliveryPrice = json['deliveryPrice'];
    }
    if (json.containsKey('donation') && json['donation'] != null) {
      order.donation = json['donation'];
    }
    if (json.containsKey('deliveryDate') && json['deliveryDate'] != null) {
      order.deliveryDate = DateTime.parse(json['deliveryDate']);
    }

    if (json.containsKey('menuItems') && json['menuItems'] != null) {
      final menuItems = json['menuItems'];
      order.setMenuItemsFromJson(menuItems);
    }

    return order;
  }

  /// Create new `Order` instance from JSON object. Different from [Order.fromJson], JSON object contains different fields.
  factory Order.fromJsonOrderResponse(Map<String, dynamic> data) {
    var json = data['order'];
    var list = data['menuList'];

    Order order = Order(
      butchery: Butchery.fromJson(json['butchery'] as Map<String, dynamic>),
      charity: json['charity'] as bool,
    );

    if (json.containsKey('address') && json['address'] != null) {
      order.setAddress(
          Address.fromJson(json['address'] as Map<String, dynamic>));
    }
    order.id = json['id'];
    if (json.containsKey('orderStatus')) {
      order.orderStatus = json['orderStatus'];
    }

    if (json.containsKey('packages') && json['packages'] != null) {
      order.packages = json['packages'];
    }

    if (json.containsKey('totalPrice') && json['totalPrice'] != null) {
      order.totalPrice = json['totalPrice'];
    }
    if (json.containsKey('deliveryPrice') && json['deliveryPrice'] != null) {
      order.deliveryPrice = json['deliveryPrice'];
    }
    if (json.containsKey('donation') && json['donation'] != null) {
      order.donation = json['donation'];
    }
    if (json.containsKey('deliveryDate') && json['deliveryDate'] != null) {
      order.deliveryDate = DateTime.parse(json['deliveryDate']);
    }

    for (var l in list) {
      order.items.add(MenuItem.fromJson(l));
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

  /// Calculates total price of this order.
  /// Total price is equal to sum of price, delivery price and donation.
  void calculateTotalPrice() {
    totalPrice = price + deliveryPrice + donation;
  }

  /// Sets menu items from JSON object.
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

  /// Calculates total weight of this order.
  /// Weight is sum of weights of menu items in this order.
  int calculateWeight() {
    int weight = 0;
    for (MenuItem item in items) {
      if (item.isWholeAnimal) {
        weight += item.weight * item.quantity;
      } else {
        weight += item.quantity;
      }
    }
    return weight;
  }

  /// Calculates price of this order.
  /// Weight is sum of prices of menu items in this order.
  int calculatePrice() {
    int price = 0;
    for (MenuItem item in items) {
      price += item.price * item.quantity;
    }
    this.price = price.toDouble();
    calculateTotalPrice();
    return price;
  }

  /// JSON object from this order.
  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};

    Map<String, int> menuItemsId = {};

    for (MenuItem item in items) {
      menuItemsId[item.id.toString()] = item.quantity;
    }

    json['address'] = {"id": address?.id};
    json['butchery'] = {"id": butchery.id};
    json['charity'] = charity.toString();
    json['menuItemsId'] = menuItemsId;
    json['packages'] = packages;

    json['deliveryDate'] = deliveryDate.millisecondsSinceEpoch;
    json['sender'] = senderName;
    json['totalPrice'] = totalPrice;
    json['deliveryPrice'] = deliveryPrice;
    json['donation'] = donation;
    return json;
  }
}
