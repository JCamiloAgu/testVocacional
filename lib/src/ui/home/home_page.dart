import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:testvocacional/src/ui/home/home_form/home_form_validations.dart';
import 'package:testvocacional/src/utils/utils.dart' as utils;

import 'home_form/home_form.dart';
import 'home_header.dart';

class HomePage extends StatefulWidget {
  static const ROUTE_NAME = 'home';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    Future.delayed(
            Duration(milliseconds: 500),
            () => utils.showAlertDialogConsent(context,
                title: getDialogTitle(), message: getDialogMessage()))
        .then((_) => utils.askStoragePermission(context));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Prueba de orientación vocacional'),
      ),
      body: buildBody(),
    );
  }

  String getDialogTitle() =>
      'CONSENTIMIENTO INFORMADO – PRUEBA DE ORIENTACIÓN VOCACIONAL SENA';

  String getDialogMessage() {
    return 'De acuerdo a la información brindada por el SENA doy mi consentimiento para la aplicación de la prueba, la cual hace parte de un ejercicio de pilotaje que llevará a la validación de  un instrumento de orientación vocacional que servirá como guía a los potenciales aprendices del SENA. \n \n'
        'Para efectos de su atención, los profesionales en psicología manejarán la información y todos los datos obtenidos como resultado de la aplicación de esta prueba, de acuerdo a los principios éticos y legales que rigen el ejercicio de la psicología en Colombia. Teniendo en cuenta lo anterior comprendo y acepto que la información recolectada es de carácter estrictamente confidencial y que como participante en este proceso de validación tengo derecho a solicitar los resultados obtenidos. \n \n'
        'Partiendo de lo anterior y en pleno uso de mis facultades mentales, expreso mi deseo de realizar la prueba de orientación vocacional.';
  }

  Widget buildBody() {
    return SingleChildScrollView(
      child: Column(
        children: [HomeHeader(), HomeForm(HomeFormValidations())],
      ),
    );
  }
}
