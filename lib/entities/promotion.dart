class Promotion {
  final int id;
  final String title;
  final String description;
  final String audience;
  final String image;

  const Promotion({
    required this.id,
    required this.title,
    required this.description,
    required this.audience,
    required this.image,
  });

  factory Promotion.fromJson(Map<String, dynamic> json) => Promotion(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        audience: json["audience"],
        image: json["image"],
      );
}
