import 'package:flutter/material.dart';

myBankSelectedWidg(controller) {
  return Container(
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      border: Border.all(
        color: Colors.amber,
        width: 1,
        style: BorderStyle.solid,
      ),
    ),
    child: ValueListenableBuilder(
      valueListenable: controller.bankSeleted,
      builder: (_, value, __) {
        return Text(
          '$value',
          style: TextStyle(color: Colors.amber),
        );
      },
    ),
  );
}
