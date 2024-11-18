// lib/pages/profile/profile_library.dart
///{@category Profile}
library profile;

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hiba/components/custom_scaffold.dart';
import 'package:hiba/entities/entities_library.dart';
import 'package:hiba/pages/chat/chat_library.dart' show ContactUsPage;
import 'package:hiba/pages/courier/courier_library.dart' show DeliveryHistory;
import 'package:hiba/pages/addresses/addresses_library.dart' show AddressesPage;
import 'package:hiba/pages/orders/order_library.dart' show OrdersPage;
import 'package:hiba/core_library.dart' show AppColors, AppTheme;

import 'package:hiba/utils/api/api_library.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:provider/provider.dart';

import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import 'package:hiba/components/custom_app_bar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pinput/pinput.dart';

/// ## Pages
part 'profile_page.dart';
part 'user_info_page.dart';
