// lib/pages/courier/courier_library.dart
///{@category Courier}
/// The `courier` library provides functionalities and UI components for courier operations within the app.
library courier;

import 'dart:convert';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hiba/entities/entities_library.dart';
import 'package:hiba/pages/notifications/notifications_library.dart';
import 'package:hiba/utils/api/api_library.dart';

import 'package:flutter_svg/svg.dart';
import 'package:hiba/core_library.dart';
import 'package:pinput/pinput.dart';
import 'package:intl/intl.dart' hide TextDirection;
import 'package:skeletonizer/skeletonizer.dart';
import 'package:hiba/pages/profile/profile_library.dart' show ProfilePage;
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

/// ## Deliveries
part 'deliveries.dart';
part 'delivery.dart';
part 'delivery_history.dart';
part 'delivery_confirm.dart';
part 'butchery_deliveries.dart';
part 'active_deliveries.dart';

/// # Widgets
part 'widgets/courier_navbar.dart';
part 'widgets/delivery_butchery_tile.dart';
part 'widgets/delivery_popup.dart';
part 'widgets/delivery_tile.dart';
part 'widgets/delivery_item.dart';
