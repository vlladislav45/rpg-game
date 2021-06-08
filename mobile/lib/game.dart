import 'dart:ui';
import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/game.dart';
import 'package:flame/gestures.dart';
import 'package:flame/keyboard.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart' hide Image;
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';
import 'package:rpg_game/components/portal.dart';
import 'package:rpg_game/maps/maps/map.dart';
import 'package:rpg_game/components/character.dart';
import 'package:rpg_game/components/selector.dart';
import 'package:rpg_game/maps/town.dart';

const x = 750.0;
const y = 150.0;
final topLeft = Vector2(x, y);

typedef VoidCallback = void Function();

class MyGame extends BaseGame with MouseMovementDetector, KeyboardEvents, HasCollidables, HasTapableComponents,
    ScrollDetector {
  //Properties
  String jsonMap;
  int mapLevel;
  Vector2 screenMousePosition;

  //Town
  Town _town;
  
  // Components
  Map map;
  Character _character = Character();
  Selector _selector;
  Portal _portal;
  
  //Functions
  VoidCallback selectMapLevel;

  MyGame({this.jsonMap, this.mapLevel});

  @override
  Color backgroundColor() {
    return Colors.transparent;
  }

  void loadMapLevel() async {
    final tilesetImage = await images.load('sprites/tile_maps/grass_default.png');
    final tileset = SpriteSheet(image: tilesetImage, srcSize: Vector2(151,71));
    final matrix = Map.toList(this.jsonMap);

    // Add main town
    add(
      map = Map(
        tileset,
        matrix,
      )
        ..x = x
        ..y = y,
    );

    spawnCharacter();
  }

  void spawnCharacter() async {
    List<Sprite> characterSprites = [];
    int countIdleSprites = 84;
    for(var i = 0; i <= countIdleSprites; i+=4) {
      if(i >= 10) characterSprites.add(await Sprite.load('sprites/characters/knights/seq_antlerKnight/A_right00${i}.png'));
      else characterSprites.add(await Sprite.load(
          'sprites/characters/knights/seq_antlerKnight/A_right000${i}.png'));
    }
    final idle = SpriteAnimation.spriteList(characterSprites, stepTime: 0.20);

    // running
    countIdleSprites = 124;
    for(var i = 88; i < countIdleSprites; i+=4)
      if(i >= 100) characterSprites.add(await Sprite.load('sprites/characters/knights/seq_antlerKnight/A_right0${i}.png'));
      else characterSprites.add(await Sprite.load('sprites/characters/knights/seq_antlerKnight/A_right00${i}.png'));
    final hit = SpriteAnimation.spriteList(characterSprites, stepTime: 0.10);

    final characterSpawnPosition = map.getBlock(Vector2(x, y) + topLeft + Vector2(0, 150));
    _character = Character(
      size: Vector2(200,200),
      position: map.getBlockPosition(characterSpawnPosition),
    )
    ..animations = {
      CharacterState.idle: idle,
      CharacterState.hit: hit,
    }
    ..current = CharacterState.idle;
    add(_character);
  }

  void spawnTown() async {
    //Spawn town
    final townSprite = await Sprite.load('bg/Background_3_3840x2160.jpg');
    _town = Town(size: size, position: Vector2(0, 0))..sprite = townSprite;
    add(_town);
    _town.spawnTown();
  }

  @override
  Future<void> onLoad() async {
    print('MY MAP LEVEL: $mapLevel');
    mapLevel == null ? spawnTown() : loadMapLevel();

    //camera.cameraSpeed = 1;
    // camera.followComponent(_character);

    //Add walls around the town
    //map.setWalls();

    // final selectorImage = await images.load('tile_maps/selector.png');
    // add(_selector = Selector(s, selectorImage));
  }

  @override
  void onMouseMove(PointerHoverInfo event) {
    final target = event.eventPosition.game;
    // print(target);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

  }

  @override
  void onKeyEvent(RawKeyEvent e) async {
    final isKeyDown = e is RawKeyDownEvent;

    if(e is RawKeyUpEvent) {
      print('Up');
      _character.current = CharacterState.idle;
    }
    if (e.data.keyLabel == 'a') {
      _character.velocity.x = isKeyDown ? -1 : 0;
    } else if (e.data.keyLabel == 'd') {
      _character.velocity.x = isKeyDown ? 1 : 0;
    } else if (e.data.keyLabel == 'w') {
      _character.velocity.y = isKeyDown ? -1 : 0;
    } else if (e.data.keyLabel == 's') {
      _character.velocity.y = isKeyDown ? 1 : 0;
    } else if (e.data.keyLabel == '1') {
      _character.current = CharacterState.hit;
    }
  }

  @override
  void update(double dt) {
    super.update(dt);

    // Block block = map.getBlock(_character.position);
    //
    // if (!map.containsBlock(block)) {
    //   if (block.y <= 0)
    //     _character.y += 15;
    //   else if (block.y >= map.matrix.length)
    //     _character.y -= 15;
    //   else if (block.x <= 0)
    //     _character.x += 15;
    //   else if (block.x >= map.matrix[block.y].length) _character.x -= 15;
    // }
  }

  static const _zoomPerScrollUnit = 0.001;

  @override
  void onScroll(PointerScrollInfo event) {
    // camera.zoom += event.scrollDelta.game.y * _zoomPerScrollUnit;
  }
}
