import 'dart:async';
import 'package:cambiodiario/app/modules/pages/home_page.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 3), () {
      Navigator.pop(context);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext c) => HomePage(),
        ),
      );
    });

    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.monetization_on,
              color: Colors.amber,
              size: 150.0,
            ),
            SizedBox(
              height: 15.0,
            ),
            Center(
              child: Text(
                'Câmbio Diário',
                style: TextStyle(
                  fontSize: 22.0,
                  color: Colors.amber,
                ),
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            Center(
              child: Text(
                'Conversões a um clique',
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.amber,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
