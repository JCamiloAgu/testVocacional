import 'dart:convert';

import 'package:testvocacional/src/models/question/answerOptionsStrategy/intereses_answer.dart';
import 'package:testvocacional/src/models/question/question.dart';

Intereses interesesFromJson(String str) => Intereses.fromJson(json.decode(str));

List<Intereses> interesesListFromJson(String str) {
  final intereses = <Intereses>[];
  final interesesResponse = jsonDecode(str)['documents'];

  interesesResponse.forEach((element) {
    intereses.add(interesesFromJson(jsonEncode(element)));
  });

  return intereses;
}

class Intereses {
  Intereses(
      {this.id,
      this.redTecnologica,
      this.campo,
      this.preguntas,
      this.relacionCampos,
      this.tecnologias});

  String id;
  String redTecnologica;
  String campo;
  List<dynamic> preguntas;
  String relacionCampos;
  String tecnologias;

  factory Intereses.fromJson(Map<String, dynamic> json) => Intereses(
      id: json['name'].toString().split('/').last,
      redTecnologica: json['fields']['red-tecnologica']['stringValue'],
      campo: json['fields']['campo']['stringValue'],
      preguntas: json['fields']['preguntas']['arrayValue']['values']
          .map((x) => x['stringValue'])
          .toList(growable: false),
      relacionCampos: json['fields']['relacion-campos']['stringValue'],
      tecnologias: json['fields']['tecnologias']['stringValue']);

  List<Question> toQuestions() => preguntas
      .map((pregunta) =>
          Question(id, pregunta.toString(), InteresesAnswerOptions()))
      .toList();
}
