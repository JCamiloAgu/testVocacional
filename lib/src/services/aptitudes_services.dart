import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:testvocacional/src/globals/environment.dart';
import 'package:testvocacional/src/models/aptitudes.dart';

class AptitudesServices with ChangeNotifier {
  bool _loading;
  List<Aptitudes> aptitudes;
  int statusCode;

  bool get loading => _loading;

  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  void loadAptitudes() async {
    loading = true;

    final response =
        await http.get(Environment.apiUrl + 'aptitudes?pageSize=45');

    statusCode = response.statusCode;

    if (statusCode == 200) {
      aptitudes = aptitudesListFromJson(response.body);
    }

    loading = false;
  }
}
