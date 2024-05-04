class MenuItem {
  final int id;
  final String name;
  final int weight;
  final bool isWholeAnimal;
  String description = '';
  final int categoryId;
  final int price;

  int quantity = 0;

  MenuItem(
      {required this.id,
      required this.name,
      required this.weight,
      required this.isWholeAnimal,
      required this.categoryId,
      required this.price});

  factory MenuItem.fromJson(Map<String, dynamic> json) {
    MenuItem menuItem = MenuItem(
      id: json['id'],
      name: json['name'],
      weight: json['weight'],
      isWholeAnimal: json['isWholeAnimal'],
      categoryId: json['categoryId'],
      price: json['price'],
    );

    if (json.containsKey('description') && json['description'] != null) {
      menuItem.description = json['description'];
    }

    return menuItem;
  }

  void incrimentQuantity() => quantity++;
  void decrementQuantity() => quantity > 0 ? quantity-- : quantity = 0;
}
