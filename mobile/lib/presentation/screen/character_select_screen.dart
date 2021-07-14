
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CharacterSelectScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            AutoSizeText('Hello'),

            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/game');
              },
              child: Container(
                child: AutoSizeText(
                  'Get in',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                width: MediaQuery.of(context).size.width / 7,
                height: MediaQuery.of(context).size.width / 16,
                alignment: Alignment.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}