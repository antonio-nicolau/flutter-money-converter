import 'package:flutter/material.dart';

myTextField(
    String _prefix, String _label, TextEditingController c, Function f) {
  return TextField(
    controller: c,
    keyboardType: TextInputType.number,
    decoration: InputDecoration(
      prefixText: _prefix,
      labelText: _label,
      labelStyle: TextStyle(color: Colors.amber),
      prefixStyle: TextStyle(color: Colors.amber),
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white, width: 1.0)),
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.amber, width: 1.0)),
    ),
    style: TextStyle(color: Colors.amber, fontSize: 22.0),
    onChanged: (value) => value.isNotEmpty ? f(value) : null,
  );
}
