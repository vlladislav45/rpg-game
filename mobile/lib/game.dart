import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/game.dart';
import 'package:flame/keyboard.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart' hide Image;
import 'package:flutter/services.dart';
import 'package:rpg_game/components/map.dart';
import 'package:rpg_game/components/player.dart';
import 'package:rpg_game/components/selector.dart';

const x = 750.0;
const y = 150.0;
final topLeft = Vector2(x, y);

class MyGame extends BaseGame with KeyboardEvents, HasCollidables {
  String jsonMap;
  Map map;
  Player _player = Player();
  Selector _selector;
  Vector2 screenMousePosition;

  MyGame({this.jsonMap});


  @override
  Color backgroundColor() {
    return Colors.transparent;
  }

  @override
  Future<void> onLoad() async {
    final tilesetImage = await images.load('sprites/tile_maps/grass_default.png');
    final tileset = SpriteSheet(image: tilesetImage, srcSize: Vector2(40,20));
    final matrix = Map.toList(this.jsonMap);

    add(
      map = Map(
        tileset,
        matrix,
      )
        ..x = x
        ..y = y,
    );

    final playerSpriteSheet = await images.load('sprites/characters/goblin_lumberjack_black.png');
    final spriteSize = Vector2(65, 45);
    SpriteAnimationData spriteData = SpriteAnimationData.sequenced(
        amount: 6, stepTime: 0.80, textureSize: Vector2(65.0, 45.0));   

    _player = Player.fromFrameData(playerSpriteSheet, spriteData)
      ..size = spriteSize;
    
    final playerSpawnPosition =
        map.getBlock(Vector2(x, y) + topLeft + Vector2(0, 150));
    _player.position.setFrom(map.getBlockPosition(playerSpawnPosition));
    add(_player);

    //camera.cameraSpeed = 1;
    //camera.followComponent(_player);

    map.setWalls();

    // final selectorImage = await images.load('tile_maps/selector.png');
    // add(_selector = Selector(s, selectorImage));
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
  }

  @override
  void onTap() {
    final block = map.getBlock(screenMousePosition);
    bool isInMap = map.containsBlock(block);
    //if (isInMap) player.onMouseMove(screenMousePosition);
  }

  @override
  void onKeyEvent(RawKeyEvent e) async {
    final isKeyDown = e is RawKeyDownEvent;

    if (e.data.keyLabel == 'a') {
      _player.velocity.x = isKeyDown ? -1 : 0;
    } else if (e.data.keyLabel == 'd') {
      _player.velocity.x = isKeyDown ? 1 : 0;
    } else if (e.data.keyLabel == 'w') {
      _player.velocity.y = isKeyDown ? -1 : 0;
    } else if (e.data.keyLabel == 's') {
      _player.velocity.y = isKeyDown ? 1 : 0;
    }
  }

  void onMouseMove(PointerHoverEvent event) {
    screenMousePosition = event.localPosition.toVector2();
    final block = map.getBlock(screenMousePosition);
    _selector.show = map.containsBlock(block);
    _selector.position.setFrom(map.getBlockPosition(block) + topLeft);
  }

  @override
  void update(double dt) {
    super.update(dt);

    Block block = map.getBlock(_player.position);

    if (!map.containsBlock(block)) {
      if (block.y <= 0)
        _player.y += 15;
      else if (block.y >= map.matrix.length)
        _player.y -= 15;
      else if (block.x <= 0)
        _player.x += 15;
      else if (block.x >= map.matrix[block.y].length) _player.x -= 15;
    }
  }

}
