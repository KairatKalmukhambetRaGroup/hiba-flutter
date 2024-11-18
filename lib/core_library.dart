// lib/core_library.dart
///{@category Core}
library hibacore;

import 'dart:convert';

import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hiba/entities/entities_library.dart';
import 'package:hiba/pages/auth/auth_library.dart';
import 'package:hiba/pages/courier/courier_library.dart';
import 'package:hiba/pages/profile/profile_library.dart';
import 'package:hiba/utils/api/api_library.dart';
import 'package:provider/provider.dart';
import 'package:stomp_dart_client/stomp_dart_client.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:carousel_slider_plus/carousel_slider_plus.dart';

import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

import 'package:hiba/pages/orders/order_library.dart'
    show ActiveOrders, BasketPage;
import 'package:hiba/pages/addresses/addresses_library.dart' show ShowAddresses;
import 'package:hiba/providers/providers_library.dart';
import 'package:hiba/pages/butchery/butchery_library.dart'
    show ButcherySearchPage;

/// Pages
part 'pages/home_page.dart';
part 'pages/promotion_page.dart';
part 'pages/splash_page.dart';

/// Services
part 'web_socket_service.dart';
part 'firebase_options.dart';

/// Custom App Values
part 'values/app_colors.dart';
part 'values/app_regex.dart';
part 'values/app_strings.dart';
part 'values/app_theme.dart';

/// Components
part 'components/app_text_form_field.dart';
part 'components/custom_app_bar.dart';
part 'components/custom_refresher.dart';
part 'components/custom_scaffold.dart';
part 'components/promotion_carousel.dart';
part 'components/client_navbar.dart';
