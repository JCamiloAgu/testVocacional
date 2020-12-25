import 'package:flutter/material.dart';

class InteresesHelp extends StatelessWidget {
  final bool isFontInBold;

  const InteresesHelp({this.isFontInBold = true});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
                'En esta sección encontrará afirmaciones relacionadas con su interés'
                ' hacia diferentes actividades que se realizan en los diferentes '
                'programas de formación ofertados en el SENA Risaralda. \n'
                'Para responder, tenga en cuenta qué tanto le interesan las '
                'actividades planteadas en los enunciados. \n\n'
                'Las opciones de respuesta son las siguientes: \n'
                '1) No\n'
                '2) Tengo dudas\n'
                '3) Si\n\n'
                'Por favor conteste con sinceridad ya que de esto depende la validez '
                'de los resultados. La opción 2 (Tengo dudas) debe ser usada lo '
                'menos posible (solo en caso de que en definitiva no pueda definirse).',
                style: TextStyle(fontSize: 16,
                    fontWeight:
                    isFontInBold ? FontWeight.bold : FontWeight.normal)),
            Divider(
              color: Colors.black,
            )
          ],
        ),
      ),
    );
  }
}
