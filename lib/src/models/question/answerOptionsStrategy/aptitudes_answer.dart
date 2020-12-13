import 'answer_option_strategy.dart';

class AptitudesAnswerOptions implements AnswerOptionStrategy {
  final List<String> _answerOptions = [
    'No se parece en nada a mí',
    'Poco parecido a mí',
    'Algo parecido a mí',
    'Bastante parecido a mí',
    'Totalmente parecido a mí',
  ];

  @override
  List<String> get answerOptions => _answerOptions;
}
