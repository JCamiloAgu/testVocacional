import 'package:flutter/cupertino.dart';
import 'package:testvocacional/src/models/aptitudes.dart';
import 'package:testvocacional/src/models/intereses.dart';
import 'package:testvocacional/src/models/question/answerOptionsStrategy/aptitudes_answer.dart';
import 'package:testvocacional/src/models/question/answerOptionsStrategy/intereses_answer.dart';
import 'package:testvocacional/src/models/question/question.dart';
import 'package:testvocacional/src/services/question/question_result_calculator.dart';

class QuestionService with ChangeNotifier {
  List<Question> _questions;
  int page = 0;
  int lastPage;

  Map<String, int> result = {};

  bool _loading = true;

  bool get loading => _loading;

  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  int _gritValue;

  int get gritValue => _gritValue;

  List<Question> get questions {
    final start = page * 10;
    final end = isLastPage() ? _questions.length : start + 10;

    var tempQuestions = _questions.sublist(start, end);

    return tempQuestions;
  }

  void mixQuestions(List<Aptitudes> aptitudes, List<Intereses> intereses) {
    if (_questions != null) return;

    _questions = <Question>[];

    _questions
        .addAll(aptitudes.map((Aptitudes aptitud) => aptitud.toQuestion()));

    _questions.addAll(_getInteresesQuestions(intereses));

    setLastPage();

    loading = false;
  }

  List<Question> _getInteresesQuestions(List<Intereses> intereses) {
    final interesesQuestions = <Question>[];

    intereses.forEach((interes) {
      interesesQuestions.addAll(interes.toQuestions());
    });

    return interesesQuestions;
  }

  void setLastPage() {
    lastPage = (_questions.length / 10).floor();
  }

  void addPage() {
    page++;
    notifyListeners();
  }

  void decreasePage() {
    page--;
    notifyListeners();
  }

  void editQuestion(int index, Question question) {
    _questions[index + page * 10] = question;
    notifyListeners();
  }

  bool isLastPage() => page == lastPage;

  bool isValidAllQuestions() =>
      !questions.any((element) => element.value == null);

  void calculateResults(QuestionResultCalculator questionResultCalculator) {
    final aptitudes = _questions
        .where((question) => question.answerOption is AptitudesAnswerOptions)
        .toList();

    final intereses = _questions
        .where((question) => question.answerOption is InteresesAnswerOptions)
        .toList();

    questionResultCalculator.calculateAptitudesResult(aptitudes);
    result = questionResultCalculator.calculateInteresesResult(intereses);
    _gritValue = questionResultCalculator.getGritValue();
  }
}
