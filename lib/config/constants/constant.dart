import 'package:disaoled_people/config/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

const sizedBoxSmall = SizedBox(height: 10);

const sizedBoxMedium = SizedBox(height: 20);

const sizedBoxLarge = SizedBox(height: 30);

const double borderRadius = 10.0;

// const sizedBoxXLarge = SizedBox(height: 50);

// const paddingLR = 10.0;
// const paddingTB = 12.0;

StreamChatThemeData streamChatTheme = StreamChatThemeData(
  colorTheme:
      StreamColorTheme.dark(accentPrimary: primaryColor, appBg: white, barsBg: white, overlayDark: primaryColor),
  messageInputTheme: const StreamMessageInputThemeData(
    actionButtonColor: primaryColor,
    sendButtonColor: primaryColor,
  ),
  otherMessageTheme: const StreamMessageThemeData(messageBackgroundColor: primaryColor),
  channelListViewTheme: const StreamChannelListViewThemeData(backgroundColor: white),
);
