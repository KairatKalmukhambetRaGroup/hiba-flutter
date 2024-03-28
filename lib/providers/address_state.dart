import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hiba/entities/address.dart';

class AddressState extends ChangeNotifier {
  static const storage = FlutterSecureStorage();
  Address? _currentAddress;

  Address? get currentAddress => _currentAddress;

  List<Address>? _addresses;

  List<Address>? get addresses => _addresses;

  Future<void> addAddress() async {}
  Future<Address?> getCurrentAddress() async {
    if (_currentAddress != null) return _currentAddress;

    String? currentAddressString = await storage.read(key: 'currentAddress');
    if (currentAddressString == null) return null;

    Map<String, dynamic> data = json.decode(currentAddressString);
    _currentAddress = Address.fromJson(data);
    notifyListeners();
    return _currentAddress;
  }

  Future<List<Address>?> getAddresses() async {
    if (_addresses != null) return _addresses;

    String? addressesString = await storage.read(key: 'addresses');
    if (addressesString == null) return null;

    List<Map<String, dynamic>> data = json.decode(addressesString);
    List<Address> list = List.empty(growable: true);
    for (var el in data) {
      list.add(Address.fromJson(el));
    }
    _addresses = list;
    notifyListeners();
    return _addresses;
  }
}
