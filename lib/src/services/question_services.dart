import 'package:flutter/cupertino.dart';
import 'package:testvocacional/src/models/aptitudes.dart';
import 'package:testvocacional/src/models/intereses.dart';
import 'package:testvocacional/src/models/question/question.dart';

class QuestionService with ChangeNotifier {
  List<Question> _questions;
  bool _loading = true;
  int page = 0;
  int lastPage;

  bool get loading => _loading;

  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  List<Question> get questions {
    final start = page * 10;
    final end = isLastPage()
        ? _questions.length
        : start + 10;

    var tempQuestions = _questions.sublist(start, end);

    return tempQuestions;
  }

  void mixQuestions(List<Aptitudes> aptitudes, List<Intereses> intereses) {
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

  bool isLastPage() => page == lastPage;
}
