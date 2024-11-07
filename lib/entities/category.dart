import 'package:hiba/entities/menu_item.dart';

/// A `Category` object represents a categories of [MenuItem]s.
class Category {
  /// Unique identifier of this category.
  final int id;

  /// Name of this category.
  final String name;

  /// Id of parent category of this category.
  final int? parentCategoryId;

  /// Creates new `Category` instance.
  const Category({required this.id, required this.name, this.parentCategoryId});

  /// Creates new instance of `Category` from JSON object.
  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json['id'],
        name: json['name'],
        parentCategoryId: json['parentCategoryId'],
      );

  @override
  String toString() => name;
}
