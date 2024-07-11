import 'package:hiba/entities/butchery_category.dart';
import 'package:hiba/entities/location.dart';
import 'package:hiba/entities/working_hour.dart';

class Butchery {
  final int id;
  final String name;
  final String address;
  final double latitude;
  final double longitude;
  final City? city;
  final String? image;
  late List<ButcheryCategory> categories;
  List<WorkingHour>? workingHours;
  String? phone;

  Butchery(
      {required this.id,
      required this.name,
      required this.address,
      required this.latitude,
      required this.longitude,
      required this.city,
      required this.image});

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

// {
//   "id": 2,
//   "name": "John's Butchery",
//   "latitude": 105,
//   "longitude": 105,
//   "address": "г. Алматы",
//   "city": {
//     "id": 2,
//     "name": "Almaty",
//     "region": null,
//     "country": {
//       "id": 1,
//       "name": "Kazakhstan"
//     }
//   },
//   "categories": [
//     {
//       "id": 3,
//       "category": {
//         "id": 2,
//         "name": "cow",
//         "parentCategoryId": null
//       },
//       "menuItems": [
//         {
//           "id": 4,
//           "name": "Omyrtqa",
//           "weight": 1,
//           "isWholeAnimal": false,
//           "butcheryCategoryId": 3,
//           "categoryId": 6
//         }
//       ]
//     },
//     {
//       "id": 4,
//       "category": {
//         "id": 1,
//         "name": "horse",
//         "parentCategoryId": null
//       },
//       "menuItems": [
//         {
//           "id": 3,
//           "name": "Omyrtqa",
//           "weight": 1,
//           "isWholeAnimal": false,
//           "butcheryCategoryId": 4,
//           "categoryId": 1
//         }
//       ]
//     }
//   ]
// }