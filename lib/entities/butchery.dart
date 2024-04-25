import 'package:hiba/entities/butchery_category.dart';
import 'package:hiba/entities/location.dart';

class Butchery {
  final int id;
  final String name;
  final String address;
  final double latitude;
  final double longitude;
  final City city;
  final List<ButcheryCategory> categories;

  const Butchery({
    required this.id,
    required this.name,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.city,
    required this.categories,
  });

  factory Butchery.fromJson(Map<String, dynamic> json) {
    return Butchery(
      id: json["id"],
      name: json["name"],
      address: json["address"],
      latitude: json["latitude"],
      longitude: json["longitude"],
      city: City.fromJson(json['city']),
      categories: (json["categories"] as List<Map<String, dynamic>>)
          .map((el) => ButcheryCategory.fromJson(el))
          .toList(),
    );
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