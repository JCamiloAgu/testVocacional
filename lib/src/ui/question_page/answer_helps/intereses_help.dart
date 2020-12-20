import 'package:flutter/material.dart';

class InteresesHelp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        child: Text(
            'lorem ipsum\n'
            '1) No\n'
            '2) Tengo dudas\n'
            '3) Si\n',
            style: TextStyle(fontSize: 16)),
      ),
    );
  }
}
