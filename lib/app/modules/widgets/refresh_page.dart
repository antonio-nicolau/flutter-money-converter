import 'package:flutter/material.dart';

refreshPage(Function f) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      SizedBox(height: 100.0),
      Text(
        'Não foi possível acessar o servidor, tente novamente',
        style: TextStyle(
          color: Colors.amber,
          fontSize: 20.0,
        ),
        textAlign: TextAlign.center,
      ),
      SizedBox(
        height: 20.0,
      ),
      IconButton(
        onPressed: () => f(),
        icon: Icon(
          Icons.refresh,
          size: 34,
          color: Colors.amber,
        ),
      ),
    ],
  );
}
