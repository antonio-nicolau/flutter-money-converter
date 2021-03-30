import 'package:cambiodiario/app/modules/ad_manager.dart';
import 'package:cambiodiario/app/modules/model/cambio_model.dart';
import 'package:cambiodiario/app/modules/widgets/item_list.dart';
import 'package:flutter/material.dart';

class VariationPage extends StatefulWidget {
  List<CambioModel>? cambios;

  VariationPage({@required this.cambios});
  @override
  _VariationPageState createState() => _VariationPageState();
}

class _VariationPageState extends State<VariationPage> {
  @override
  void initState() {
    AdManager().createInterstialAd(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.fromLTRB(15, 30, 15, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () => Navigator.pop(context),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: widget.cambios?.length,
                itemBuilder: (_, i) {
                  final cambio = widget.cambios?[i];
                  return itemList(_, cambio);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
