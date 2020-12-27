import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testvocacional/src/models/user.dart';
import 'package:testvocacional/src/services/home_service.dart';

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

  int radioGroupGenderGroupValue = User().gender == 'Hombre' ? 0 : 1;

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(fontSize: 16);
    final theme = Theme.of(context);

    final homeService = Provider.of<HomeService>(context);

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
                onChanged: homeService.haveStoragePermission
                    ? _onChangeRadioGroup
                    : null,
              ),
              Text(
                'Hombre',
                style: textStyle,
              ),
              Radio(
                value: _radioValueFemale,
                groupValue: radioGroupGenderGroupValue,
                activeColor: theme.primaryColor,
                onChanged: homeService.haveStoragePermission
                    ? _onChangeRadioGroup
                    : null,
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
