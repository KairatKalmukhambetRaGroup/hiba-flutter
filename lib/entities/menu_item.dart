class MenuItem {
  final int id;
  final String name;
  final int weight;
  final bool isWholeAnimal;
  String description = '';
  final int categoryId;
  final int price;
  String? image;

  int quantity = 0;

  MenuItem(
      {required this.id,
      required this.name,
      required this.weight,
      required this.isWholeAnimal,
      required this.categoryId,
      required this.price,
  });

  factory MenuItem.fromJson(Map<String, dynamic> json) {
    MenuItem menuItem = MenuItem(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      weight: json['weight'] ?? 0,
      isWholeAnimal: json['isWholeAnimal'] ?? false,
      categoryId: json['categoryId'] ?? 0,
      price: json['price'] ?? 0,
    );
    if(json.containsKey('image') && json['image'] !=null){
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

  int calculateItemPrice() {
    return price * quantity;
  }

  void incrimentQuantity() => isWholeAnimal
      ? quantity++
      : (quantity == 0 ? quantity += weight : quantity++);
  void decrementQuantity() => quantity > 0
      ? (isWholeAnimal
          ? quantity--
          : (quantity > weight ? quantity-- : quantity = 0))
      : quantity = 0;
}
