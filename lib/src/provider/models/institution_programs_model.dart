import 'package:flutter/material.dart';

class InstitutionProgramsModel with ChangeNotifier {
  final _cditiPrograms = [
    'CDITI 1',
    'CDITI 2',
    'CDITI 3',
    'CDITI 4',
    'CDITI 5',
  ];

  final _comercioYServiciosPrograms = [
    'ComercioYServicios 1',
    'ComercioYServicios 2',
    'ComercioYServicios 3',
    'ComercioYServicios 4',
    'ComercioYServicios 5',
  ];

  final _agropecuarioPrograms = [
    'Agropecuario 1',
    'Agropecuario 2',
    'Agropecuario 3',
    'Agropecuario 4',
    'Agropecuario 5',
  ];

  InstitutionProgramsModel() {
    _programs = _cditiPrograms;
  }

  List<String> _programs;

  List<String> getPrograms() => _programs;

  set programs(int institutionId) {
    switch (institutionId) {
      case 1:
        _programs = _cditiPrograms;
        break;
      case 2:
        _programs = _comercioYServiciosPrograms;
        break;
      case 3:
        _programs = _agropecuarioPrograms;
        break;
    }

    notifyListeners();
  }
}
