// lib/pages/auth/auth_library.dart
///{@category Auth}
library auth;

import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hiba/providers/providers_library.dart';
import 'package:hiba/utils/api/api_library.dart';
import 'package:hiba/core_library.dart';

import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:provider/provider.dart';

import 'package:hiba/utils/utils_library.dart';

import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:pinput/pinput.dart';
import 'package:url_launcher/url_launcher.dart';

part 'login_page.dart';
part 'register_page.dart';
part 'register_profile.dart';
part 'courier_login.dart';
part 'code_verification_page.dart';
