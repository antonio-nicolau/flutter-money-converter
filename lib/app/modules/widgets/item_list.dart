import 'package:cambiodiario/app/modules/model/cambio_model.dart';
import 'package:flutter/material.dart';

itemList(context, CambioModel? cambio) {
  return Container(
    padding: EdgeInsets.only(top: 10),
    child: Column(
      children: [
        Text(
          '${cambio?.bank}',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 10),
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              moneyVariation('Dólar', cambio),
              moneyVariation('Euro', cambio),
            ],
          ),
        )
      ],
    ),
  );
}

moneyVariation(label, CambioModel? cambio) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        '$label',
        style: TextStyle(
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
      ),
      SizedBox(height: 10),
      valueWidget(
        'Venda',
        label == 'Euro' ? cambio?.euroSellToday : cambio?.dollarSellToday,
      ),
      SizedBox(height: 5),
      valueWidget(
        'Compra',
        label == 'Euro' ? cambio?.euroBuyToday : cambio?.dollarBuyToday,
      ),
    ],
  );
}

valueWidget(label, value) {
  return Text(
    '$label $value',
    style: TextStyle(
      color: Colors.green,
    ),
  );
}
