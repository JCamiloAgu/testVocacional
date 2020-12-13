import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:open_file/open_file.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:testvocacional/src/models/graphics_item_model.dart';
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

  final List<GraphicsItemModel> data = [
    GraphicsItemModel(domain: 'CDITI 1', measure: 87),
    GraphicsItemModel(domain: 'CDITI 2', measure: 14),
    GraphicsItemModel(domain: 'CDITI 3', measure: 29),
    GraphicsItemModel(domain: 'CDITI 4', measure: 97),
    GraphicsItemModel(domain: 'CDITI 5', measure: 43),
  ];

  @override
  Widget build(BuildContext context) {
    final chartsBuilder = ChartsBuilder();
    return Scaffold(
      appBar: AppBar(
        title: Text('Resultados'),
      ),
      body: Column(
        children: [
          RepaintBoundary(
              key: scr,
              child: chartsBuilder.build('Resultados finales', [...data])),
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

      await openImage();

    } on FileSystemException catch (e) {
      if (e.message == 'Cannot open file') {
        if(await createFolder()){
          await takeScreenshot();
        }
      }
    } on Exception catch (e) {
      print(e);
    }
  }

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
}
