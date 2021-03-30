import 'package:cambiodiario/app/modules/ad_manager.dart';
import 'package:cambiodiario/app/modules/controller/calc_controller.dart';
import 'package:cambiodiario/app/modules/controller/controller.dart';
import 'package:cambiodiario/app/modules/pages/variation_page.dart';
import 'package:cambiodiario/app/modules/widgets/ad_container.dart';
import 'package:cambiodiario/app/modules/widgets/dialog/alert_dialog_banks.dart';
import 'package:cambiodiario/app/modules/widgets/my_bank_selected.dart';
import 'package:cambiodiario/app/modules/widgets/progress_bar.dart';
import 'package:cambiodiario/app/modules/widgets/refresh_page.dart';
import 'package:cambiodiario/app/modules/widgets/my_text_field.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:cambiodiario/app/modules/model/cambio_model.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final kwanzaController = TextEditingController();
  final dolarController = TextEditingController();
  final euroController = TextEditingController();

  final controller = Controller();
  CalcController? calc;
  List<String>? banks;
  List<CambioModel>? cambios;
  var banner1, banner2;
  var adWidget1, adWidget2;

  @override
  void initState() {
    banner1 = AdManager().createAd();
    banner2 = AdManager().createAd();
    banner1.load();
    banner2.load();

    adWidget1 = AdWidget(ad: banner1);
    adWidget2 = AdWidget(ad: banner2);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    euroController.text = "1";

    return Scaffold(
      appBar: AppBar(
        title: Icon(Icons.monetization_on),
        actions: [
          TextButton(
            child: Text(
              "Escolher banco",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
            onPressed: () {
              dialogChooseBanks(
                context,
                controller,
                banks,
                (value) {
                  controller.bank = value;

                  calc?.setDefaultValues(controller.bank);
                  fromEuro(euroController.text);
                },
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.arrow_forward_ios),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => VariationPage(cambios: cambios),
              ),
            ),
          ),
        ],
        backgroundColor: Colors.amber,
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10.0),
        child: FutureBuilder<List<CambioModel>?>(
          future: controller.getCambio(),
          builder: (_, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting ||
                snapshot.connectionState == ConnectionState.none)
              return progressBar();
            else if (snapshot.hasData) {
              cambios = snapshot.data;
              banks = controller.getBanks(cambios);
              controller.bank = banks![15];

              calc = CalcController(cambios: snapshot.data);
              calc?.setDefaultValues(controller.bank);
              fromEuro("1");

              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Icon(Icons.monetization_on, size: 120.0, color: Colors.amber),
                  myTextField('AOA ', 'Kwanza', kwanzaController, fromKwanza),
                  SizedBox(height: 15.0),
                  myTextField('€ ', 'Euros', euroController, fromEuro),
                  SizedBox(height: 15.0),
                  myTextField('USD ', 'Dólares', dolarController, fromDollar),
                  SizedBox(height: 15.0),
                  myBankSelectedWidg(controller),
                  SizedBox(height: 15),
                  containerAd(adWidget1, banner1),
                  SizedBox(height: 15),
                  containerAd(adWidget2, banner2),
                ],
              );
            }
            return refreshPage(() {
              setState(() {});
            });
          },
        ),
      ),
    );
  }

  fromKwanza(value) {
    try {
      final data = calc?.convertFromKwanza(value);
      dolarController.text = data['dollar'];
      euroController.text = data['euro'];
    } catch (e) {
      return;
    }
  }

  fromDollar(value) {
    try {
      final data = calc?.convertFromDollar(value);
      kwanzaController.text = data['kwanza'];
      euroController.text = data['euro'];
    } catch (e) {
      return;
    }
  }

  fromEuro(value) {
    try {
      final data = calc?.convertFromEuro(value);
      kwanzaController.text = data['kwanza'];
      dolarController.text = data['dollar'];
    } catch (e) {
      return;
    }
  }
}
