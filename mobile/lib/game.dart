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
import 'package:rpg_game/components/character_directionals.dart';
import 'package:rpg_game/components/npc.dart';
import 'package:rpg_game/components/npc_directionals.dart';
import 'package:rpg_game/components/portal.dart';
import 'package:rpg_game/maps/maps/map.dart';
import 'package:rpg_game/components/character.dart';
import 'package:rpg_game/components/selector.dart';
import 'package:rpg_game/maps/town.dart';

const x = 750.0;
const y = 150.0;
final topLeft = Vector2(x, y);

class MyGame extends BaseGame
    with
        MouseMovementDetector,
        KeyboardEvents,
        HasCollidables,
        HasTapableComponents,
        HasDraggableComponents {
  //Properties
  Vector2? screenMousePosition;
  String? jsonMap;
  int? mapLevel;

  //Town
  Town? _town;

  // Components
  Map? map;
  late Character _character;
  late Npc _npc;
  Vector2 viewportResolution;
  Selector? _selector;
  Portal? _portal;

  MyGame({String? jsonMap,
      int? mapLevel,
      required this.viewportResolution,
    }) {
    this.mapLevel = mapLevel;
    this.jsonMap = jsonMap;
  }

  @override
  Color backgroundColor() {
    return Colors.transparent;
  }

  void loadMapLevel() async {
    viewport = FixedResolutionViewport(viewportResolution);
    print('ViewPort: ${viewport.canvasSize}');

    final tilesetImage = await images.load('sprites/tile_maps/grass_default.png');
    final tileset = SpriteSheet(image: tilesetImage, srcSize: Vector2(151, 71));
    final matrix = Map.toList(this.jsonMap.toString());

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
    //spawnNpcs();
  }

  void spawnNpcs() async {
    /// Load npc Sprite Direction Animations
    final npcDirectionals = NpcDirectionals();

    _npc = Npc(
      {
        await npcDirectionals.loadDirectionals(),
      },
      size: Vector2(79, 63),
      position: map!.getBlockPosition(map!.getBlock(Vector2(x, y) + topLeft + Vector2(0, 150))),
    )
      ..current = NpcState.idleDown;

    add(_npc);
  }

  void spawnCharacter() async {
    /// Load Character Sprite Direction Animations
    final characterDirectionals = CharacterDirectionals();
    /// Spawn the character
    final characterSpawnPosition = map!.getBlock(Vector2(x, y) + topLeft + Vector2(0, 150));
    var a = await characterDirectionals.loadDirectionals();
    _character = Character({a},
      size: Vector2(200, 200),
      position: map!.getBlockPosition(characterSpawnPosition),
    )
    ..animations = a;

    if (Platform.isAndroid || Platform.isIOS) {
      final joystick = await getJoystick();
      joystick.addObserver(_character);
      add(joystick);
    }

    add(_character);
    if (!overlays.isActive('CharacterOverlay')) overlays.add('CharacterOverlay');

    camera.cameraSpeed = 1;
    camera.followComponent(_character);
  }

  Future<JoystickComponent> getJoystick() async {
    final joystick = JoystickComponent(
      gameRef: this,
      directional: JoystickDirectional(
        background: JoystickElement.sprite(await loadJoystick(0)),
        knob: JoystickElement.sprite(await loadJoystick(1)),
      ),
      actions: [
        JoystickAction(
          actionId: 1,
          margin: const EdgeInsets.all(50),
          action: JoystickElement.sprite(await loadJoystick(2)),
          actionPressed: JoystickElement.sprite(await loadJoystick(4)),
        ),
        JoystickAction(
          actionId: 2,
          action: JoystickElement.sprite(await loadJoystick(3)),
          actionPressed: JoystickElement.sprite(await loadJoystick(5)),
          margin: const EdgeInsets.only(
            right: 50,
            bottom: 120,
          ),
        ),
        JoystickAction(
          actionId: 3,
          margin: const EdgeInsets.only(bottom: 50, right: 120),
          enableDirection: true,
          color: const Color(0xFFFF00FF),
          opacityBackground: 0.1,
          opacityKnob: 0.9,
        ),
      ],
    );
    return joystick;
  }

  Future<Sprite> loadJoystick(int idx) async {
    return loadSprite(
      'joystick.png',
      srcPosition: Vector2(idx * 16.0, 0),
      srcSize: Vector2.all(16),
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
    mapLevel == 0 ? spawnTown() : loadMapLevel();

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
      _character.current =
          isKeyDown ? CharacterState.runningLeft : CharacterState.idleLeft;
      _character.velocity.x = isKeyDown ? -1 : 0;
    } else if (e.data.keyLabel == 'd') {
      _character.current =
          isKeyDown ? CharacterState.runningRight : CharacterState.idleRight;
      _character.velocity.x = isKeyDown ? 1 : 0;
    } else if (e.data.keyLabel == 'w') {
      _character.current =
          isKeyDown ? CharacterState.runningUp : CharacterState.idleUp;
      _character.velocity.y = isKeyDown ? -1 : 0;
    } else if (e.data.keyLabel == 's') {
      _character.current =
          isKeyDown ? CharacterState.runningDown : CharacterState.idleDown;
      _character.velocity.y = isKeyDown ? 1 : 0;
    } else if (e.data.keyLabel == '1') {
      _character.current = CharacterState.hitRight;
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
}
