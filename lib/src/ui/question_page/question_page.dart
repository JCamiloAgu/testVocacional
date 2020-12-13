import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:testvocacional/src/models/question/question.dart';
import 'package:testvocacional/src/services/aptitudes_services.dart';
import 'package:testvocacional/src/services/intereses_service.dart';
import 'package:testvocacional/src/services/question_services.dart';
import 'package:testvocacional/src/ui/question_page/answer_options_radio_buttons.dart';
import 'package:testvocacional/src/ui/results/results_page.dart';
import 'package:testvocacional/src/ui/widgets/buttons.dart';

class QuestionPage extends StatefulWidget {
  static const ROUTE_NAME = 'questions';

  @override
  _QuestionPageState createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  QuestionService _questionService;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _loadQuestions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _questionService = Provider.of<QuestionService>(context);

    return Scaffold(
        appBar: AppBar(title: Text('Preguntas')),
        body: _questionService.loading
            ? Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  progressIndicador(),
                  Expanded(
                    child: ListView.separated(
                        itemCount: _questionService.questions.length,
                        controller: _scrollController,
                        physics: AlwaysScrollableScrollPhysics(),
                        itemBuilder: (context, position) => _questionModel(
                            _questionService.questions[position], position),
                        separatorBuilder: (BuildContext context, int index) =>
                            Divider(
                              thickness: 1.0,
                            )),
                  ),
                  _bottomButtons(),
                ],
              ));
  }

  Widget _questionModel(Question question, int position) {
    return Column(
      children: [
        _questionText(question, position),
        AnswerOptionsRadioButtons(question.answerOptions)
      ],
    );
  }

  Widget _questionText(Question question, int position) {
    final questionNumber = _questionService.page * 10 + position + 1;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(questionNumber.toString() + ') ' + question.question,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800)),
      ),
    );
  }

  Widget _nextButton() {
    return Container(
        alignment: AlignmentDirectional.bottomEnd,
        child: SubmitButton(
          onPressed: () =>
              _questionService.isLastPage() ? _submit() : _addPage(),
          width: MediaQuery.of(context).size.width * 0.35,
          label: 'Siguiente',
          withIcon: false,
          padding: EdgeInsets.all(4),
        ));
  }

  void _submit() {
    Navigator.pushNamed(context, ResultsPage.ROUTE_NAME);
  }

  Widget _backButton(BuildContext context) {
    return Container(
        alignment: AlignmentDirectional.bottomStart,
        child: SubmitButton(
          onPressed: () => _questionService.page == 0
              ? Navigator.pop(context)
              : _decreasePage(),
          width: MediaQuery.of(context).size.width * 0.35,
          label: 'Atrás',
          withIcon: false,
          padding: EdgeInsets.all(4),
        ));
  }

  Widget _bottomButtons() {
    return Row(
      children: [
        _backButton(context),
        Expanded(
          child: Container(),
        ),
        _nextButton(),
      ],
    );
  }

  void _loadQuestions() async {
    final questionService =
        Provider.of<QuestionService>(context, listen: false);
    final aptitudesService =
        Provider.of<AptitudesServices>(context, listen: false);
    final interesesService =
        Provider.of<InteresesService>(context, listen: false);

    final aptitudes = await aptitudesService.loadAptitudes();
    final intereses = await interesesService.loadIntereses();

    questionService.mixQuestions(aptitudes, intereses);
  }

  void _addPage() {
    _questionService.addPage();
    _scrollController.animateTo(
      0,
      curve: Curves.easeOut,
      duration: const Duration(milliseconds: 100),
    );
  }

  void _decreasePage() {
    _questionService.decreasePage();
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      curve: Curves.easeOut,
      duration: const Duration(milliseconds: 100),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Widget progressIndicador() {
    return LinearPercentIndicator(
      percent: _questionService.page / _questionService.lastPage,
      progressColor: Colors.black,
      padding: EdgeInsets.symmetric(vertical: 2),
    );
  }
}
