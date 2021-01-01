import 'ad_manager.dart';
import 'controller.dart';
import 'cambio_model.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'api.dart';

const String testDevice = '30CC53789FE2FB3AB6C7C7F0B1240215';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool hasError = false;
  Controller _controller;
  final _kwanzaController = TextEditingController();
  final _dolarController = TextEditingController();
  final _euroController = TextEditingController();
  double dolarVenda, euroVenda;
  List<String> _bancosList = List();
  String _bancoSelected;
  List<CambioModel> _modelList;

  double dolar;
  double euro;

  static const MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    keywords: <String>['money', 'travel'],
    nonPersonalizedAds: false,
    testDevices: testDevice != null ? <String>[testDevice] : null,
  );

  BannerAd _bannerAd;

  BannerAd createBannerAd() {
    return BannerAd(
      adUnitId: AdManager.bannerAdUnitId,
      size: AdSize.smartBanner,
      targetingInfo: targetingInfo,
      listener: (MobileAdEvent event) {
        if (event == MobileAdEvent.failedToLoad) {
          _loadBottomBannerAd();
        } else if (event == MobileAdEvent.closed) {
          _bannerAd = createBannerAd();
          _loadBottomBannerAd();
        }

        print("BannerAd event is $event");
      },
    );
  }

  @override
  void initState() {
    _controller = Controller();

    _fetchData();

    FirebaseAdMob.instance.initialize(appId: AdManager.appID).then((value) {
      _bannerAd = createBannerAd();
      _loadBottomBannerAd();
    });

    super.initState();
  }

  // TODO: Implement _loadBannerAd()
  void _loadBottomBannerAd() {
    _bannerAd
      ..load()
      ..show(
        // Banner Position
        anchorType: AnchorType.bottom,
      );
  }

  @override
  void dispose() {
    _bannerAd.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            '\$ Câmbio Diário \$',
            style: TextStyle(color: Colors.black),
          ),
          actions: [
            IconButton(
              tooltip: "Limpar campos",
              icon: Icon(Icons.restore_from_trash),
              onPressed: _limpaCampos,
            ),
            IconButton(
              tooltip: "Selecionar banco",
              icon: Icon(
                Icons.edit,
                color: Colors.black,
              ),
              onPressed: _showMyDialog,
            ),
          ],
          backgroundColor: Colors.amber,
        ),
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          padding: EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              hasError
                  ? Center(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 100.0,
                          ),
                          Text(
                            'Não foi possível acessar o servidor, clique no botão para tentar novamente',
                            style:
                                TextStyle(color: Colors.amber, fontSize: 22.0),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          FlatButton(
                            onPressed: () {
                              setState(() {
                                hasError = false;
                              });
                              _fetchData();
                            },
                            child: Text(
                              'Recarregar',
                              style: TextStyle(fontSize: 20.0),
                            ),
                            color: Colors.amber,
                          ),
                        ],
                      ),
                    )
                  : _modelList == null
                      ? Center(
                          child: Column(
                            children: [
                              SizedBox(
                                height: 100.0,
                              ),
                              CircularProgressIndicator(
                                backgroundColor: Colors.amber,
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Text(
                                'Carregando, por favor aguarde...',
                                style: TextStyle(
                                  color: Colors.amber,
                                  fontSize: 20.0,
                                ),
                              ),
                            ],
                          ),
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Icon(
                              Icons.monetization_on,
                              size: 120.0,
                              color: Colors.amber,
                            ),
                            buildTextField('AOA ', 'Kwanza', _kwanzaController,
                                _kwanzaChanged),
                            Divider(),
                            buildTextField(
                                '€ ', 'Euros', _euroController, _euroChanged),
                            Divider(),
                            buildTextField('USD ', 'Dólares', _dolarController,
                                _dolarChanged),
                            SizedBox(
                              height: 15.0,
                            ),
                            SizedBox(
                              height: 8.0,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  'Câmbio do banco',
                                  style: TextStyle(
                                      fontSize: 20.0, color: Colors.amber),
                                ),
                                SizedBox(
                                  height: 8.0,
                                ),
                                Container(
                                  padding: EdgeInsets.all(10.0),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.amber,
                                        width: 1,
                                        style: BorderStyle.solid),
                                  ),
                                  child: Text(
                                    '$_bancoSelected',
                                    style: TextStyle(color: Colors.amber),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
            ],
          ),
        ));
  }

  _fetchData() {
    Api().fetchAllData().then((value) {
      if (value != null) {
        setState(() {
          _modelList = _controller.serialiseData(value);

          //MAKE A LIST OF BANKS
          _bancosList = List.generate(
              _modelList.length, (index) => _modelList[index].banco);

          _bancoSelected = _bancosList[16];
          setDolarAndEuroValue();

          _euroController.text = "1";
          updateAllCampos();
        });
      } else {
        hasError = true;
        setState(() {});
      }
    }).catchError((error) {
      hasError = true;
      setState(() {});
    });
  }

  setDolarAndEuroValue() {
    CambioModel m = _modelList
        .where((element) => element.banco == _bancoSelected)
        .toList()[0];

    setState(() {
      dolarVenda = double.parse(m.dolarVendaAtual);
      euroVenda = double.parse(m.euroVendaAtual);
    });
  }

  _kwanzaChanged(value) {
    double kwanza = double.parse(value);

    _dolarController.text = (kwanza / dolarVenda).toStringAsFixed(2);
    _euroController.text = (kwanza / euroVenda).toStringAsFixed(2);
  }

  _dolarChanged(value) {
    dolar = double.parse(value);
    _kwanzaController.text = (this.dolar * dolarVenda).toStringAsFixed(2);
    _euroController.text =
        (this.dolar * dolarVenda / euroVenda).toStringAsFixed(2);
  }

  _euroChanged(value) {
    euro = double.parse(value);
    _kwanzaController.text = (this.euro * euroVenda).toStringAsFixed(2);
    _dolarController.text =
        (this.euro * euroVenda / dolarVenda).toStringAsFixed(2);
  }

  updateAllCampos() {
    _euroChanged(_euroController.text);
  }

  _limpaCampos() {
    _kwanzaController.text = '';
    _dolarController.text = '';
    _euroController.text = '';
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Câmbio'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text('Seleciona um banco'),
                DropdownButton<String>(
                  isExpanded: true,
                  value: _bancoSelected,
                  icon: Icon(Icons.arrow_downward),
                  iconSize: 24,
                  elevation: 16,
                  style: TextStyle(color: Colors.deepPurple),
                  underline: Container(
                    height: 2,
                    color: Colors.deepPurpleAccent,
                  ),
                  onChanged: (String value) {
                    setState(() {
                      _bancoSelected = value;

                      setDolarAndEuroValue();
                      updateAllCampos();
                    });
                  },
                  items:
                      _bancosList.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  '$_bancoSelected',
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
}

Widget buildTextField(
    String _prefix, String _label, TextEditingController c, Function f) {
  return TextField(
    controller: c,
    keyboardType: TextInputType.number,
    decoration: InputDecoration(
      prefixText: _prefix,
      labelText: _label,
      labelStyle: TextStyle(color: Colors.amber),
      prefixStyle: TextStyle(color: Colors.amber),
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white, width: 1.0)),
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.amber, width: 1.0)),
    ),
    style: TextStyle(color: Colors.amber, fontSize: 22.0),
    onChanged: f,
  );
}
