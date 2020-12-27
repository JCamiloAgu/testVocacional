import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testvocacional/src/models/question/question.dart';
import 'package:testvocacional/src/services/question/question_services.dart';

class AnswerOptionsRadioButtons extends StatefulWidget {
  final Question question;

  const AnswerOptionsRadioButtons(this.question);

  @override
  _AnswerOptionsRadioButtonsState createState() =>
      _AnswerOptionsRadioButtonsState();
}

class _AnswerOptionsRadioButtonsState extends State<AnswerOptionsRadioButtons> {
  int radioGroupQuestionsGroupValue;

  @override
  Widget build(BuildContext context) {
    radioGroupQuestionsGroupValue = widget.question.value;
    return Row(
      children: widget.question.answerOptions
          .map((answerOption) => buildRadioButtonWithLabelText(answerOption))
          .toList(),
    );
  }

  Widget buildRadioButtonWithLabelText(String answerOption) {
    final textStyle = TextStyle(fontSize: 16);
    final theme = Theme.of(context);

    final questionIndex =
        widget.question.answerOptions.indexOf(answerOption);

    Future.delayed(Duration(seconds: 1))
        .then((value) => _onChangeRadioGroup(1));

    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            (questionIndex + 1).toString(),
            style: textStyle,
          ),
          Radio(
            value: questionIndex,
            activeColor: theme.primaryColor,
            autofocus: false,
            groupValue: radioGroupQuestionsGroupValue,
            onChanged: (value) => _onChangeRadioGroup(value),
          ),
        ],
      ),
    );
  }

  void _onChangeRadioGroup(int value) {
    final questionService =
        Provider.of<QuestionService>(context, listen: false);
    setState(() {
      final index = questionService.questions.indexOf(widget.question);
      widget.question.value = value;
      questionService.editQuestion(index, widget.question);
      return radioGroupQuestionsGroupValue = value;
    });
  }
}
