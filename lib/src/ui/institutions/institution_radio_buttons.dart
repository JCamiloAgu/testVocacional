import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testvocacional/src/provider/models/institution_programs_model.dart';

class InstitutionRadioButtons extends StatefulWidget {
  final Map<int, String> institutions;
final BuildContext ctx;

  final genderRadioButtonsState = _InstitutionRadioButtonsState();

  InstitutionRadioButtons(this.institutions, this.ctx);

  @override
  _InstitutionRadioButtonsState createState() => genderRadioButtonsState;

  String getRadioButtonSelection() =>
      institutions[genderRadioButtonsState.radioGroupInstitutionsGroupValue];
}

class _InstitutionRadioButtonsState extends State<InstitutionRadioButtons> {
  int radioGroupInstitutionsGroupValue = 1;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (ctx) => InstitutionProgramsModel(),
        builder: (ctx, child) => Container(
          margin: EdgeInsets.only(top: 16),
          child: Column(
            children: [
              Text(
                'Seleccione la institución de interés',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 16,
              ),
              ...widget.institutions.keys
                  .map((key) => buildRadioButtonWithLabelText(key, ctx))
                  .toList()
            ],
          )),
    );
  }

  Widget buildRadioButtonWithLabelText(int value, BuildContext ctx) {
    final textStyle = TextStyle(fontSize: 16);

    return Row(
      children: [
        Radio(
          value: value,
          groupValue: radioGroupInstitutionsGroupValue,
          onChanged: (value) => _onChangeRadioGroup(value, ctx),
        ),
        Flexible(
          child: Text(
            widget.institutions[value],
            style: textStyle,
          ),
        ),
      ],
    );
  }

  void _onChangeRadioGroup(int value, BuildContext ctx) {
    Provider.of<InstitutionProgramsModel>(widget.ctx, listen: false).programs = value;
    setState(() => radioGroupInstitutionsGroupValue = value);
  }
}
