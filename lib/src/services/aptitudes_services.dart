import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:testvocacional/src/globals/environment.dart';
import 'package:testvocacional/src/models/aptitudes.dart';

class AptitudesServices with ChangeNotifier {
  Future<List<Aptitudes>> loadAptitudes() async {
    List<Aptitudes> aptitudes;
    final response =
        await http.get(Environment.apiUrl + 'aptitudes?pageSize=45');

    final statusCode = response.statusCode;

    if (statusCode == 200) {
      aptitudes = aptitudesListFromJson(response.body);
    }

    return aptitudes;
  }
}
