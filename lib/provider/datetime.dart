import 'package:flutter/material.dart';

class DatetimeProvider with ChangeNotifier {
  DateTime datetime  = DateTime.now();

  void setDatetime(DateTime newDatetime) {
    print("setDatetime $newDatetime");
    datetime = newDatetime;
    notifyListeners();
  }
}
