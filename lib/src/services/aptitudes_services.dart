import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:testvocacional/src/globals/environment.dart';
import 'package:testvocacional/src/models/aptitudes.dart';

class AptitudesServices with ChangeNotifier {
  List<Aptitudes> _aptitudes;

  List<Aptitudes> get aptitudes => _aptitudes;

  Future<List<Aptitudes>> loadAptitudes() async {
    if (_aptitudes != null) {
      return _aptitudes;
    }
    final response =
        await http.get(Environment.apiUrl + 'aptitudes?pageSize=45');

    final statusCode = response.statusCode;

    if (statusCode == 200) {
      _aptitudes = aptitudesListFromJson(response.body);
    }

    _aptitudes.shuffle();

    return _aptitudes;
  }

  Aptitudes getAptitudById(String id) =>
      _aptitudes.firstWhere((aptitud) => aptitud.id == id, orElse: () => null);
}
