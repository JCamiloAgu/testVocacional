import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testvocacional/src/models/user.dart';
import 'package:testvocacional/src/services/home_service.dart';
import 'package:testvocacional/src/ui/home/home_form/gender_radio_buttons.dart';
import 'package:testvocacional/src/ui/question_page/question_page.dart';
import 'package:testvocacional/src/ui/widgets/buttons.dart';
import 'package:testvocacional/src/ui/widgets/inputs.dart';

import 'home_form_validations.dart';

class HomeForm extends StatelessWidget {
  final HomeFormValidations homeFormValidations;

  HomeForm(this.homeFormValidations);

  final _formKey = GlobalKey<FormState>();

  final genderRadioButtons = GenderRadioButtons();

  final _user = User();

  @override
  Widget build(BuildContext context) {
    final homeService = Provider.of<HomeService>(context);

    return Container(
      padding: EdgeInsets.all(15.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            _title(),
            _inputIdentificationNumber(homeService.haveStoragePermission),
            _inputFullName(homeService.haveStoragePermission),
            _inputEmail(homeService.haveStoragePermission),
            _inputAge(homeService.haveStoragePermission),
            genderRadioButtons,
            _submitButton(context, homeService.haveStoragePermission)
          ],
        ),
      ),
    );
  }

  Widget _inputIdentificationNumber(bool haveStoragePermission) {
    return CustomInput(
      label: 'Número de documento',
      initialValue: _user.id?.toString() ?? '',
      onSaved: (String value) => _user.id = int.parse(value),
      keyboardType: TextInputType.number,
      isEnabled: haveStoragePermission,
      errorText: homeFormValidations.identificationNumberErrorText,
      validator: (value) =>
          homeFormValidations.validatorIdentificationNumber(value),
      onChanged: (value) =>
          homeFormValidations.onChangeIdentificationNumber(value),
    );
  }

  Widget _inputFullName(bool haveStoragePermission) {
    return CustomInput(
      label: 'Nombres y apellidos',
      initialValue: _user.fullName ?? '',
      onSaved: (value) => _user.fullName = value,
      errorText: homeFormValidations.requiredInputErrorText,
      isEnabled: haveStoragePermission,
      onChanged: (value) => homeFormValidations.onChangeRequiredInput(value),
      validator: (value) => homeFormValidations.validatorRequiredInput(value),
    );
  }

  Widget _inputEmail(bool haveStoragePermission) {
    return EmailInput(
      onSaved: (value) => _user.email = value,
      initialValue: _user.email ?? '',
      isEnabled: haveStoragePermission,
      helper: 'A este email se le enviará una copia de los resultados',
      validations: homeFormValidations,
    );
  }

  Widget _inputAge(bool haveStoragePermission) {
    return CustomInput(
      label: 'Edad',
      initialValue: _user.age?.toString() ?? '',
      onSaved: (value) => _user.age = int.parse(value),
      keyboardType: TextInputType.number,
      isEnabled: haveStoragePermission,
      errorText: homeFormValidations.ageErrorText,
      onChanged: (value) => homeFormValidations.onChangeAge(value),
      validator: (value) => homeFormValidations.validatorAge(value),
    );
  }

  Widget _submitButton(BuildContext context, bool haveStoragePermission) {
    return Container(
        alignment: AlignmentDirectional.bottomEnd,
        child: SubmitButton(
          onPressed:
              haveStoragePermission ? () => _submit(context) : null,
          width: MediaQuery.of(context).size.width * 0.35,
          label: 'Siguiente',
          withIcon: false,
        ));
  }

  void _submit(BuildContext context) {
    final isFormValid = _formKey.currentState.validate();

    if (isFormValid) {
      _formKey.currentState.save();
      _user.gender = genderRadioButtons.getRadioButtonSelection();
      Navigator.pushNamed(context, QuestionPage.ROUTE_NAME);
    }
  }

  Widget _title() {
    return Text(
      'Información personal',
      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    );
  }
}
