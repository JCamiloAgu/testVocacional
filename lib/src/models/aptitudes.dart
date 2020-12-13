import 'dart:convert';

import 'package:testvocacional/src/models/question/answerOptionsStrategy/aptitudes_answer.dart';
import 'package:testvocacional/src/models/question/question.dart';

Aptitudes aptitudesFromJson(String str) => Aptitudes.fromJson(json.decode(str));

List<Aptitudes> aptitudesListFromJson(String str) {
  final aptitudes = <Aptitudes>[];
  final aptitudesResponse = jsonDecode(str)['documents'];

  aptitudesResponse.forEach((element) {
    aptitudes.add(aptitudesFromJson(jsonEncode(element)));
  });

  return aptitudes;
}

class Aptitudes {
  Aptitudes({
    this.name,
    this.id,
    this.afirmacion,
    this.campos,
  });

  String name;
  String id;
  String afirmacion;
  String campos;

  factory Aptitudes.fromJson(Map<String, dynamic> json) => Aptitudes(
      id: json['name'].toString().split('/').last,
      afirmacion: json['fields']['afirmacion']['stringValue'],
      campos: json['fields']['campo']['stringValue']);

  Question toQuestion() => Question(id, afirmacion, AptitudesAnswerOptions());
}
