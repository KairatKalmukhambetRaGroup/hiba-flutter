/// lib/entities/entities_library.dart
part of 'entities_library.dart';

/// `ButcheryCategory` object representation of [Butchery]'s [Category].
class ButcheryCategory {
  /// The unique identifier of this object.
  final int id;

  /// The name of this object.
  final String name;

  /// List of [MenuItem]s.
  final List<MenuItem> menuItems;

  /// Creates new `ButcheryCategory` instance.
  /// All fields are required.
  const ButcheryCategory({
    required this.id,
    required this.name,
    required this.menuItems,
  });

  /// Creates new instance of `ButcheryCategory` from JSON object.
  factory ButcheryCategory.fromJson(Map<String, dynamic> json) =>
      ButcheryCategory(
        id: json['id'],
        name: Category.fromJson(json['category']).name,
        menuItems: (json['menuItems'] as List)
            .map((e) => MenuItem.fromJson(e))
            .toList(),
      );
}
