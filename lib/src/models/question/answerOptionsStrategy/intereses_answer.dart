import 'answer_option_strategy.dart';

class InteresesAnswerOptions implements AnswerOptionStrategy {
  final List<String> _answerOptions = [
    'No',
    'Tengo dudas',
    'Si',
  ];

  @override
  List<String> get answerOptions => _answerOptions;
}
