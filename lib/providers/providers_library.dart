// lib/providers/providers_library.dart
/// {@category Provider}
library providers;

import 'dart:async';
import 'dart:io';
import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

import 'package:hiba/entities/address.dart';
import 'package:hiba/entities/butchery.dart';
import 'package:hiba/entities/menu_item.dart';
import 'package:hiba/entities/order.dart';
import 'package:hiba/entities/chat_message.dart';

part 'address_state.dart';
part 'chat_provider.dart';
part 'google_sign_in_provider.dart';
part 'shopping_basket.dart';
part 'user_connection_state.dart';
