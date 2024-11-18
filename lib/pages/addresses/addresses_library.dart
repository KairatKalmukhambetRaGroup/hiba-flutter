/// The `addresses` library is responsible for managing and displaying
/// all pages and widgets related to user addresses within the application.
///
/// This library includes:
/// - The main `AddressesPage` for displaying saved addresses.
/// - `NewAddressPage` for adding new addresses.
/// - `ShowAddresses` widget to display a list of user addresses.
///
/// The library structure is organized for modularity, allowing easy access to
/// components, providers, utilities, and values needed to work with addresses
/// in a unified context.

// lib/pages/addresses/addresses_library.dart
///{@category Profile}
library addresses;

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hiba/core_library.dart';
import 'package:hiba/entities/entities_library.dart';
import 'package:hiba/providers/providers_library.dart';

import 'package:hiba/utils/api/api_library.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:provider/provider.dart';

import 'package:pinput/pinput.dart';

part 'addresses_page.dart';
part 'new_address_page.dart';
part 'widgets/show_addresses.dart';
part 'widgets/address_tile.dart';
