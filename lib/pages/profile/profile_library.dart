// lib/pages/profile/profile_library.dart
///{@category Profile}
library profile;

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hiba/components/custom_scaffold.dart';
import 'package:hiba/entities/entities_library.dart';
import 'package:hiba/pages/contact_us_page.dart';
import 'package:hiba/pages/courier/delivery_history.dart';
import 'package:hiba/pages/addresses/addresses_library.dart' show AddressesPage;
import 'package:hiba/pages/orders/order_library.dart' show OrdersPage;
import 'package:hiba/pages/profile/user_info_page.dart';
import 'package:hiba/values/app_colors.dart';
import 'package:hiba/values/app_theme.dart';

import 'package:hiba/utils/api/api_library.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:provider/provider.dart';

part 'profile_page.dart';
