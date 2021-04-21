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
import 'package:rpg_game/components/rock.dart';

const x = 500.0;
const y = 500.0;
final topLeft = Vector2(x, y);

class MyGame extends BaseGame with KeyboardEvents {
  String jsonMap;
  Map map;
  Player player = Player();
  Rock _rock = Rock();
  Selector _selector;
  Vector2 screenMousePosition;

  MyGame({this.jsonMap});

  @override
  Future<void> onLoad() async {
    //add(MyParallaxComponent());

    final tilesetImage = await images.load('sprites/tile_maps/grass.png');
    final tileset = SpriteSheet(image: tilesetImage, srcSize: Vector2.all(80));
    final matrix = Map.toList(this.jsonMap);

    add(
      map = Map(
        tileset,
        matrix,
      )
        ..x = x
        ..y = y,
    );

    map.setWalls(Rock());

    var playerSpriteSheet =
        await images.load('sprites/characters/goblin_lumberjack_black.png');
    final spriteSize = Vector2(65, 45);
    SpriteAnimationData spriteData = SpriteAnimationData.sequenced(
        amount: 6, stepTime: 0.80, textureSize: Vector2(65.0, 45.0));

    final playerSpawnPosition =
        map.getBlock(Vector2(x, y) + topLeft + Vector2(0, 150));
    player = Player.fromFrameData(playerSpriteSheet, spriteData)
      ..size = spriteSize;
    player.position.setFrom(map.getBlockPosition(playerSpawnPosition));
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
    if (isInMap) player.onMouseMove(screenMousePosition);
  }

  @override
  void onKeyEvent(RawKeyEvent e) async {
    final isKeyDown = e is RawKeyDownEvent;

    if (e.data.keyLabel == 'a') {
      player.velocity.x = isKeyDown ? -1 : 0;
    } else if (e.data.keyLabel == 'd') {
      player.velocity.x = isKeyDown ? 1 : 0;
    } else if (e.data.keyLabel == 'w') {
      player.velocity.y = isKeyDown ? -1 : 0;
    } else if (e.data.keyLabel == 's') {
      player.velocity.y = isKeyDown ? 1 : 0;
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

    Block block = map.getBlock(player.position);

    if (!map.containsBlock(block)) {
      print('x: ${block.x}, y: ${block.y}');
      if (block.y <= 0)
        player.y += 15;
      else if (block.y >= map.matrix.length)
        player.y -= 15;
      else if (block.x <= 0)
        player.x += 15;
      else if (block.x >= map.matrix[block.y].length) player.x -= 15;
    }
  }
}
