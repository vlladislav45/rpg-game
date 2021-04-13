import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/game.dart';
import 'package:flame/gestures.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart' hide Image;
import 'package:rpg_game/components/map.dart';
import 'package:rpg_game/components/player.dart';
import 'package:rpg_game/utils/hex_color.dart';

const x = 500.0;
const y = 500.0;
const s = 48.0;
final topLeft = Vector2(x, y);
final originColor = Paint()..color = Color(HexColor.convertHexColor('#C0C0C0'));

class MyGame extends BaseGame with MouseMovementDetector, TapDetector {
  String jsonMap;
  Map map;
  Player player = Player();

  Vector2 screenMousePosition;

  MyGame({this.jsonMap});

  @override
  Future<void> onLoad() async {
    //viewport = FixedResolutionViewport(Vector2(1500, 1500));

    final tilesetImage = await images.load('tile_maps/tiles.png');
    final tileset = SpriteSheet(image: tilesetImage, srcSize: Vector2.all(32));
    final matrix = Map.toList(this.jsonMap);
    
    add(
      map = Map(
        tileset,
        matrix,
        destTileSize: Vector2.all(s),
      )
        ..x = x
        ..y = y,
    );

    var playerSpriteSheet = await images.load(
        'characters/goblin_lumberjack_black.png');
    final spriteSize = Vector2(152 * 1.4, 142 * 1.4);
    SpriteAnimationData spriteData = SpriteAnimationData.sequenced(
        amount: 6, stepTime: 0.80, textureSize: Vector2(65.0, 45.0));

    Vector2 charCoordinates = map.getBlockPositionInts(2, 3);
    player = Player.fromFrameData(playerSpriteSheet, spriteData)
      ..x = charCoordinates.x
      ..y = charCoordinates.y
      ..size = spriteSize;


    add(player);
    //    for(int i = 0; i < map.matrix.length; i++) {
    //   for(int j = 0; j < map.matrix[i].length; j++) {
    //     //  add(Rock(map.cartToIso(Vector2(Map.genCoord(), Map.genCoord()))));
    //     if(map.getBlockPositionInts(i, j) == map.cartToIso(Vector2(0,1))) {
    //       add(player);
    //     }
    //   }
    // }
    

    camera.cameraSpeed = 1;
    camera.followComponent(player);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    canvas.drawRect(const Rect.fromLTWH(x - 1, y - 1, 3, 3), originColor);
  }

  @override
  void onTap() {
    player.onMouseMove(screenMousePosition);
  }

  @override
  void onMouseMove(PointerHoverEvent event) {
    screenMousePosition = event.localPosition.toVector2();
  }

  @override
  void update(double dt) {
    super.update(dt);
  }
}