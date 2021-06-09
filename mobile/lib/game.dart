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

class MyGame extends BaseGame with MouseMovementDetector, KeyboardEvents, HasCollidables, HasTapableComponents, ScrollDetector {
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
    /// Right direction
    List<Sprite> characterSprites = [];
    int countSprites = 76;
    for (var i = 12; i <= countSprites; i += 4)
      characterSprites.add(await Sprite.load('sprites/characters/knights/seq_antlerKnight/A_right00${i}.png'));
    final idleRight = SpriteAnimation.spriteList(
        characterSprites, stepTime: 0.20);

    // right hit
    countSprites = 124;
    characterSprites = [];
    for (var i = 88; i < countSprites; i += 4)
      if (i >= 100)
        characterSprites.add(await Sprite.load(
            'sprites/characters/knights/seq_antlerKnight/A_right0${i}.png'));
      else
        characterSprites.add(await Sprite.load(
            'sprites/characters/knights/seq_antlerKnight/A_right00${i}.png'));
    final hitRight = SpriteAnimation.spriteList(
        characterSprites, stepTime: 0.20);

    // right running
    countSprites = 264;
    characterSprites = [];
    for (var i = 204; i < countSprites; i += 4)
      characterSprites.add(await Sprite.load(
          'sprites/characters/knights/seq_antlerKnight/A_right0${i}.png'));
    final runningRight = SpriteAnimation.spriteList(
        characterSprites, stepTime: 0.10);

    /// Down direction
    // Idle down
    countSprites = 76;
    characterSprites = [];
    for (var i = 12; i < countSprites; i += 4)
      characterSprites.add(await Sprite.load(
          'sprites/characters/knights/seq_antlerKnight/C_Front00${i}.png'));
    final idleDown = SpriteAnimation.spriteList(
        characterSprites, stepTime: 0.20);

    // Hit down
    countSprites = 120;
    characterSprites = [];
    for (var i = 80; i < countSprites; i += 4)
      if (i >= 100)
        characterSprites.add(await Sprite.load(
            'sprites/characters/knights/seq_antlerKnight/C_Front0${i}.png'));
      else
        characterSprites.add(await Sprite.load(
            'sprites/characters/knights/seq_antlerKnight/C_Front00${i}.png'));
      final hitDown = SpriteAnimation.spriteList(
          characterSprites, stepTime: 0.20);

      // Running down
      countSprites = 264;
      characterSprites = [];
      for (var i = 204; i < countSprites; i += 4)
        characterSprites.add(await Sprite.load(
            'sprites/characters/knights/seq_antlerKnight/C_Front0${i}.png'));
      final runningDown = SpriteAnimation.spriteList(
          characterSprites, stepTime: 0.10);

      /// Left direction
      // Idle left
      countSprites = 76;
      characterSprites = [];
      for (var i = 12; i < countSprites; i += 4)
        characterSprites.add(await Sprite.load(
            'sprites/characters/knights/seq_antlerKnight/E_Left00${i}.png'));
      final idleLeft = SpriteAnimation.spriteList(
          characterSprites, stepTime: 0.20);

      // Hit left
      countSprites = 120;
      characterSprites = [];
      for (var i = 80; i < countSprites; i += 4)
        if (i >= 100)
          characterSprites.add(await Sprite.load(
              'sprites/characters/knights/seq_antlerKnight/E_Left0${i}.png'));
        else
          characterSprites.add(await Sprite.load(
              'sprites/characters/knights/seq_antlerKnight/E_Left00${i}.png'));
        final hitLeft = SpriteAnimation.spriteList(
            characterSprites, stepTime: 0.20);

        // Running left
        countSprites = 264;
        characterSprites = [];
        for (var i = 204; i < countSprites; i += 4)
          characterSprites.add(await Sprite.load(
              'sprites/characters/knights/seq_antlerKnight/E_Left0${i}.png'));
        final runningLeft = SpriteAnimation.spriteList(
            characterSprites, stepTime: 0.10);

        /// Up direction
        // Idle up
        countSprites = 76;
        characterSprites = [];
        for (var i = 12; i < countSprites; i += 4)
          characterSprites.add(await Sprite.load(
              'sprites/characters/knights/seq_antlerKnight/G_Back00${i}.png'));
        final idleUp = SpriteAnimation.spriteList(
            characterSprites, stepTime: 0.20);

        // Hit left
        countSprites = 120;
        characterSprites = [];
        for (var i = 80; i < countSprites; i += 4)
          if (i >= 100)
            characterSprites.add(await Sprite.load(
                'sprites/characters/knights/seq_antlerKnight/G_Back0${i}.png'));
          else
            characterSprites.add(await Sprite.load(
                'sprites/characters/knights/seq_antlerKnight/G_Back00${i}.png'));
          final hitUp = SpriteAnimation.spriteList(
              characterSprites, stepTime: 0.20);

          // Running left
          countSprites = 264;
          characterSprites = [];
          for (var i = 204; i < countSprites; i += 4)
            characterSprites.add(await Sprite.load(
                'sprites/characters/knights/seq_antlerKnight/G_Back0${i}.png'));
          final runningUp = SpriteAnimation.spriteList(
              characterSprites, stepTime: 0.10);

          /// Spawn the character
          final characterSpawnPosition = map.getBlock(
              Vector2(x, y) + topLeft + Vector2(0, 150));
          _character = Character(
            size: Vector2(200, 200),
            position: map.getBlockPosition(characterSpawnPosition),
          )
            ..animations = {
              CharacterState.idleRight: idleRight,
              CharacterState.hitRight: hitRight,
              CharacterState.runningRight: runningRight,
              CharacterState.idleDown: idleDown,
              CharacterState.hitDown: hitDown,
              CharacterState.runningDown: runningDown,
              CharacterState.idleLeft: idleLeft,
              CharacterState.hitLeft: hitLeft,
              CharacterState.runningLeft: runningLeft,
              CharacterState.idleUp: idleUp,
              CharacterState.hitUp: hitUp,
              CharacterState.runningUp: runningUp,
            }
            ..current = CharacterState.idleRight;
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
  void onKeyEvent(RawKeyEvent e) {
    final isKeyDown = e is RawKeyDownEvent;

    if (e.data.keyLabel == 'a') {
      _character.current = isKeyDown ? CharacterState.runningLeft : CharacterState.idleLeft;
      _character.velocity.x = isKeyDown ? -1 : 0;
    } else if (e.data.keyLabel == 'd') {
      _character.current = isKeyDown ? CharacterState.runningRight : CharacterState.idleRight;
      _character.velocity.x = isKeyDown ? 1 : 0;
    } else if (e.data.keyLabel == 'w') {
      _character.current = isKeyDown ? CharacterState.runningUp : CharacterState.idleUp;
      _character.velocity.y = isKeyDown ? -1 : 0;
    } else if (e.data.keyLabel == 's') {
      _character.current = isKeyDown ? CharacterState.runningDown : CharacterState.idleDown;
      _character.velocity.y = isKeyDown ? 1 : 0;
    } else if (e.data.keyLabel == '1') {
        _character.current = isKeyDown ? CharacterState.hitRight : CharacterState.idleRight;
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
