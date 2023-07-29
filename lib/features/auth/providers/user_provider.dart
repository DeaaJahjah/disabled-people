import 'package:disaoled_people/config/enums/enums.dart';
import 'package:disaoled_people/features/auth/models/user.dart';
import 'package:disaoled_people/features/auth/services/user_db_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  DataState dataState = DataState.notSet;

  UserModle? user;

  getUserData() async {
    dataState = DataState.loading;
    notifyListeners();
    user = await UserDbServices().getUser(FirebaseAuth.instance.currentUser!.uid);
    notifyListeners();

    dataState = DataState.notSet;
  }
}
