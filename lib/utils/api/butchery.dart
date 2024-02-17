import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:hiba/entities/butchery.dart';

const butcheriesPath = 'assets/butcheries.json';

Future<String> getButcheries() async {
  return await rootBundle.loadString(butcheriesPath).then((file) => file);
}

Future<Butchery?> getButcheryById(String? id) async {
  if (id == null) return null;
  String jsonString =
      await rootBundle.loadString(butcheriesPath).then((file) => file);
  List<Map<String, dynamic>> arr =
      List<Map<String, dynamic>>.from(json.decode(jsonString));

  for (var element in arr) {
    Butchery el = Butchery.fromJson(element);
    if (el.id == int.parse(id)) return el;
  }
  return null;
}
