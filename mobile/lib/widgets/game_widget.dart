import 'package:flame/game.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rpg_game/game.dart';

class MyGameWidget extends StatefulWidget {
  const MyGameWidget({Key key}) : super(key: key);

  @override
  State<MyGameWidget> createState() {
    return MyGameWidgetState();
  }
}

class MyGameWidgetState extends State<MyGameWidget> {
  final MyGame _myGame = MyGame();
  
  @override
  Widget build(BuildContext context) {
    final myGame = _myGame;
    return MaterialApp(
      home: Scaffold(
        body: GameWidget<MyGame>(game: myGame),
      ),
    );
  }
}