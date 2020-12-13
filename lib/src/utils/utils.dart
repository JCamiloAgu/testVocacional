import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:testvocacional/src/ui/widgets/buttons.dart';

Future<void> showAlertDialog(BuildContext context, {String message, String title}) async {
  showDialog(
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