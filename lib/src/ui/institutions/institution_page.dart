import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testvocacional/src/provider/models/institution_programs_model.dart';
import 'package:testvocacional/src/ui/question_page/question_page.dart';
import 'package:testvocacional/src/ui/widgets/buttons.dart';

import 'institution_radio_buttons.dart';
import 'institutions_spinner.dart';

class InstitutionPage extends StatelessWidget {
  static const ROUTE_NAME = 'institutions';

  final Map<int, String> institutions = {
    1: 'Centro de Diseño e Innovación Tecnológica Industrial',
    2: 'Centro de Comercio y Servicios',
    3: 'Centro Agropecuario',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Instituciones'),
      ),
      body: ChangeNotifierProvider(
        create: (ctx) => InstitutionProgramsModel(),
        builder: (ctx, child) => Column(
          children: [
            InstitutionRadioButtons(institutions, ctx),
            InstitutionsSpinner(ctx),
            _bottomButtons(context)
          ],
        ),
      ),
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
        ));
  }

  void _submit(BuildContext context) {
    Navigator.pushNamed(context, QuestionPage.ROUTE_NAME); 
  }

  Widget _backButton(BuildContext context) {
    return Container(
        alignment: AlignmentDirectional.bottomStart,
        child: SubmitButton(
          onPressed: () => Navigator.pop(context),
          width: MediaQuery.of(context).size.width * 0.35,
          label: 'Atrás',
          withIcon: false,
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
