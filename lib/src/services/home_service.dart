import 'package:flutter/material.dart';

class HomeService with ChangeNotifier{
  bool _haveStoragePermission = false;

  bool get haveStoragePermission => _haveStoragePermission;

  set haveStoragePermission(bool value) {
    _haveStoragePermission = value;
    notifyListeners();
  }
}