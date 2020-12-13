import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testvocacional/src/provider/models/institution_programs_model.dart';
import 'package:testvocacional/src/ui/widgets/spinner.dart';

class InstitutionsSpinner extends StatefulWidget {
  final BuildContext ctx;

  InstitutionsSpinner(this.ctx);

  @override
  _InstitutionsSpinnerState createState() => _InstitutionsSpinnerState();
}

class _InstitutionsSpinnerState extends State<InstitutionsSpinner> {
  String spinnerSelection;

  List<String> programs;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => InstitutionProgramsModel(),
      builder: (ctxx, child) => Container(
        margin: EdgeInsets.all(12),
        child: buildSpinner(widget.ctx),
      ),
    );
  }

  Widget buildSpinner(BuildContext ctx) {
    final institutionProgramsModel = Provider.of<InstitutionProgramsModel>(ctx);

    setSpinnerSelection(institutionProgramsModel.getPrograms());

    return Spinner(
      label: 'Seleccione el programa de interés',
      value: spinnerSelection,
      items: getSpinnerItems(institutionProgramsModel.getPrograms()),
      onChanged: onChangeSpinner,
    );
  }

  List<DropdownMenuItem<String>> getSpinnerItems(
      List<String> institutionItems) {
    final items = <DropdownMenuItem<String>>[];

    institutionItems.forEach(
        (item) => items.add(DropdownMenuItem(value: item, child: Text(item))));

    return items;
  }

  void onChangeSpinner(selection) =>
      setState(() => spinnerSelection = selection);

  void setSpinnerSelection(List<String> programs) {
    spinnerSelection ??= programs[0];

    if (!programs.contains(spinnerSelection)) {
      spinnerSelection = programs[0];
    }

  }
}
