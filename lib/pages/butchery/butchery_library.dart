library butcheries;

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hiba/components/custom_app_bar.dart';
import 'package:hiba/entities/entities_library.dart';
import 'package:hiba/components/menu_item_tile.dart';
import 'package:hiba/utils/api/api_library.dart';
import 'package:hiba/core_library.dart' show AppColors, AppTheme;

import 'package:flutter_svg/svg.dart';
import 'package:hiba/components/custom_scaffold.dart';
import 'package:intl/intl.dart';

import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

import 'package:hiba/providers/providers_library.dart' show ShoppingBasket;
import 'package:provider/provider.dart';

part 'butchery_page.dart';
part 'butchery_search_page.dart';
part 'butchery_details.dart';
part 'menu_item_page.dart';

///Widgets
part 'widgets/butchery_card.dart';
part 'widgets/butchery_card_small.dart';
