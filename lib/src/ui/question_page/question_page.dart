import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:testvocacional/src/models/question.dart';
import 'package:testvocacional/src/ui/question_page/answer_options_radio_buttons.dart';
import 'package:testvocacional/src/ui/results/results_page.dart';
import 'package:testvocacional/src/ui/widgets/buttons.dart';

class QuestionPage extends StatelessWidget {
  static const ROUTE_NAME = 'questions';

  final List<Question> questions = [
    Question(
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent tincidunt mi sit amet turpis dapibus pulvinar. Donec placerat mauris nisi, vel mattis nisi accumsan in. Sed at urna ultrices',
        ['Opción 1', 'Opción 2', 'Opción 3', 'Opción 4']),
    Question(
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent tincidunt mi sit amet turpis dapibus pulvinar. Donec placerat mauris nisi, vel mattis nisi accumsan in. Sed at urna ultrices',
        ['Opción 1', 'Opción 2', 'Opción 3', 'Opción 4']),
    Question(
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent tincidunt mi sit amet turpis dapibus pulvinar. Donec placerat mauris nisi, vel mattis nisi accumsan in. Sed at urna ultrices',
        ['Opción 1', 'Opción 2', 'Opción 3']),
    Question(
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent tincidunt mi sit amet turpis dapibus pulvinar. Donec placerat mauris nisi, vel mattis nisi accumsan in. Sed at urna ultrices',
        [
          'Opción 1',
          'Opción 2',
          'Opción 3',
          'Opción 4',
          'Opción 5',
        ]),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Preguntas')),
        body: Column(
          children: [
            Expanded(
              child: ListView.separated(
                  itemCount: questions.length,
                  physics: AlwaysScrollableScrollPhysics(),
                  itemBuilder: (context, position) => _questionModel(position),
                  separatorBuilder: (BuildContext context, int index) => Divider(
                        thickness: 1.0,
                      )),
            ),
            _bottomButtons(context),
          ],
        ));
  }

  Widget _questionModel(int position) {
    return Column(
      children: [
        _question(questions[position].question, position),
        AnswerOptionsRadioButtons(questions[position].answerOptions)
      ],
    );
  }

  Widget _question(String question, int position) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text((position + 1).toString() + ') ' + question,
          style: TextStyle(fontSize: 16)),
    );
  }

  Widget _nextButton(BuildContext context) {
    return Container(
        alignment: AlignmentDirectional.bottomEnd,
        child: SubmitButton(
          onPressed: () => _submit(context),
          width: MediaQuery.of(context).size.width * 0.35,
          label: 'Siguiente',
          withIcon: false,
          padding: EdgeInsets.all(4),
        ));
  }

  void _submit(BuildContext context) {
    Navigator.pushNamed(context, ResultsPage.ROUTE_NAME);
  }

  Widget _backButton(BuildContext context) {
    return Container(
        alignment: AlignmentDirectional.bottomStart,
        child: SubmitButton(
          onPressed: () => Navigator.pop(context),
          width: MediaQuery.of(context).size.width * 0.35,
          label: 'Atrás',
          withIcon: false,
          padding: EdgeInsets.all(4),
        ));
  }

  Widget _bottomButtons(BuildContext context) {
    return Row(
      children: [
        _backButton(context),
        Expanded(
          child: Container(),
        ),
        _nextButton(context),
      ],
    );
  }
}
