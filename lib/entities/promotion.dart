/// lib/entities/entities_library.dart
part of 'entities_library.dart';

/// a `Promotion` object represents a promotion news.
class Promotion {
  /// Unique identifier of this promotion.
  final int id;

  /// Title of this promotion.
  final String title;

  /// Description of this promotion.
  final String description;

  /// Audience type of this promotion.
  /// `CLIENT`, `BUTCHERY` or `ALL`.
  final String audience;

  /// A base64-encoded image representing this promotion's image.
  final String image;

  /// Creates new `Promotion` instance.
  const Promotion({
    required this.id,
    required this.title,
    required this.description,
    required this.audience,
    required this.image,
  });

  /// Creates new `Promotion` instance from JSON object.
  factory Promotion.fromJson(Map<String, dynamic> json) => Promotion(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        audience: json["audience"],
        image: json["image"],
      );
}
