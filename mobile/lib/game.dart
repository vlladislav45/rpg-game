import 'package:flame/game.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rpg_game/map/isometric_tile_map.dart';

class MyGame extends StatefulWidget {
  const MyGame({Key key}) : super(key: key);

  @override
  State<MyGame> createState() {
    return MyGameState();
  }
}

class MyGameState extends State<MyGame> {
  final IsometricTileMap _isometricTileMap = IsometricTileMap();
  //a
  
  @override
  Widget build(BuildContext context) {
    final myGame = _isometricTileMap;
    return MaterialApp(
      home: Scaffold(
        body: GameWidget<IsometricTileMap>(game: myGame),
      ),
    );
  }
}