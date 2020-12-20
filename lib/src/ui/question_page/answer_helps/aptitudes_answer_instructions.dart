import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ApitudesAnswerInstructions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        child: Text(
            'lorem ipsum\n'
            '1) No se parece en nada a mí\n'
            '2) Poco parecido a mí\n'
            '3) Algo parecido a mí\n'
            '4) Bastante parecido a mí\n'
            '5) Totalmente parecido a mí\n',
            style: TextStyle(fontSize: 16)),
      ),
    );
  }
}
