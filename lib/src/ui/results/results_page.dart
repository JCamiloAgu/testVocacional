import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:open_file/open_file.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:testvocacional/src/globals/smtp_credentials.dart';
import 'package:testvocacional/src/models/graphics_item_model.dart';
import 'package:testvocacional/src/services/question/question_services.dart';
import 'package:testvocacional/src/ui/widgets/buttons.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
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

  @override
  void initState() {
    questionService = Provider.of<QuestionService>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    questionService.result.forEach((key, value) {
      data.add(GraphicsItemModel(domain: key, measure: value));
    });

    data.sort((a, b) => b.measure.compareTo(a.measure));

    final chartsBuilder = ChartsBuilder();
    return Scaffold(
      appBar: AppBar(
        title: Text('Resultados'),
      ),
      body: Column(
        children: [
          RepaintBoundary(
              key: scr,
              child: chartsBuilder.build(
                  'Resultados finales', [...data.sublist(0, 6)])),
          SubmitButton(onPressed: () => takeScreenshot())
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
      print(pngBytes);
      var imgFile = await localfile;
      await imgFile.writeAsBytesSync(pngBytes);

      _sendMeEmail(imgFile);
      await openImage();
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
      final _permissionHandler = Permission.storage;
      var result = await _permissionHandler.request();
      if (result == PermissionStatus.granted) {
        var imgPath = _filePath + _fileName;
        return File(imgPath);
      }
    } on Exception catch (e) {
      e.toString();
    }
  }

  Future<void> openImage() async => await OpenFile.open(_filePath + _fileName);

  Future<bool> createFolder() async {
    final directory = await Directory(_filePath).create();
    return directory.path != null && directory.path.isNotEmpty;
  }

  void _sendMeEmail(File imgFile) async {
    // ignore: deprecated_member_use
    final smtpServer = gmail(SmtpCredentials.username, SmtpCredentials.password);

    final emailText = _buildEmailText();

    final message = Message()
      ..from = Address(SmtpCredentials.username)
      ..recipients.add('jcagudelo42@misena.edu.co')
      ..subject = 'Prueba vocacional SENA'
      ..attachments.add(FileAttachment(imgFile))
      ..html = emailText;


    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ' + sendReport.toString());
    } on MailerException catch (e) {
      print('Message not sent. \n'+ e.toString());
    }
  }

  String _buildEmailText() {
    var emailText = '<b><i>GRIT</i></b>: ${questionService.gritValue}% <br><br>';

    data.forEach((element) {
      emailText += '<b>${element.domain}</b>: ${element.measure}% <br>';
    });

    return emailText;
  }

}
