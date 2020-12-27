import 'package:testvocacional/src/globals/campos.dart';
import 'package:testvocacional/src/globals/relacion_campos.dart';
import 'package:testvocacional/src/globals/tecnologias.dart';
import 'package:testvocacional/src/models/aptitudes.dart';
import 'package:testvocacional/src/models/intereses.dart';
import 'package:testvocacional/src/models/question/question.dart';
import 'package:testvocacional/src/services/aptitudes_services.dart';
import 'package:testvocacional/src/services/intereses_service.dart';

class QuestionResultCalculator {
  final AptitudesServices aptitudesServices;
  final InteresesService interesesService;

  final Map<String, int> _aptitudesResult = {};
  final Map<String, int> _interesesResult = {};

  QuestionResultCalculator(this.aptitudesServices, this.interesesService);

  void calculateAptitudesResult(List<Question> aptitudesQuestion) {
    Campos.ALL_CAMPOS.forEach((campo) {
      _aptitudesResult[campo] =
          _getAptitudAnswerValue(aptitudesQuestion, campo);
    });
  }

  int _getAptitudAnswerValue(List<Question> aptitudesQuestion, String campo) {
    var total = 0;

    for (var aptitudQuestion in aptitudesQuestion) {
      var aptitud = aptitudesServices.getAptitudById(aptitudQuestion.id);

      if (aptitud.campos == campo) {
        if (_isNegativeGrit(aptitud, campo)) {
          total += 5 - aptitudQuestion.value;
          continue;
        }

        total += aptitudQuestion.value;
      }
    }

    return total;
  }

  bool _isNegativeGrit(Aptitudes aptitud, String campo) =>
      campo == Campos.GRIT && aptitud.afirmacion.contains('*');

  Map<String, int> calculateInteresesResult(List<Question> interesesQuestions) {
    Tecnologias.ALL_TECNOLOGIAS.forEach((tecnologia) {
      _interesesResult[tecnologia] =
          _getInteresesAnswerValue(interesesQuestions, tecnologia);
    });

    return _interesesResult;
  }

  int _getInteresesAnswerValue(
      List<Question> interesesQuestions, String tecnologia) {
    var tecnologiasValue = 0;

    Intereses interesForCalculateRelacionCampos;

    interesesQuestions.forEach((interesQuestion) {
      final interes = interesesService.getInteresById(interesQuestion.id);

      if (interes.tecnologias == tecnologia) {
        interesForCalculateRelacionCampos = interes;
        tecnologiasValue += interesQuestion.value * 10;
      }
    });

    tecnologiasValue +=
        _calculateRelacionCampos(interesForCalculateRelacionCampos);

    return tecnologiasValue;
  }

  int _calculateRelacionCampos(Intereses interes) {
    final relacionCampos =
        RelacionCampos.relacionCampos[interes.relacionCampos];

    final campo1 = relacionCampos.split('/')[0];
    final campo2 = relacionCampos.split('/')[1];

    return _aptitudesResult[campo1] + _aptitudesResult[campo2];
  }

  int getGritValue() => _aptitudesResult[Campos.GRIT];
}
