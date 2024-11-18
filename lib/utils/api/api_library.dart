// lib/utils/api/api_library.dart
/// {@category API}
library api;

import 'dart:convert';
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';

import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:hiba/pages/chat/chat_library.dart';

import 'package:hiba/entities/entities_library.dart';

part 'auth.dart';
part 'butchery.dart';
part 'chat.dart';
part 'courier.dart';
part 'firebase_api.dart';
part 'location.dart';
part 'orders.dart';
part 'promotion.dart';
part 'category.dart';
