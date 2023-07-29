import 'package:disaoled_people/config/enums/enums.dart';
import 'package:flutter/material.dart';

class AuthSataProvider extends ChangeNotifier {
  AuthState authState = AuthState.notSet;

  changeAuthState({required AuthState newState}) {
    authState = newState;
    notifyListeners();
  }
}
