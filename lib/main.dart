import 'package:disaoled_people/app.dart';
import 'package:disaoled_people/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';

import 'config/utils/shared_pref.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPref.sharedPreferences = await SharedPreferences.getInstance();

  final client = StreamChatClient('wpj6hynwk7zg');
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // await TipsDbServices().addTibs();

  runApp(App(
    client: client,
  ));
}
