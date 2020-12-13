import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:testvocacional/src/globals/environment.dart';
import 'package:testvocacional/src/models/intereses.dart';

class InteresesService with ChangeNotifier {
  bool _loading = true;
  List<Intereses> intereses;
  int statusCode;

  bool get loading => _loading;

  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  void loadIntereses() async {
    loading = true;

    final response =
        await http.get(Environment.apiUrl + 'intereses?pageSize=40');

    statusCode = response.statusCode;

    if (statusCode == 200) {
      intereses = interesesListFromJson(response.body);
      print(intereses);
    }

    loading = false;
  }
}
