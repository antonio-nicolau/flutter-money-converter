import 'package:cambiodiario/app/modules/model/cambio_model.dart';
import 'package:cambiodiario/app/modules/repository/repository.dart';
import 'package:flutter/cupertino.dart';

class Controller {
  final bankSeleted = ValueNotifier<String>('');

  String get bank => bankSeleted.value;
  set bank(value) => bankSeleted.value = value;

  Future<List<CambioModel>?> getCambio() async {
    List<CambioModel> cambios = await Repository().getCambios();

    if (cambios.isNotEmpty) {
      return cleanData(cambios);
    }
    return null;
  }

  List<String> getBanks(cambios) {
    return List.generate(cambios.length, (i) => cambios[i].bank.toString());
  }

  cleanData(List<CambioModel> models) {
    List<CambioModel> newModels = [];
    for (CambioModel m in models) {
      m.dollarSellToday = removeDot(m.dollarSellToday);
      m.euroSellToday = removeDot(m.euroSellToday);
      newModels.add(m);
    }

    return newModels;
  }

  removeDot(value) => value.toString().replaceAll(",", ".");

  setDefaultMoneyFormat(String money) {
    return money.replaceAll(".", "");
  }

  convertToMoney(String money) {
    int count = 0;
    for (int i = money.length - 1; i > 0; i++) {
      if (count == 2) print('ja');
      count++;
    }
  }

  serialiseMoney(String money) {
    return money.replaceAll(",", ".");
  }
}
