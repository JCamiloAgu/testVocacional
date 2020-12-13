import 'package:flutter/material.dart';

class AnswerOptionsRadioButtons extends StatefulWidget {
  final List<String> answerOptions;

  const AnswerOptionsRadioButtons(this.answerOptions);

  @override
  _AnswerOptionsRadioButtonsState createState() =>
      _AnswerOptionsRadioButtonsState();
}

class _AnswerOptionsRadioButtonsState extends State<AnswerOptionsRadioButtons> {
  String radioGroupQuestionsGroupValue;

  @override
  Widget build(BuildContext context) {
    radioGroupQuestionsGroupValue ??= widget.answerOptions[0];
    return Column(
      children: widget.answerOptions
          .map((answerOption) => buildRadioButtonWithLabelText(answerOption))
          .toList(),
    );
  }

  Widget buildRadioButtonWithLabelText(String answerOption) {
    final textStyle = TextStyle(fontSize: 16);

    return Row(
      children: [
        Radio(
          value: answerOption,
          groupValue: radioGroupQuestionsGroupValue,
          onChanged: (value) => _onChangeRadioGroup(value),
        ),
        Flexible(
          child: Text(
            answerOption,
            style: textStyle,
          ),
        ),
      ],
    );
  }

  void _onChangeRadioGroup(value) {
    setState(() => radioGroupQuestionsGroupValue = value);
  }
}
