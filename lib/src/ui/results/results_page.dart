import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:testvocacional/src/models/graphics_item_model.dart';
import 'package:testvocacional/src/models/user.dart';
import 'package:testvocacional/src/services/question/question_services.dart';
import 'package:testvocacional/src/services/results_service.dart';
import 'package:testvocacional/src/ui/widgets/buttons.dart';
import 'package:testvocacional/src/utils/utils.dart' as utils;

import 'charts_builder.dart';

class ResultsPage extends StatelessWidget {
  static const ROUTE_NAME = 'results';
  final user = User();

  @override
  Widget build(BuildContext context) {
    final questionService =
        Provider.of<QuestionService>(context, listen: false);

    final resultsService = Provider.of<ResultsService>(context, listen: false);

    final progressDialog =
        utils.getProgressDialog(context, 'Espera un momento');

    Future.delayed(Duration.zero, () => progressDialog.show());

    Future.delayed(Duration(milliseconds: 1500),
        () => resultsService.takeScreenshot(progressDialog));

    if (resultsService.data.isEmpty) {
      questionService.result.forEach((key, value) {
        resultsService.data.add(GraphicsItemModel(domain: key, measure: value));
      });

      resultsService.data.sort((a, b) => b.measure.compareTo(a.measure));
    }

    final chartsBuilder = ChartsBuilder();
    return Scaffold(
      appBar: AppBar(
        title: Text('Resultados'),
      ),
      body: Column(
        children: [
          RepaintBoundary(
              key: resultsService.scr,
              child: chartsBuilder.build('Resultados finales',
                  [...resultsService.data.sublist(0, 6)])),
          _ActionButtons()
        ],
      ),
    );
  }
}

class _ActionButtons extends StatefulWidget {
  @override
  __ActionButtonsState createState() => __ActionButtonsState();
}

class __ActionButtonsState extends State<_ActionButtons> {
  bool _hasBeenOccurredAErrorSendEmail = false;
  int _timesReSendEmail = 0;

  ResultsService _resultsService;

  @override
  Widget build(BuildContext context) {
    _resultsService = Provider.of<ResultsService>(context);
    _hasBeenOccurredAErrorSendEmail =
        !_resultsService.hasBeenSendEmail ?? false;

    if (_hasBeenOccurredAErrorSendEmail) {
      Future.delayed(Duration.zero, () => _emailSendError());
    }

    return Column(
      children: [
        SubmitButton(
            padding: EdgeInsets.symmetric(horizontal: 15),
            onPressed: () async => await _resultsService.openImage()),
        _hasBeenOccurredAErrorSendEmail
            ? SubmitButton(
                padding: EdgeInsets.symmetric(horizontal: 15),
                label: 'Re-enviar resultados',
                onPressed: _timesReSendEmail > 1
                    ? null
                    : () async => await reSendEmail())
            : Container()
      ],
    );
  }

  void reSendEmail() async {
    await _resultsService
        .takeScreenshot(utils.getProgressDialog(context, 'Espera un momento'));
    if (!_hasBeenOccurredAErrorSendEmail) {
      setState(() {
        _timesReSendEmail++;
      });
    }
  }

  void _emailSendError() async {
    await showDialog(
        barrierDismissible: false,
        context: context,
        builder: (ctx) {
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
  }
}
