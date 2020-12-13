import 'package:flutter/material.dart';

class SubmitButton extends StatelessWidget {
  final Function onPressed;
  final String label;
  final bool withIcon;
  final double width;
  final EdgeInsets padding;

  const SubmitButton({@required this.onPressed, this.label, this.withIcon = true, this.width, this.padding});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: padding ?? EdgeInsets.symmetric(horizontal: 10.0, vertical: 25.0),
      width: width ?? double.infinity,
      child: OutlineButton(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        color: theme.accentColor,
        highlightedBorderColor: theme.accentColor,
        textColor: Theme.of(context).accentColor,
        child: Text(label ?? 'Guardar'),
        onPressed: onPressed,
      ),
    );
  }
}

class AlertDialogButton extends StatelessWidget {
  final Function onPressed;
  final String buttonText;

  const AlertDialogButton({this.onPressed, this.buttonText});

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: Text(buttonText),
      textColor: Theme.of(context).accentColor,
      onPressed: onPressed,
    );
  }
}
