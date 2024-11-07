import 'package:hiba/entities/butchery.dart';

/// A `ButcherySmall` object represents a [Butchery] with only id and name.
class ButcherySmall {
  final int id;
  final String name;

  const ButcherySmall({
    required this.id,
    required this.name,
  });

  factory ButcherySmall.fromJson(Map<String, dynamic> json) => ButcherySmall(
        id: json["id"],
        name: json["name"],
      );

  @override
  String toString() => name;
}
