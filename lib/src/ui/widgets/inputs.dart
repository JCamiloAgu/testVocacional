import 'package:flutter/material.dart';
import 'package:testvocacional/src/ui/widgets/validations.dart';

class CustomInput extends StatefulWidget {
  final String errorText;
  final String initialValue;
  final String label;

  final bool Function(String value) onChanged;
  final String Function(String value) validator;
  final Function(String value) onSaved;

  final TextInputType keyboardType;

  final bool isEnabled;
  final bool isReadOnly;

  final int maxLines;
  final int minLines;

  final String helper;

  CustomInput({
    this.errorText,
    @required this.label,
    this.onChanged,
    this.validator,
    @required this.onSaved,
    this.initialValue,
    this.keyboardType = TextInputType.text,
    this.isEnabled = true,
    this.isReadOnly = true,
    this.maxLines = 1,
    this.minLines = 1, this.helper,
  });

  @override
  _CustomInputState createState() => _CustomInputState();
}

class _CustomInputState extends State<CustomInput> {
  bool hasError = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: TextFormField(
        initialValue: widget.initialValue,
        cursorColor: Colors.black,
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
            labelText: widget.label,
            helperText: widget.helper,
            errorText: (hasError) ? widget.errorText : null),
        keyboardType: widget.keyboardType,
        onChanged: (widget.onChanged == null)
            ? null
            : (value) {
                setState(() => hasError = !widget.onChanged(value));
              },
        validator: widget.validator,
        enabled: widget.isEnabled,
        onSaved: widget.onSaved,
        maxLines: widget.maxLines,
        minLines: widget.minLines,
      ),
    );
  }
}

class EmailInput extends StatelessWidget {
  final Function(String value) onSaved;

  final Validations validations;

  final String initialValue;
  final String label;

  final bool isEnabled;

  final String helper;

  EmailInput(
      {this.label,
      @required this.onSaved,
      @required this.validations,
      this.initialValue, this.isEnabled = true, this.helper
      });

  @override
  Widget build(BuildContext context) {
    return CustomInput(
      label: label ?? 'Correo electrónico',
      onSaved: onSaved,
      errorText: validations.emailErrorText,
      onChanged: (value) => validations.onChangeEmail(value),
      validator: (value) => validations.validatorEmail(value),
      isEnabled: isEnabled,
      keyboardType: TextInputType.emailAddress,
      initialValue: initialValue,
      helper: helper,
    );
  }
}
