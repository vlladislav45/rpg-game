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

class IsometricTileMap extends BaseGame with MouseMovementDetector {
  IsometricTileMapComponent base;

  IsometricTileMap();

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
    final player = Player(Vector2(0, 0));

    add(
      base = IsometricTileMapComponent(
        tileset,
        matrix,
        destTileSize: Vector2.all(s),
      )
        ..x = x
        ..y = y,
    );
    add(player);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    canvas.drawRect(const Rect.fromLTWH(x - 1, y - 1, 3, 3), originColor);
  }

  @override
  void onMouseMove(PointerHoverEvent event) {
    final screenPosition = event.localPosition.toVector2();
  }
}
