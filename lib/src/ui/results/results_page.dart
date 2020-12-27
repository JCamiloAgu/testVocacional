import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:open_file/open_file.dart';
import 'package:provider/provider.dart';
import 'package:testvocacional/src/globals/smtp_credentials.dart';
import 'package:testvocacional/src/models/graphics_item_model.dart';
import 'package:testvocacional/src/models/user.dart';
import 'package:testvocacional/src/services/question/question_services.dart';
import 'package:testvocacional/src/ui/widgets/buttons.dart';

import 'charts_builder.dart';

class ResultsPage extends StatefulWidget {
  static const ROUTE_NAME = 'results';

  @override
  _ResultsPageState createState() => _ResultsPageState();
}

class _ResultsPageState extends State<ResultsPage> {
  var scr = GlobalKey();
  final _filePath =
      '/storage/emulated/0/Android/media/com.sena.testvocacional/';
  final _fileName = 'resultadoTestVocacional.png';
  QuestionService questionService;

  final List<GraphicsItemModel> data = [];
  final user = User();

  bool hasBeenOccurredAErrorSendEmail = false;
  int timesReSendEmail = 0;

  @override
  void initState() {
    questionService = Provider.of<QuestionService>(context, listen: false);
    Future.delayed(Duration(milliseconds: 1500), () => takeScreenshot());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if(data.isEmpty) {
      questionService.result.forEach((key, value) {
        data.add(GraphicsItemModel(domain: key, measure: value));
      });

      data.sort((a, b) => b.measure.compareTo(a.measure));
    }

    final chartsBuilder = ChartsBuilder();
    return Scaffold(
      appBar: AppBar(
        title: Text('Resultados'),
      ),
      body: Column(
        children: [
          RepaintBoundary(
              key: scr,
              child: chartsBuilder
                  .build('Resultados finales', [...data.sublist(0, 6)])),
          SubmitButton(padding: EdgeInsets.symmetric(horizontal: 15) ,onPressed: () async => await openImage()),
          hasBeenOccurredAErrorSendEmail
              ? SubmitButton(
              padding: EdgeInsets.symmetric(horizontal: 15),
              label: 'Re-enviar resultados',
              onPressed: timesReSendEmail > 1
                  ? null
                  : () async => await reSendEmail())
              : Container()
        ],
      ),
    );
  }

  Future<void> takeScreenshot() async {
    try {
      RenderRepaintBoundary boundary = scr.currentContext.findRenderObject();
      var image = await boundary.toImage();
      var byteData = await image.toByteData(format: ImageByteFormat.png);
      var pngBytes = byteData.buffer.asUint8List();
      var imgFile = await localfile;
      await imgFile.writeAsBytesSync(pngBytes);

      _sendEmail(imgFile);
    } on FileSystemException catch (e) {
      if (e.message == 'Cannot open file') {
        if (await createFolder()) {
          await takeScreenshot();
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

  Future<void> openImage() async => await OpenFile.open(_filePath + _fileName);

  Future<bool> createFolder() async {
    final directory = await Directory(_filePath).create();
    return directory.path != null && directory.path.isNotEmpty;
  }

  void _sendEmail(File imgFile) async {
    final smtpServer =
    // ignore: deprecated_member_use
        gmail(SmtpCredentials.username, SmtpCredentials.password);

    final emailText = _buildEmailBody();

    final message = Message()
      ..from = Address(SmtpCredentials.username)
      ..recipients.add(user.email)
      ..subject = 'Prueba vocacional SENA'
      ..attachments.add(FileAttachment(imgFile))
      ..html = emailText;

    try {
      final sendReport = await send(message, smtpServer);
      setState(() {
        hasBeenOccurredAErrorSendEmail = false;
      });
      print('Message sent: ' + sendReport.toString());
    } on Exception catch (_) {
      _emailSendError();
    }
  }

  String _buildEmailBody() {
    var emailText = '<h1>Datos personales</h1>'
        '<ul>'
        '<li><b>Número de identificación:</b> ${user.id}</li>'
        '<li><b>Nombre completo:</b> ${user.fullName}</li>'
        '<li><b>Correo electrónico:</b> ${user.email}</li>'
        '<li><b>Edad:</b> ${user.age}</li>'
        '<li><b>Género:</b> ${user.gender}</li>'
        '</ul>';

    emailText += '<b><i>GRIT</i></b>: ${questionService.gritValue}% <br><br>';

    data.forEach((element) {
      emailText += '<b>${element.domain}</b>: ${element.measure}% <br>';
    });

    return emailText;
  }

  void _emailSendError() async {
    await showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Problema al enviar el correo'),
            content: SingleChildScrollView(
                child: Text(
                    'Tuvimos un problema al enviar el correo electrónico con los '
                    'resultados, por favor asegurate de tener una conexión '
                    'estable a internet y vuleve a intentarlo.')),
            actions: <Widget>[
              AlertDialogButton(
                buttonText: 'Ok',
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          );
        });

    setState(() {
      hasBeenOccurredAErrorSendEmail = true;
    });
  }

  void reSendEmail() async {
    await takeScreenshot();
    if(!hasBeenOccurredAErrorSendEmail){
      setState(() {
        timesReSendEmail++;
      });
    }
  }
}
