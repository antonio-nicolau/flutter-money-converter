import 'package:cambiodiario/app/modules/controller/calc_controller.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  CalcController calc = CalcController();

  group("Calc controller Test", () {
    test("Convert to money number", () {
      expect(calc.toMoney('13912983.02'), equals('13.912.983.02'));
      expect(calc.toMoney('13912983'), equals('13.912.983'));
      expect(calc.toMoney('13983'), equals('13.983'));
      expect(calc.toMoney('13999912983.94'), equals('13.999.912.983.94'));
    });
  });
}
