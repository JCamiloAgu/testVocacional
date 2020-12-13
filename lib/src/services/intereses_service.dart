import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:testvocacional/src/globals/environment.dart';
import 'package:testvocacional/src/models/intereses.dart';

class InteresesService with ChangeNotifier {

  Future<List<Intereses>> loadIntereses() async {
    List<Intereses> intereses;

    final response =
        await http.get(Environment.apiUrl + 'intereses?pageSize=40');

    final statusCode = response.statusCode;

    if (statusCode == 200) {
      intereses = interesesListFromJson(response.body);
      print(intereses);
    }

    return intereses;
  }
}
