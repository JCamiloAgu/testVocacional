class Validations {
  final requiredInputErrorText = 'Este campo es requerido';
  final emailErrorText = 'Por favor ingrese un correo electrónico válido';

  bool isValidRequiredInput(String value) => value != null && value.isNotEmpty;

  bool onChangeRequiredInput(String value) => isValidRequiredInput(value);

  String validatorRequiredInput(String value) =>
      isValidRequiredInput(value) ? null : requiredInputErrorText;

  bool _isValidEmail(String email) => (isValidRequiredInput(email) && _isValidEmailRegExp(email));

  bool onChangeEmail(String value) => _isValidEmail(value);

  String validatorEmail(String value) =>
      _isValidEmail(value) ? null : requiredInputErrorText;

  bool _isValidEmailRegExp(String email) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    var regExp = RegExp(pattern);
    return regExp.hasMatch(email) ? true : false;
  }

}
