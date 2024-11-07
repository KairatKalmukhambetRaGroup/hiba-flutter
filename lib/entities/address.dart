import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hiba/entities/location.dart';
import 'package:hiba/entities/user.dart';

/// An `Address` object represents Address of [User]
class Address {
  /// Unique identifier of this object.
  final int id;

  /// Name of this object.
  /// Example: home
  final String name;

  /// Street name of this object.
  final String street;

  /// Building of this object.
  /// Example: 4A
  final String building;

  /// Apartment of this object.
  final String apartment;

  /// Entrance of this object.
  final String entrance;

  /// Floor of this object.
  final String floor;

  /// City of this object
  final City city;

  /// Create new `Address` instance.
  /// All fields are required.
  const Address({
    required this.id,
    required this.name,
    required this.street,
    required this.building,
    required this.apartment,
    required this.entrance,
    required this.floor,
    required this.city,
  });

  /// Creates instance of `Address` from JSIN object.
  factory Address.fromJson(Map<String, dynamic> json) => Address(
        id: json['id'],
        name: json['name'],
        street: json['address'],
        building: json['building'],
        apartment: json['apartment'],
        entrance: json['entrance'],
        floor: json['floor'],
        city: City.fromJson(json['city']),
      );

  /// JSON object from this Address.
  Map<String, String> toJson() {
    Map<String, String> json = {};

    json['id'] = id.toString();
    json['name'] = name;
    json['address'] = street;
    json['building'] = building;
    json['entrance'] = entrance;
    json['apartment'] = apartment;
    json['floor'] = floor;
    json['city_id'] = city.id.toString();

    return json;
  }

  @override
  String toString() {
    return name;
  }

  /// Short info ob this address.
  String get info => 'г.$city, улица $street, дом $building, $apartment';

  /// Icon of Address object, depending on [name]: `home`, `work` or custom.
  static Widget getIconByType(String name) {
    switch (name) {
      case 'home':
        return SvgPicture.asset(
          'assets/svg/address-home-filled.svg',
          width: 36,
        );
      case 'work':
        return SvgPicture.asset(
          'assets/svg/address-work-filled.svg',
          width: 36,
        );
      default:
        return SvgPicture.asset(
          'assets/svg/address-other-filled.svg',
          width: 36,
        );
    }
  }
}
