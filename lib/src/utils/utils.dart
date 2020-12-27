import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:testvocacional/src/services/home_service.dart';
import 'package:testvocacional/src/ui/widgets/buttons.dart';

Future<void> showAlertDialogConsent(BuildContext context,
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

Future<PermissionStatus> askStoragePermission(BuildContext context) async {
  final homeService = Provider.of<HomeService>(context, listen: false);

  final _permissionHandler = Permission.storage;
  final result = await _permissionHandler.request();

  homeService.haveStoragePermission = result.isGranted;

  if (result == PermissionStatus.denied || result == PermissionStatus.permanentlyDenied) {
    await showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Permiso necesario'),
            content: SingleChildScrollView(child: Text('Todos los permisos son necesarios. Por favor concédalos para continuar con el test.')),
            actions: <Widget>[
              AlertDialogButton(
                buttonText: 'Ok',
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          );
        });
  }

  return result;
}
