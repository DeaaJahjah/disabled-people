import 'package:flutter/cupertino.dart';

class DownloadStateProvider extends ChangeNotifier {
  double state = 0;

  updateState(double state) {
    this.state = state;
    notifyListeners();
  }
}
