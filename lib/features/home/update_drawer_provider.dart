import 'package:flutter/material.dart';

class UpdateDrawerProvider extends ChangeNotifier {
  int key = DateTime.now().microsecond;

  changeKey() {
    key = DateTime.now().microsecond + DateTime.now().millisecond + DateTime.now().minute;
    notifyListeners();
  }
}
