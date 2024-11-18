// lib/core_library.dart
///{@category Core}
library hibacore;

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hiba/entities/entities_library.dart';
import 'package:hiba/utils/api/api_library.dart';
import 'package:stomp_dart_client/stomp_dart_client.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

part 'web_socket_service.dart';
part 'firebase_options.dart';

/// Custom App Values
part 'values/app_colors.dart';
part 'values/app_regex.dart';
part 'values/app_strings.dart';
part 'values/app_theme.dart';
