import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:testvocacional/src/globals/environment.dart';
import 'package:testvocacional/src/models/intereses.dart';

class InteresesService with ChangeNotifier {
  List<Intereses> _intereses;

  Future<List<Intereses>> loadIntereses() async {
    if (_intereses != null) {
      return _intereses;
    }
    final response =
        await http.get(Environment.apiUrl + 'intereses?pageSize=40');

    final statusCode = response.statusCode;

    if (statusCode == 200) {
      _intereses = interesesListFromJson(response.body);
    }

    _intereses.shuffle();

    return _intereses;
  }

  Intereses getInteresById(String id) =>
      _intereses.firstWhere((interes) => interes.id == id, orElse: () => null);
}
