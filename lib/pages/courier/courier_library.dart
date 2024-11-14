// lib/pages/courier/courier_library.dart
///{@category Courier}
library courier;

import 'dart:convert';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hiba/components/custom_refresher.dart';
import 'package:hiba/components/custom_scaffold.dart';
import 'package:hiba/entities/entities_library.dart';
import 'package:hiba/utils/api/api_library.dart';
import 'package:hiba/values/app_colors.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hiba/components/custom_app_bar.dart';
import 'package:hiba/values/app_theme.dart';
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
part 'widgets/courier_notifications.dart';
part 'widgets/courier_navbar.dart';
part 'widgets/delivery_butchery_tile.dart';
part 'widgets/delivery_popup.dart';
part 'widgets/delivery_tile.dart';
