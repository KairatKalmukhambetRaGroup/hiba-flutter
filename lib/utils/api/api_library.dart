// lib/utils/api/api_library.dart
/// {@category API}
library api;

import 'dart:convert';
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hiba/entities/user.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';

import 'package:hiba/entities/promotion.dart';

import 'package:hiba/entities/order.dart';

import 'package:hiba/entities/address.dart';
import 'package:hiba/entities/location.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:hiba/entities/butchery.dart';

import 'package:hiba/entities/chat_message.dart';
import 'package:hiba/entities/hiba_chat.dart';
import 'package:hiba/pages/support_chat_page.dart';

import 'package:hiba/entities/butchery_category.dart';
import 'package:hiba/entities/working_hour.dart';

part 'auth.dart';
part 'butchery.dart';
part 'chat.dart';
part 'courier.dart';
part 'firebase_api.dart';
part 'location.dart';
part 'orders.dart';
part 'promotion.dart';
