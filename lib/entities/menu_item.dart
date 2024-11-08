/// lib/entities/entities_library.dart
part of 'entities_library.dart';

/// A `MenuItem` object represents a menu item of [ButcheryCategory].
class MenuItem {
  /// Unique identifier of this menu item.
  final int id;

  /// Name of this menu item.
  final String name;

  /// Weight of this menu item.
  /// Weight can be represented as minimal weight to order menu item or weight of ordered item.
  final int weight;

  /// Whether menu item is whole animal body or part of it.
  final bool isWholeAnimal;

  /// Description of a menu item.
  String description = '';

  /// [Category] id of a menu item.
  final int categoryId;

  /// Price of one of this menu item.
  final int price;

  /// A base64-encoded image representing this menu item's image.
  String? image;

  /// Quantity of ordered menu items.
  int quantity = 0;

  /// Creates new instance of `MenuItem`.
  MenuItem({
    required this.id,
    required this.name,
    required this.weight,
    required this.isWholeAnimal,
    required this.categoryId,
    required this.price,
  });

  /// Creates new instance of `MenuItem` from JSON object.
  factory MenuItem.fromJson(Map<String, dynamic> json) {
    MenuItem menuItem = MenuItem(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      weight: json['weight'] ?? 0,
      isWholeAnimal: json['isWholeAnimal'] ?? false,
      categoryId: json['categoryId'] ?? 0,
      price: json['price'] ?? 0,
    );
    if (json.containsKey('image') && json['image'] != null) {
      menuItem.image = json['image'];
    }

    if (json.containsKey('description') && json['description'] != null) {
      menuItem.description = json['description'];
    }
    if (json.containsKey('quantity') && json['quantity'] != null) {
      menuItem.quantity = json['quantity'];
    }

    return menuItem;
  }

  /// Total price of this menu item based on quantity.
  int calculateItemPrice() {
    return price * quantity;
  }

  /// Increment quantity of this menu item.
  void incrimentQuantity() => isWholeAnimal
      ? quantity++
      : (quantity == 0 ? quantity += weight : quantity++);

  /// Decrement quantity of this menu item.
  void decrementQuantity() => quantity > 0
      ? (isWholeAnimal
          ? quantity--
          : (quantity > weight ? quantity-- : quantity = 0))
      : quantity = 0;
}
