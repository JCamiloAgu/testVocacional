import 'dart:convert';

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
        redTecnologica:json['fields']['red-tecnologica']['stringValue'],
        campo:json['fields']['campo']['stringValue'],
        preguntas: json['fields']['preguntas']['arrayValue']['values'].map((x) => x['stringValue']).toList(growable: false),
        relacionCampos:json['fields']['relacion-campos']['stringValue'],
        tecnologias:json['fields']['tecnologias']['stringValue']
      );
}

// class Intereses {
//   Intereses({
//     this.name,
//     this.fields,
//     this.createTime,
//     this.updateTime,
//   });
//
//   String name;
//   _Fields fields;
//   DateTime createTime;
//   DateTime updateTime;
//
//   factory Intereses.fromJson(Map<String, dynamic> json) => Intereses(
//     name: json["name"],
//     fields: _Fields.fromJson(json["fields"]),
//     createTime: DateTime.parse(json["createTime"]),
//     updateTime: DateTime.parse(json["updateTime"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "name": name,
//     "fields": fields.toJson(),
//     "createTime": createTime.toIso8601String(),
//     "updateTime": updateTime.toIso8601String(),
//   };
// }

class _Fields {
  _Fields({
    this.redTecnologica,
    this.campo,
    this.preguntas,
    this.relacionCampos,
    this.tecnologias,
  });

  _Campo redTecnologica;
  _Campo campo;
  _Preguntas preguntas;
  _Campo relacionCampos;
  _Campo tecnologias;

  factory _Fields.fromJson(Map<String, dynamic> json) => _Fields(
        redTecnologica: _Campo.fromJson(json["red-tecnologica"]),
        campo: _Campo.fromJson(json["campo"]),
        preguntas: _Preguntas.fromJson(json["preguntas"]),
        relacionCampos: _Campo.fromJson(json["relacion-campos"]),
        tecnologias: _Campo.fromJson(json["tecnologias"]),
      );

  Map<String, dynamic> toJson() => {
        "red-tecnologica": redTecnologica.toJson(),
        "campo": campo.toJson(),
        "preguntas": preguntas.toJson(),
        "relacion-campos": relacionCampos.toJson(),
        "tecnologias": tecnologias.toJson(),
      };
}

class _Campo {
  _Campo({
    this.stringValue,
  });

  String stringValue;

  factory _Campo.fromJson(Map<String, dynamic> json) => _Campo(
        stringValue: json["stringValue"],
      );

  Map<String, dynamic> toJson() => {
        "stringValue": stringValue,
      };
}

class _Preguntas {
  _Preguntas({
    this.arrayValue,
  });

  _ArrayValue arrayValue;

  factory _Preguntas.fromJson(Map<String, dynamic> json) => _Preguntas(
        arrayValue: _ArrayValue.fromJson(json["arrayValue"]),
      );

  Map<String, dynamic> toJson() => {
        "arrayValue": arrayValue.toJson(),
      };
}

class _ArrayValue {
  _ArrayValue({
    this.values,
  });

  List<_Campo> values;

  factory _ArrayValue.fromJson(Map<String, dynamic> json) => _ArrayValue(
        values:
            List<_Campo>.from(json["values"].map((x) => _Campo.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "values": List<dynamic>.from(values.map((x) => x.toJson())),
      };
}
