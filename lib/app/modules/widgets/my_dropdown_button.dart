import 'package:flutter/material.dart';

myDropDownButton(controller, banks, Function f) {
  return DropdownButton<String>(
    isExpanded: true,
    value: '${controller.bank}',
    icon: Icon(Icons.arrow_downward),
    iconSize: 24,
    elevation: 16,
    style: TextStyle(color: Colors.deepPurple),
    underline: Container(
      height: 2,
      color: Colors.deepPurpleAccent,
    ),
    onChanged: (String? value) => f(value),
    items: banks.map<DropdownMenuItem<String>>((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Text(value),
      );
    }).toList(),
  );
}
