import 'dart:async';

import 'package:disaoled_people/config/constants/constant.dart';
import 'package:disaoled_people/config/extensions/firebase.dart';
import 'package:disaoled_people/config/theme/theme.dart';
import 'package:disaoled_people/config/widgets/bg_image.dart';
import 'package:disaoled_people/features/auth/screens/login_screen.dart';
import 'package:disaoled_people/features/home/home_screen.dart';

import 'package:flutter/material.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = '/';
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(const Duration(seconds: 2), () async {
      if (context.currentUser != null) {
        final client = StreamChatCore.of(context).client;
        await client.connectUser(User(id: context.userUid!), context.userToken!);
        Navigator.of(context).pushNamed(HomeScreen.routeName);
      } else {
        Navigator.of(context).pushNamed(LoginScreen.routeName);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          const BgImage(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/logo.png'),
              sizedBoxLarge,
              Text(
                'منتدى ذوي الاحتياجات الخاصة',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              sizedBoxMedium,
              const CircularProgressIndicator(color: primaryColor)
            ],
          ),
        ],
      ),
    );
  }
}
