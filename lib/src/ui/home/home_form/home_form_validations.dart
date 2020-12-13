import 'package:testvocacional/src/ui/widgets/validations.dart';

class HomeFormValidations extends Validations {
  final identificationNumberErrorText =
      'Por favor ingrese un número de documento válido';

  final ageErrorText = 'Por favor ingrese una edad válida';

  bool _isValidIdentificationNumber(String value) =>
      (isValidRequiredInput(value) &&
          value.length >= 10 &&
          int.tryParse(value) != null);

  bool onChangeIdentificationNumber(String value) =>
      _isValidIdentificationNumber(value);

  String validatorIdentificationNumber(String value) =>
      _isValidIdentificationNumber(value)
          ? null
          : identificationNumberErrorText;

  bool _isValidAge(String value) => (isValidRequiredInput(value) &&
      value.length <= 2 &&
      int.tryParse(value) != null);

  bool onChangeAge(String value) => _isValidAge(value);

  String validatorAge(String value) =>
      _isValidAge(value) ? null : ageErrorText;
}
