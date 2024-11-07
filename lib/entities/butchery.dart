import 'package:hiba/entities/butchery_category.dart';
import 'package:hiba/entities/location.dart';
import 'package:hiba/entities/user.dart';
import 'package:hiba/entities/working_hour.dart';

/// A `Butchery` object represents a butchery with specific details.
/// Company selling products is named as `Butchery`
class Butchery {
  /// Unique identifier of this butchery.
  final int id;

  /// Name of this butchery.
  final String name;

  /// Addres of this butchery.
  final String address;

  /// Latitude of address of this butchery.
  final double latitude;

  /// Longitude of address of this butchery.
  final double longitude;

  /// City of this butchery.
  final City? city;

  /// A base64-encoded image representing this butchery's image.
  final String? image;

  /// List of `Categories` of this `Butchery`.
  late List<ButcheryCategory> categories;

  ///List of `WorkingHours` of this `Butchery`.
  List<WorkingHour>? workingHours;

  /// Phone of this butchery.
  String? phone;

  /// Count of orders plased by [User] to this butchery.
  int ordersCount = 0;

  /// Creates new `Butchery` instance.
  Butchery(
      {required this.id,
      required this.name,
      required this.address,
      required this.latitude,
      required this.longitude,
      required this.city,
      required this.image});

  /// Creates new instance of `Butchery` from JSON object.
  factory Butchery.fromJson(Map<String, dynamic> json) {
    Butchery butchery = Butchery(
        id: json["id"],
        name: json["name"],
        address: json["address"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        city: City.fromJson(json['city']),
        image: json["image"]);
    if (json["categories"] != null) {
      butchery.categories = (json["categories"] as List)
          .map((el) => ButcheryCategory.fromJson(el))
          .toList();
    }

    return butchery;
  }

  @override
  String toString() {
    return '$name: $address';
  }
}
