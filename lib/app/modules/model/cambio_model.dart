import 'dart:convert';

List<CambioModel> modelFromJson(String str) => List<CambioModel>.from(
    json.decode(str).map((x) => CambioModel.fromJson(x)));

class CambioModel {
  CambioModel({
    this.bank,
    this.dollarBuyToday,
    this.euroBuyToday,
    this.dollarSellToday,
    this.euroSellToday,
    this.dollarBuyPast,
    this.euroBuyPast,
    this.dollarSellPast,
    this.euroSellPast,
    this.dollarBuyVariation,
    this.euroBuyVariation,
    this.dollarSellVariation,
    this.euroSellVariation,
  });

  String? bank;
  String? dollarBuyToday;
  String? euroBuyToday;
  String? dollarSellToday;
  String? euroSellToday;
  String? dollarBuyPast;
  String? euroBuyPast;
  String? dollarSellPast;
  String? euroSellPast;
  String? dollarBuyVariation;
  String? euroBuyVariation;
  String? dollarSellVariation;
  String? euroSellVariation;

  factory CambioModel.fromJson(Map<String, dynamic> json) => CambioModel(
        bank: json["bank"],
        dollarBuyToday: json["dollarBuyToday"].toString(),
        euroBuyToday: json["euroBuyToday"].toString(),
        dollarSellToday: json["dollarSellToday"].toString(),
        euroSellToday: json["euroSellToday"].toString(),
        dollarBuyPast: json["dollarBuyPast"].toString(),
        euroBuyPast: json["euroBuyPast"].toString(),
        dollarSellPast: json["dollarSellPast"].toString(),
        euroSellPast: json["euroSellPast"].toString(),
        dollarBuyVariation: json["dollarBuyVariation"],
        euroBuyVariation: json["euroBuyVariation"],
        dollarSellVariation: json["dollarSellVariation"],
        euroSellVariation: json["euroSellVariation"],
      );
}
