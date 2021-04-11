import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/game.dart';
import 'package:flame/gestures.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart' hide Image;
import 'package:rpg_game/components/player.dart';

const x = 500.0;
const y = 500.0;
const s = 48.0;
final topLeft = Vector2(x, y);
final originColor = Paint()..color = const Color(0xFFFF00FF);

class MyGame extends BaseGame with MouseMovementDetector, TapDetector {
  IsometricTileMapComponent map;
  Player player = Player();

  Vector2 screenMousePosition;

  MyGame();

  @override
  Future<void> onLoad() async {
    final tilesetImage = await images.load('tile_maps/tiles.png');
    final tileset = SpriteSheet(image: tilesetImage, srcSize: Vector2.all(32));
    final matrix = [
      [3, 1, 1, 1, 0, 0, 0],
      [-1, 1, 2, 1, 0, 0, 0],
      [-1, 0, 1, 1, 0, 0, 0],
      [-1, 1, 1, 1, 0, 0, 0],
      [1, 1, 1, 1, 0, 2, 0],
      [1, 3, 3, 3, 0, 3, 2],
    ];
    add(
      map = IsometricTileMapComponent(
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
    player = Player.fromFrameData(playerSpriteSheet, spriteData)
      ..x = 150
      ..y = 30
      ..size = spriteSize;
    add(player);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    canvas.drawRect(const Rect.fromLTWH(x - 1, y - 1, 3, 3), originColor);
    player.render(canvas);
  }

  @override
  void onTap() {
    player.onMouseMove(screenMousePosition);
  }

  @override
  void onMouseMove(PointerHoverEvent event) {
    screenMousePosition = event.localPosition.toVector2();
    //player = Player(position: screenPosition);
  }

  @override
  void update(double dt) {
    super.update(dt);
    // player..x += 2;
    // if(player.x > size.x)
    //   player.x -= 2;
    // else if(player.x < size.x)
    //   player.x += 2;
  }
}