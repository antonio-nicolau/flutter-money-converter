// To parse this JSON data, do
//
//     final model = modelFromJson(jsonString);

import 'dart:convert';

List<CambioModel> modelFromJson(String str) => List<CambioModel>.from(json.decode(str).map((x) => CambioModel.fromJson(x)));

String modelToJson(List<CambioModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CambioModel {
  CambioModel({
    this.banco,
    this.dolarcompraAtual,
    this.euroCompraAtual,
    this.dolarVendaAtual,
    this.euroVendaAtual,
    this.dolarcompraPassado,
    this.euroCompraPassado,
    this.dolarVendaPassado,
    this.euroVendaPassado,
    this.dolarcompraVariacao,
    this.euroCompraVariacao,
    this.dolarVendaVariacao,
    this.euroVendaVariacao,
  });

  String banco;
  String dolarcompraAtual;
  String euroCompraAtual;
  String dolarVendaAtual;
  String euroVendaAtual;
  String dolarcompraPassado;
  String euroCompraPassado;
  String dolarVendaPassado;
  String euroVendaPassado;
  String dolarcompraVariacao;
  String euroCompraVariacao;
  String dolarVendaVariacao;
  String euroVendaVariacao;

  factory CambioModel.fromJson(Map<String, dynamic> json) => CambioModel(
    banco: json["banco"],
    dolarcompraAtual: json["dolarcompraAtual"],
    euroCompraAtual: json["euroCompraAtual"],
    dolarVendaAtual: json["dolarVendaAtual"],
    euroVendaAtual: json["euroVendaAtual"],
    dolarcompraPassado: json["dolarcompraPassado"],
    euroCompraPassado: json["euroCompraPassado"],
    dolarVendaPassado: json["dolarVendaPassado"],
    euroVendaPassado: json["euroVendaPassado"],
    dolarcompraVariacao: json["dolarcompraVariacao"],
    euroCompraVariacao: json["euroCompraVariacao"],
    dolarVendaVariacao: json["dolarVendaVariacao"],
    euroVendaVariacao: json["euroVendaVariacao"],
  );

  Map<String, dynamic> toJson() => {
    "banco": banco,
    "dolarcompraAtual": dolarcompraAtual,
    "euroCompraAtual": euroCompraAtual,
    "dolarVendaAtual": dolarVendaAtual,
    "euroVendaAtual": euroVendaAtual,
    "dolarcompraPassado": dolarcompraPassado,
    "euroCompraPassado": euroCompraPassado,
    "dolarVendaPassado": dolarVendaPassado,
    "euroVendaPassado": euroVendaPassado,
    "dolarcompraVariacao": dolarcompraVariacao,
    "euroCompraVariacao": euroCompraVariacao,
    "dolarVendaVariacao": dolarVendaVariacao,
    "euroVendaVariacao": euroVendaVariacao,
  };
}
