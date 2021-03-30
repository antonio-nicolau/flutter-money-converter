import 'package:cambiodiario/app/modules/widgets/my_dropdown_button.dart';
import 'package:flutter/material.dart';

Future<void> dialogChooseBanks(context, controller, banks, Function f) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text('Seleciona um banco'),
              myDropDownButton(controller, banks, (value) {
                f(value);
              }),
              SizedBox(
                height: 10.0,
              ),
              ValueListenableBuilder(
                valueListenable: controller.bankSeleted,
                builder: (_, value, __) {
                  return Text(
                    '$value',
                  );
                },
              )
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text('Fechar'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
