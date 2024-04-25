import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hiba/entities/location.dart';

class Address {
  final int id;
  final String name;
  final String address;
  final String building;
  final String apartment;
  final String entrance;
  final String floor;
  final City city;

  const Address({
    required this.id,
    required this.name,
    required this.address,
    required this.building,
    required this.apartment,
    required this.entrance,
    required this.floor,
    required this.city,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        id: json['id'],
        name: json['name'],
        address: json['address'],
        building: json['building'],
        apartment: json['apartment'],
        entrance: json['entrance'],
        floor: json['floor'],
        city: City.fromJson(json['city']),
      );

  Map<String, String> toJson() {
    Map<String, String> json = {};

    json['id'] = id.toString();
    json['name'] = name;
    json['address'] = address;
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

  String get info => 'г.$city, улица $address, дом $building, $apartment';

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
