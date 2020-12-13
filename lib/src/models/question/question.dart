import 'answerOptionsStrategy/answer_option_strategy.dart';

class Question {
  final String _id;
  final String _question;
  final AnswerOptionStrategy _answerOption;

  Question(this._id, this._question, this._answerOption);

  String get id => _id;

  String get question => _question;

  List<String> get answerOptions => _answerOption.answerOptions;
}
