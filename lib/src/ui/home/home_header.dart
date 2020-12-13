import 'package:flutter/material.dart';

class HomeHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SizedBox(height: 6),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(getDescription(), style: TextStyle(fontSize: 18),),
          )
        ],
      ),
    );
  }

  String getDescription() {
    return 'A continuación lo invitamos a contestar una serie de preguntas que nos permitirán identificar entre los diferentes programas de formación que ofrece el SENA, aquellos con los cuales usted tiene mayor conexión vocacional. Por favor conteste con la mayor sinceridad posible ya que de esto depende la validez de la información.';
  }
}
