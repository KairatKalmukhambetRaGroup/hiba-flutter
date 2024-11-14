// lib/core_library.dart
///{@category Core}
library hibacore;

import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hiba/entities/entities_library.dart';
import 'package:hiba/utils/api/api_library.dart';
import 'package:stomp_dart_client/stomp_dart_client.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/material.dart';
import 'package:hiba/pages/splash_page.dart';
import 'package:hiba/pages/support_chat_page.dart';
import 'package:hiba/providers/providers_library.dart';
import 'package:hiba/utils/utils_library.dart';
import 'package:hiba/values/app_strings.dart';
import 'package:hiba/values/app_theme.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

part 'web_socket_service.dart';
part 'firebase_options.dart';
part 'main.dart';
