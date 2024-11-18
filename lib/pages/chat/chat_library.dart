/// {@category Chat}
/// The `chat` library provides the implementation for chat-related features,
/// including chat history, support chat, and user interaction.
library chat;

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hiba/core_library.dart';
import 'package:hiba/entities/entities_library.dart';
import 'package:hiba/utils/utils_library.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

import 'package:hiba/utils/api/api_library.dart';

import 'dart:async';

part 'widgets/chat_tile.dart';
part 'support_chat_page.dart';
part 'widgets/chat_message_bubble.dart';
part 'chat_history.dart';
part 'contact_us_page.dart';
