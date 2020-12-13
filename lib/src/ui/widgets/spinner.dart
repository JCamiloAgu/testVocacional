import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Spinner extends StatelessWidget {
  final String label;
  final dynamic value;
  final List<DropdownMenuItem<dynamic>> items;
  final Function(dynamic) onChanged;

  const Spinner({this.label, this.value, this.items, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          label,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        DropdownButton(
          value: value,
          items: items,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
