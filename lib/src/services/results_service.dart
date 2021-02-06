import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:open_file/open_file.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';
import 'package:testvocacional/src/globals/smtp_credentials.dart';
import 'package:testvocacional/src/models/graphics_item_model.dart';
import 'package:testvocacional/src/models/user.dart';
import 'package:testvocacional/src/services/question/question_services.dart';

class ResultsService with ChangeNotifier {
  final GlobalKey scr;
  final BuildContext context;

  final _filePath =
      '/storage/emulated/0/Android/media/com.sena.testvocacional/';
  final _fileName = 'resultadoTestVocacional.png';

  final user = User();

  final List<GraphicsItemModel> data = [];

  ResultsService(this.scr, this.context);

  bool _hasBeenSendEmail = true;

  bool shouldShowProgressDialog = true;

  bool get hasBeenSendEmail => _hasBeenSendEmail;

  set hasBeenSendEmail(bool value) {
    _hasBeenSendEmail = value;
    notifyListeners();
  }

  Future<void> takeScreenshot(ProgressDialog progressDialog) async {
    try {
      if(shouldShowProgressDialog && !progressDialog.isShowing()) {
        await progressDialog.show();
      }

      RenderRepaintBoundary boundary = scr.currentContext.findRenderObject();
      var image = await boundary.toImage();
      var byteData = await image.toByteData(format: ImageByteFormat.png);
      var pngBytes = byteData.buffer.asUint8List();
      var imgFile = await localfile;
      await imgFile.writeAsBytesSync(pngBytes);

      _sendEmail(imgFile, progressDialog);
    } on FileSystemException catch (e) {
      if (e.message == 'Cannot open file') {
        if (await createFolder()) {
          shouldShowProgressDialog = false;
          await takeScreenshot(progressDialog);
        }
      }
    } on Exception catch (e) {
      print(e);
    }
  }

  // ignore: missing_return
  Future<File> get localfile async {
    try {
      var imgPath = _filePath + _fileName;
      return File(imgPath);
    } on Exception catch (e) {
      e.toString();
    }
  }

  Future<bool> createFolder() async {
    final directory = await Directory(_filePath).create();
    return directory.path != null && directory.path.isNotEmpty;
  }

  void _sendEmail(File imgFile, ProgressDialog progressDialog) async {
    final smtpServer =
        // ignore: deprecated_member_use
        gmail(SmtpCredentials.username, SmtpCredentials.password);

    final emailText = _buildEmailBody();

    final message = Message()
      ..from = Address(SmtpCredentials.username)
      ..recipients.add(user.email)
      ..subject = 'Prueba vocacional SENA'
      ..ccRecipients.addAll(['yaarce4@misena.edu.co', 'jorregomartinez@misena.edu.co'])
      ..attachments.add(FileAttachment(imgFile))
      ..html = emailText;

    try {
      final sendReport = await send(message, smtpServer);
      await progressDialog.hide();
      hasBeenSendEmail = true;
      print('Message sent: ' + sendReport.toString());
    } on Exception catch (_) {
      await progressDialog.hide();
      hasBeenSendEmail = false;
    }
  }

  String _buildEmailBody() {
    final questionService = Provider.of<QuestionService>(context, listen: false);

    var emailText = '<h1>Datos personales</h1>'
        '<ul>'
        '<li><b>Número de identificación:</b> ${user.id}</li>'
        '<li><b>Nombre completo:</b> ${user.fullName}</li>'
        '<li><b>Correo electrónico:</b> ${user.email}</li>'
        '<li><b>Edad:</b> ${user.age}</li>'
        '<li><b>Género:</b> ${user.gender}</li>'
        '</ul>';

    emailText += '<b><i>GRIT</i></b>: ${questionService.gritValue}<br><br>';

    data.forEach((element) {
      emailText += '<b>${element.domain}</b>: ${element.measure}% <br>';
    });

    return emailText;
  }

  Future<void> openImage() async => await OpenFile.open(_filePath + _fileName);
}
