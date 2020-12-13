import 'package:flutter/material.dart';

class GenderRadioButtons extends StatefulWidget {
  final genderRadioButtonsState = _GenderRadioButtonsState();

  @override
  _GenderRadioButtonsState createState() => genderRadioButtonsState;

  String getRadioButtonSelection() =>
      genderRadioButtonsState.radioGroupGenderGroupValue == 1
          ? 'Mujer'
          : 'Hombre';
}

class _GenderRadioButtonsState extends State<GenderRadioButtons> {
  final int _radioValueMale = 0;
  final int _radioValueFemale = 1;

  int radioGroupGenderGroupValue = 0;

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(fontSize: 16);
    final theme = Theme.of(context);

    return Container(
        margin: EdgeInsets.only(top: 16),
        child: Column(
          children: [
            Container(
                alignment: AlignmentDirectional.centerStart,
                child: Text(
                  'Género:',
                  style: textStyle.copyWith(fontWeight: FontWeight.bold),
                )),
            Row(children: <Widget>[
              Radio(
                value: _radioValueMale,
                groupValue: radioGroupGenderGroupValue,
                activeColor: theme.primaryColor,
                onChanged: _onChangeRadioGroup,
              ),
              Text(
                'Hombre',
                style: textStyle,
              ),
              Radio(
                value: _radioValueFemale,
                groupValue: radioGroupGenderGroupValue,
                activeColor: theme.primaryColor,
                onChanged: _onChangeRadioGroup,
              ),
              Text(
                'Mujer',
                style: textStyle,
              ),
            ]),
          ],
        ));
  }

  void _onChangeRadioGroup(int value) {
    setState(() => radioGroupGenderGroupValue = value);
  }
}
