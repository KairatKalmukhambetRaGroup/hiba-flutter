import 'package:hiba/entities/category.dart';
import 'package:hiba/entities/menu_item.dart';

class ButcheryCategory {
  final int id;
  final String name;
  final List<MenuItem> menuItems;

  const ButcheryCategory({
    required this.id,
    required this.name,
    required this.menuItems,
  });

  factory ButcheryCategory.fromJson(Map<String, dynamic> json) =>
      ButcheryCategory(
        id: json['id'],
        name: Category.fromJson(json['category']).name,
        menuItems: (json['menuItems'] as List)
            .map((e) => MenuItem.fromJson(e))
            .toList(),
      );
}
