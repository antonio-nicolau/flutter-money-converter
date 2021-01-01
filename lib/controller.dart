import 'cambio_model.dart';

class Controller {
  serialiseData(List<CambioModel> models) {
    List<CambioModel> newModels = List<CambioModel>();
    for (CambioModel m in models) {
      m.dolarVendaAtual = m.dolarVendaAtual.replaceAll(",", ".").toString();
      m.euroVendaAtual = m.euroVendaAtual.replaceAll(",", ".").toString();
      newModels.add(m);
    }

    return newModels;
  }

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
