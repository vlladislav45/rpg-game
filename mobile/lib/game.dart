import 'dart:io';
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
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rpg_game/animations/character_sprite_animation.dart';
import 'package:rpg_game/animations/npc_sprite_animation.dart';
import 'package:rpg_game/components/npc.dart';
import 'package:rpg_game/components/portal.dart';
import 'package:rpg_game/maps/maps/map.dart';
import 'package:rpg_game/components/character.dart';
import 'package:rpg_game/components/selector.dart';
import 'package:rpg_game/maps/town.dart';
import 'package:rpg_game/utils/directional_helper.dart';

import 'logic/cubits/arena/arena_cubit.dart';
import 'utils/convert_coordinates.dart';
import 'utils/hex_color.dart';

const x = 500.0;
const y = 150.0;
final topLeft = Vector2(x, y);

class MyGame extends BaseGame with KeyboardEvents, HasCollidables, HasTapableComponents,
        HasDraggableComponents {
  //Properties
  Vector2? screenMousePosition;
  String? jsonMap;
  int? mapLevel;
  int? arena;

  // Facing of the character, it is use in keyboard movement
  String? _facing;

  // Components
  late Map map;
  Town? _town;
  late Character _character;
  late Npc _npc;
  Selector? _selector;
  Portal? _portal;

  // Useful properties
  bool _isCharacterSpawned = false;

  // Screen Resolution
  Vector2 viewportResolution;

  MyGame({
    String? jsonMap,
    int? mapLevel,
    int? arena,
    required this.viewportResolution,
  }) {
    this.mapLevel = mapLevel;
    this.jsonMap = jsonMap;
    this.arena = arena;
  }

  @override
  Color backgroundColor() {
    return Color(HexColor.convertHexColor('#37B4Ba')).withOpacity(0.80);
  }

  Future<void> loadMapLevel() async {
    viewport = FixedResolutionViewport(viewportResolution);
    print('ViewPort: ${viewport.canvasSize}');

    final tilesetImage = await images.load('sprites/tile_maps/tileset.png');
    final tileset = SpriteSheet(image: tilesetImage, srcSize: Vector2(151, 76));
    final matrix = Map.toList(this.jsonMap.toString());

    // Add main town
    add(map = Map(
      tileset,
      matrix,
      tileHeight: 25.0,
    )..position = topLeft);

    spawnCharacter();
    spawnNpcs();
  }

  void spawnNpcs() async {
    /// Load npc Sprite Direction Animations
    final npcSpriteAnimation = NpcSpriteAnimation();
    await npcSpriteAnimation.loadSpriteAnimations();

    for (int i = 0; i < 5; i++) {
      add(Npc(
        _character,
        {
          NpcState.idleRight: npcSpriteAnimation.idleRight,
          NpcState.hitRight: npcSpriteAnimation.hitRight,
          NpcState.runRight: npcSpriteAnimation.runRight,
          NpcState.idleDown: npcSpriteAnimation.idleDown,
          NpcState.hitDown: npcSpriteAnimation.hitDown,
          NpcState.runDown: npcSpriteAnimation.runDown,
          NpcState.idleLeft: npcSpriteAnimation.idleLeft,
          NpcState.hitLeft: npcSpriteAnimation.hitLeft,
          NpcState.runLeft: npcSpriteAnimation.runLeft,
          NpcState.idleTop: npcSpriteAnimation.idleTop,
          NpcState.hitTop: npcSpriteAnimation.hitTop,
          NpcState.runTop: npcSpriteAnimation.runTop,
          NpcState.idleBottomRight: npcSpriteAnimation.idleBottomRight,
          NpcState.hitBottomRight: npcSpriteAnimation.hitBottomRight,
          NpcState.runBottomRight: npcSpriteAnimation.runBottomRight,
          NpcState.idleBottomLeft: npcSpriteAnimation.idleBottomLeft,
          NpcState.hitBottomLeft: npcSpriteAnimation.hitBottomLeft,
          NpcState.runBottomLeft: npcSpriteAnimation.runBottomLeft,
          NpcState.idleTopLeft: npcSpriteAnimation.idleTopLeft,
          NpcState.hitTopLeft: npcSpriteAnimation.hitTopLeft,
          NpcState.runTopLeft: npcSpriteAnimation.runTopLeft,
          NpcState.idleTopRight: npcSpriteAnimation.idleTopRight,
          NpcState.hitTopRight: npcSpriteAnimation.hitTopRight,
          NpcState.runTopRight: npcSpriteAnimation.runTopRight,
        },
        size: Vector2(79, 63),
        position: map.getBlockPosition(map.getBlock(Vector2(
                Npc.generateRandomCoordinates(),
                Npc.generateRandomCoordinates()) +
            topLeft)),
      )..current = NpcState.idleDown);
    }
  }

  void spawnCharacter() async {
    /// Load Character Sprite Direction Animations
    final characterSpriteAnimation = CharacterSpriteAnimation();

    /// Spawn the character

    final characterSpawnPosition =
        map.getBlock(Vector2(x, y) + topLeft + Vector2(0, 150));
    await characterSpriteAnimation.loadSpriteAnimations();
    _character = Character(
      {
        NpcState.idleRight: characterSpriteAnimation.idleRight,
        NpcState.hitRight: characterSpriteAnimation.hitRight,
        NpcState.runRight: characterSpriteAnimation.runRight,
        NpcState.idleDown: characterSpriteAnimation.idleDown,
        NpcState.hitDown: characterSpriteAnimation.hitDown,
        NpcState.runDown: characterSpriteAnimation.runDown,
        NpcState.idleLeft: characterSpriteAnimation.idleLeft,
        NpcState.hitLeft: characterSpriteAnimation.hitLeft,
        NpcState.runLeft: characterSpriteAnimation.runLeft,
        NpcState.idleTop: characterSpriteAnimation.idleTop,
        NpcState.hitTop: characterSpriteAnimation.hitTop,
        NpcState.runTop: characterSpriteAnimation.runTop,
        NpcState.idleBottomRight: characterSpriteAnimation.idleBottomRight,
        NpcState.hitBottomRight: characterSpriteAnimation.hitBottomRight,
        NpcState.runBottomRight: characterSpriteAnimation.runBottomRight,
        NpcState.idleBottomLeft: characterSpriteAnimation.idleBottomLeft,
        NpcState.hitBottomLeft: characterSpriteAnimation.hitBottomLeft,
        NpcState.runBottomLeft: characterSpriteAnimation.runBottomLeft,
        NpcState.idleTopLeft: characterSpriteAnimation.idleTopLeft,
        NpcState.hitTopLeft: characterSpriteAnimation.hitTopLeft,
        NpcState.runTopLeft: characterSpriteAnimation.runTopLeft,
        NpcState.idleTopRight: characterSpriteAnimation.idleTopRight,
        NpcState.hitTopRight: characterSpriteAnimation.hitTopRight,
        NpcState.runTopRight: characterSpriteAnimation.runTopRight,
      },
      size: Vector2(200, 200),
      position: map.getBlockPosition(characterSpawnPosition),
    )..current = NpcState.idleRight;

    final joystick = await getJoystick();
    joystick.addObserver(_character);

    add(_character);
    // camera.cameraSpeed = 1;
    // camera.followComponent(_character);

    add(joystick);
    if (!overlays.isActive('CharacterOverlay'))
      overlays.add('CharacterOverlay');

    _isCharacterSpawned = true;
  }

  Future<JoystickComponent> getJoystick() async {
    final joystick = JoystickComponent(
      gameRef: this,
      directional: JoystickDirectional(
        background: JoystickElement.sprite(await loadJoystick('joystick_background.png')),
        knob: JoystickElement.sprite(await loadJoystick('joystick_knob.png')),
      ),
      actions: [
        JoystickAction(
          actionId: 0,
          margin: const EdgeInsets.only(right: 75.0, bottom: 50.0),
          action: JoystickElement.sprite(await loadJoystick('joystick_attack.png')),
          actionPressed: JoystickElement.sprite(await loadJoystick('joystick_attack_selected.png')),
        ),
      ],
    );
    return joystick;
  }

  Future<Sprite> loadJoystick(String imageName) async {
    return loadSprite(
      imageName,
    );
  }

  void spawnTown() async {
    //Spawn town
    final townSprite = await Sprite.load('bg/Background_3_3840x2160.jpg');
    _town = Town(size: size, position: Vector2(0, 0))..sprite = townSprite;
    add(_town!);
    _town!.spawnTown();
  }

  @override
  Future<void> onLoad() async {
    print('Map Level: $mapLevel');
    mapLevel == 0 ? spawnTown() : await loadMapLevel();
    print('Arena: $arena');

    //Add walls around the town
    //map.setWalls();

    // final selectorImage = await images.load('tile_maps/selector.png');
    // add(_selector = Selector(s, selectorImage));
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
  }

  @override
  void onKeyEvent(RawKeyEvent e) {
    final isKeyDown = e is RawKeyDownEvent;

    // print(_character.velocity);
    if (e.data.keyLabel == 'w') {
      _character.current = NpcState.runTopRight;
      _character.velocity.y = isKeyDown ? -1 : 0;
      _facing = 'north-east';
    } else if (e.data.keyLabel == 's') {
      _character.velocity.y = isKeyDown ? 1 : 0;
      _character.current = NpcState.runBottomLeft;
      _facing = 'south-west';
    }
    if (e.data.keyLabel == 'a') {
      _character.velocity.x = isKeyDown ? -1 : 0;
      if (_character.velocity.y == 0) {
        _character.current = NpcState.runTopLeft;
        _facing = 'north-west';
      } else if (_character.velocity.y == 1) {
        // if (-1,1)
        if (isKeyDown) _character.setVelocity(Vector2(-1, 1));
        _character.current = NpcState.runLeft;
        _facing = 'west';
      } else {
        if (isKeyDown) _character.setVelocity(Vector2(-1, -1));
        _character.current = NpcState.runTop;
        _facing = 'north';
      }
    } else if (e.data.keyLabel == 'd') {
      _character.velocity.x = isKeyDown ? 1 : 0;
      if (_character.velocity.y == 0) {
        _character.current = NpcState.runBottomRight;
        _facing = 'south-east';
      } else if (_character.velocity.y == 1) {
        if (isKeyDown) _character.setVelocity(Vector2(1, 1));
        _character.current = NpcState.runDown;
        _facing = 'south';
      } else {
        if (isKeyDown) _character.setVelocity(Vector2(1, -1));
        _character.current = NpcState.runRight;
        _facing = 'east';
      }
    }

    if (_character.velocity.y == 0 && _character.velocity.x == 0) {
      print(_facing);
      _character.current = DirectionalHelper.getDirectionalSpriteAnimation(
          _facing!, StateAction.Idle);
    }
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (_isCharacterSpawned) {
      // if(map.containsBlock(map.getBlock(map.cartToIso(_character.position)))) {
      //   _character.update(dt);
      // }

      // Block block = map.getBlock(_character.position);
      // if(map.containsBlock(block)) print(map.position);

      // if (map.containsBlock(block)) {
      //   if (block.y <= 0)
      //     _character.velocity.y = 1;
      //   else if (block.y >= map.matrix.length)
      //     _character.velocity.y = -1;
      //   else if (block.x <= 0)
      //     _character.velocity.x = 1;
      //   else if (block.x >= map.matrix[block.y].length) _character.velocity.x = -1;
      // }
    }
  }
}
