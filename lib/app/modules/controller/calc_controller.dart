import 'package:cambiodiario/app/modules/model/cambio_model.dart';

class CalcController {
  List<CambioModel>? cambios;
  double dollarSell = 0, euroSell = 0;

  CalcController({this.cambios});

  //Convert number to Money format
  String? toMoney(String money) {
    int c = 0;
    String end = '';
    int index = money.length;

    if (money.contains('.')) {
      index = money.lastIndexOf('.');
      //Take the part after dot if available
      end = money.substring(index);
    }
    //Put each number into a list and respective dot ( . )
    List auxMoney = [];
    for (int i = index - 1; i >= 0; i--) {
      if (c < 3) {
        auxMoney.add(money[i]);
        c++;
      } else {
        auxMoney.add('.');
        auxMoney.add(money[i]);
        c = 1;
      }
    }
    //Join all numbers again
    money = '';
    for (int i = auxMoney.length - 1; i >= 0; i--) money += auxMoney[i];

    return money + end;
  }

  setDefaultValues(bank) {
    final data = cambios?.where((item) => item.bank == bank).toList().first;

    this.dollarSell = double.parse(data!.dollarSellToday.toString());
    this.euroSell = double.parse(data.euroSellToday.toString());
  }

  convertFromKwanza(value) {
    double kwanza = double.parse(value);
    final dollar = (kwanza / this.dollarSell);
    final euro = (kwanza / this.euroSell);

    return {
      'dollar': toMoney(dollar.toStringAsFixed(2)),
      'euro': toMoney(euro.toStringAsFixed(2)),
    };
  }

  convertFromDollar(value) {
    double dollar = double.parse(value);

    final kwanza = (dollar * this.dollarSell);
    final euro = (dollar * this.dollarSell / this.euroSell);

    return {
      'kwanza': toMoney(kwanza.toStringAsFixed(2)),
      'euro': toMoney(euro.toStringAsFixed(2)),
    };
  }

  convertFromEuro(value) {
    final euro = double.parse(value);
    final kwanza = (euro * this.euroSell);
    final dollar = (euro * this.euroSell / this.dollarSell);

    return {
      'kwanza': toMoney(kwanza.toStringAsFixed(2)),
      'dollar': toMoney(dollar.toStringAsFixed(2)),
    };
  }
}
