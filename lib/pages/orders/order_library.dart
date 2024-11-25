///{@category Orders}
/// The `order` library provides functionalities and UI components related to order management within the app.
library order;

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hiba/entities/entities_library.dart';
import 'package:hiba/pages/butchery/butchery_library.dart';
import 'package:hiba/utils/api/api_library.dart';
import 'package:hiba/core_library.dart';

import 'package:hiba/pages/addresses/addresses_library.dart' show ShowAddresses;
import 'package:hiba/providers/providers_library.dart';
import 'package:hiba/utils/utils_library.dart';
import 'package:intl/intl.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:provider/provider.dart';

import 'package:carousel_slider_plus/carousel_slider_plus.dart';

/// ## Pages
part 'order_page.dart';
part 'order_confirm_page.dart';
part 'orders_page.dart';
part 'basket_page.dart';

/// ## Widgets
part 'widgets/order_card.dart';
part 'widgets/order_menu_item_tile.dart';
part 'widgets/active_orders.dart';
part 'widgets/menu_item_tile.dart';
