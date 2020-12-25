import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ApitudesAnswerInstructions extends StatelessWidget {
  final bool isFontInBold;

  const ApitudesAnswerInstructions({this.isFontInBold = true});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
                'Las aptitudes son una serie de características que se pueden '
                'convertir en habilidades por medio del entrenamiento. '
                'Las aptitudes se evidencian con gran facilidad durante la '
                'juventud. A continuación, encontrará una serie de situaciones '
                'sobre las cuales usted debe responder qué tan frecuentemente le '
                'sucedió o se siente identificado.\n\nLas opciones de respuesta son:\n'
                '1) No se parece en nada a mí\n'
                '2) Poco parecido a mí\n'
                '3) Algo parecido a mí\n'
                '4) Bastante parecido a mí\n'
                '5) Totalmente parecido a mí\n\n'
                'Por favor conteste con sinceridad ya que de esto depende la validez '
                'de los resultados.',
                style: TextStyle(
                    fontSize: 16,
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
