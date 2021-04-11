import 'package:flame/game.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rpg_game/game.dart';

class MyGameWidget extends StatefulWidget {
  const MyGameWidget({Key key}) : super(key: key);

  @override
  State<MyGameWidget> createState() {
    return MyGameWidgetState();
  }
}

class MyGameWidgetState extends State<MyGameWidget> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: FutureBuilder(
          future: DefaultAssetBundle.of(context).loadString('assets/maps/main-map.json'),
          builder: (context, snapshot) {
            if(!snapshot.hasData || snapshot.connectionState == ConnectionState.waiting)
              return Container(
                alignment: Alignment.center,
                child: CircularProgressIndicator(),
              );
            final jsonMap = snapshot.data;

            return GameWidget<MyGame>(game: MyGame(jsonMap: jsonMap));
          },
        ),
      ),
    );
  }
}