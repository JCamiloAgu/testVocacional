class Question{
  final String _question;
  final List<String> _answerOptions;

  Question(this._question, this._answerOptions);

  List<String> get answerOptions => _answerOptions;

  String get question => _question;
}