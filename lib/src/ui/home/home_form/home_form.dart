import 'package:flutter/material.dart';
import 'package:testvocacional/src/ui/home/home_form/gender_radio_buttons.dart';
import 'package:testvocacional/src/ui/institutions/institution_page.dart';
import 'package:testvocacional/src/ui/widgets/buttons.dart';
import 'package:testvocacional/src/ui/widgets/inputs.dart';

import 'home_form_validations.dart';

class HomeForm extends StatelessWidget {
  final HomeFormValidations homeFormValidations;
  final _formKey = GlobalKey<FormState>();
  final genderRadioButtons = GenderRadioButtons();

  HomeForm(this.homeFormValidations);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            _inputIdentificationNumber(),
            _inputFullName(),
            _inputEmail(),
            _inputAge(),
            genderRadioButtons,
            _submitButton(context)
          ],
        ),
      ),
    );
  }

  Widget _inputIdentificationNumber() {
    return CustomInput(
      label: 'Número de documento',
      onSaved: (value) => null,
      keyboardType: TextInputType.number,
      errorText: homeFormValidations.identificationNumberErrorText,
      validator: (value) =>
          homeFormValidations.validatorIdentificationNumber(value),
      onChanged: (value) =>
          homeFormValidations.onChangeIdentificationNumber(value),
    );
  }

  Widget _inputFullName() {
    return CustomInput(
      label: 'Nombres y apellidos',
      onSaved: (value) => null,
      errorText: homeFormValidations.requiredInputErrorText,
      onChanged: (value) => homeFormValidations.onChangeRequiredInput(value),
      validator: (value) => homeFormValidations.validatorRequiredInput(value),
    );
  }

  Widget _inputEmail() {
    return EmailInput(
      onSaved: (value) => null,
      validations: homeFormValidations,
    );
  }

  Widget _inputAge() {
    return CustomInput(
      label: 'Edad',
      onSaved: (value) => null,
      keyboardType: TextInputType.number,
      errorText: homeFormValidations.ageErrorText,
      onChanged: (value) => homeFormValidations.onChangeAge(value),
      validator: (value) => homeFormValidations.validatorAge(value),
    );
  }

  Widget _submitButton(BuildContext context) {
    return Container(
        alignment: AlignmentDirectional.bottomEnd,
        child: SubmitButton(onPressed: () => _submit(context),
        width: MediaQuery.of(context).size.width * 0.35,
          label: 'Siguiente',
          withIcon: false,
        ));
  }

  void _submit(BuildContext context){
    Navigator.pushNamed(context, InstitutionPage.ROUTE_NAME);
  }
}
