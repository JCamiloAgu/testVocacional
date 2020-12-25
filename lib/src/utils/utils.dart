import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:testvocacional/src/ui/widgets/buttons.dart';

Future<void> showAlertDialog(BuildContext context,
    {String message, String title}) async {
  await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(child: Text(message)),
          actions: <Widget>[
            AlertDialogButton(
              buttonText: 'No Acepto',
              onPressed: () => SystemNavigator.pop(animated: true),
            ),
            AlertDialogButton(
              buttonText: 'Acepto',
              onPressed: () => Navigator.of(context).pop(),
            )
          ],
        );
      });
}

Future<void> showAlertDialogFromContent(BuildContext context,
    {String title, Widget content}) async {
  await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(child: content),
          actions: <Widget>[
            AlertDialogButton(
              buttonText: 'OK',
              onPressed: () => Navigator.of(context).pop(),
            )
          ],
        );
      });
}
