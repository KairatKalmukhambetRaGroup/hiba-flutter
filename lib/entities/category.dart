class Category {
  final int id;
  final String name;
  final int? parentCategoryId;

  const Category({required this.id, required this.name, this.parentCategoryId});

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json['id'],
        name: json['name'],
        parentCategoryId: json['parentCategoryId'],
      );

  @override
  String toString() => name;
}
