
import 'dart:ui';
import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart' hide Image;
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:rpg_game/animation/character_sprite_animation.dart';
import 'package:rpg_game/animation/npc_sprite_animation.dart';
import 'package:rpg_game/component/npc.dart';
import 'package:rpg_game/component/portal.dart';
import 'package:rpg_game/map/map.dart';
import 'package:rpg_game/component/character.dart';
import 'package:rpg_game/map/town.dart';
import 'package:rpg_game/util/directional_helper.dart';

import 'model/character_model.dart';
import 'util/hex_color.dart';

class MyGame extends BaseGame with HasCollidables, HasTappableComponents,
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
  late JoystickComponent _joystick;
  late final CharacterModel _characterModel;
  late Npc _npc;
  late List<Npc> _npcs = [];
  bool _isAllNpcsAreDeath = false;
  Portal? _portal;
  late final BuildContext _context;

  // Useful properties
  bool _isCharacterSpawned = false;

  // Screen Resolution
  Vector2 viewportResolution;

  MyGame({
    CharacterModel? characterModel,
    BuildContext? context,
    String? jsonMap,
    int? mapLevel,
    int? arena,
    required this.viewportResolution,
  }) {
    this.mapLevel = mapLevel;
    this.jsonMap = jsonMap;
    this.arena = arena;
    this._characterModel = characterModel!;
    this._context = context!;
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
    )..position = Vector2(0,0));
    map.renderTrees();

    spawnCharacter();
    spawnNpcs();
  }

  // Future<void> loadArena() async {
  //   viewport = FixedResolutionViewport(viewportResolution);
  //   print('ViewPort: ${viewport.canvasSize}');
  //
  //   final tilesetImage = await images.load('sprites/tile_maps/tileset.png');
  //   final tileset = SpriteSheet(image: tilesetImage, srcSize: Vector2(151, 76));
  //   final matrix = Map.toList(this.jsonMap.toString());
  //
  //   // Add main town
  //   add(map = Map(
  //     tileset,
  //     matrix,
  //     tileHeight: 25.0,
  //   )..position = Vector2(0,0)
  //   ..isHud = true);
  //
  //   spawnCharacter();
  // }

  void spawnNpcs() async {
    /// Load npc Sprite Direction Animations
    final npcSpriteAnimation = NpcSpriteAnimation();
    await npcSpriteAnimation.loadSpriteAnimations();

    print('SIZE OF THE MAP ${map.mapSize()}');
    for (int i = 0; i < 5; i++) {
      final npcSpawnPosition = map.getBlock(map.genCoord());
      final spawnPosition = map.getBlockPosition(npcSpawnPosition);

      // bool isAggressive = false;
      // // Odd number
      // var rand = Random().nextInt(100);
      // if(rand % 2 == 1)
      //   isAggressive = true;

      print('Npc is spawned on: $spawnPosition');
      Npc npc;
      add(npc = Npc(
        map,
        true,
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
        size: Vector2(84, 67),
        position: spawnPosition,
      )..current = NpcState.idleDown);

    _npcs.add(npc);
    }
  }

  void spawnCharacter() async {
    /// Load Character Sprite Direction Animations
    final characterSpriteAnimation = CharacterSpriteAnimation();

    /// Spawn the character

    final characterSpawnPosition = map.getBlock(Vector2(300, 250));
    print(characterSpawnPosition);
    await characterSpriteAnimation.loadSpriteAnimations();

    _joystick = await getJoystick();

    _character = Character(
      _joystick,
      _context,
      _characterModel,
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
    )..current = NpcState.idleRight;
    _character.position.setFrom(map.getBlockPosition(characterSpawnPosition));

    final attack = await loadSprite('joystick_attack.png');
    final attackBtnDown = await loadSprite('joystick_attack_selected.png');
    final attackButton = HudButtonComponent(
      button: SpriteComponent(
        sprite: attack,
        size: Vector2.all(50.0),
      ),
      buttonDown: SpriteComponent(
        sprite: attackBtnDown,
        size: Vector2.all(50.0),
      ),
      margin: const EdgeInsets.only(
        right: 40,
        bottom: 40,
      ),
      onPressed: () => {
        _character.attack(),
      }
    );

    add(_character);
    add(_joystick);
    add(attackButton);
    camera.followComponent(_character, relativeOffset: Anchor.center);

    if (!overlays.isActive(_character.overlay))
      overlays.add(_character.overlay);

    _isCharacterSpawned = true;
  }

  Future<JoystickComponent> getJoystick() async {
    final knob = await loadSprite('joystick_knob.png');
    final background = await loadSprite('joystick_background.png');
    return JoystickComponent(
      knob: SpriteComponent(
        sprite: knob,
        size: Vector2.all(50.0),
      ),
      background: SpriteComponent(
        sprite: background,
        size: Vector2.all(80.0),
      ),
      margin: const EdgeInsets.only(left: 40, bottom: 40),
    );
  }

  void spawnTown() async {
    //Spawn town
    final townSprite = await Sprite.load('bg/Background_3_3840x2160.jpg');
    _town = Town(size: size, position: Vector2.zero())
      ..sprite = townSprite
      ..isHud = true;
    add(_town!);
    _town!.spawnTown();

    camera.snapTo(Vector2.zero());
  }

  @override
  Future<void> onLoad() async {
    print('Map Level: $mapLevel');
    mapLevel == 0 ? spawnTown() : await loadMapLevel();
    // arena == 0 ? spawnTown() : await loadArena();
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
  }

  // @override
  // void onKeyEvent(RawKeyEvent e) async {
  //   final isKeyDown = e is RawKeyDownEvent;
  //
  //   // print(_facing);
  //   // print(_character.isPlayerPressAttack);
  //   if(e.data.keyLabel == '1') {
  //     _character.current = DirectionalHelper.getDirectionalSpriteAnimation(
  //         _facing!, StateAction.Attack);
  //     _character.setIsPlayerPressAttack(true);
  //     _character.timer.start();
  //   }
  //
  //   // print(_character.velocity);
  //   if (e.data.keyLabel == 'w') {
  //     _character.current = NpcState.runTopRight;
  //     _character.velocity.y = isKeyDown ? -1 : 0;
  //     _facing = 'north-east';
  //   } else if (e.data.keyLabel == 's') {
  //     _character.velocity.y = isKeyDown ? 1 : 0;
  //     _character.current = NpcState.runBottomLeft;
  //     _facing = 'south-west';
  //   }
  //   if (e.data.keyLabel == 'a') {
  //     _character.velocity.x = isKeyDown ? -1 : 0;
  //     if (_character.velocity.y == 0) {
  //       _character.current = NpcState.runTopLeft;
  //       _facing = 'north-west';
  //     } else if (_character.velocity.y == 1) {
  //       // if (-1,1)
  //       if (isKeyDown) _character.setVelocity(Vector2(-1, 1));
  //       _character.current = NpcState.runLeft;
  //       _facing = 'west';
  //     } else {
  //       if (isKeyDown) _character.setVelocity(Vector2(-1, -1));
  //       _character.current = NpcState.runTop;
  //       _facing = 'north';
  //     }
  //   } else if (e.data.keyLabel == 'd') {
  //     _character.velocity.x = isKeyDown ? 1 : 0;
  //     if (_character.velocity.y == 0) {
  //       _character.current = NpcState.runBottomRight;
  //       _facing = 'south-east';
  //     } else if (_character.velocity.y == 1) {
  //       if (isKeyDown) _character.setVelocity(Vector2(1, 1));
  //       _character.current = NpcState.runDown;
  //       _facing = 'south';
  //     } else {
  //       if (isKeyDown) _character.setVelocity(Vector2(1, -1));
  //       _character.current = NpcState.runRight;
  //       _facing = 'east';
  //     }
  //   }
  //
  //   if (_character.velocity.y == 0 && _character.velocity.x == 0 && e.data.keyLabel != '1') {
  //     // print(_facing);
  //     _character.current = DirectionalHelper.getDirectionalSpriteAnimation(
  //         _facing!, StateAction.Idle);
  //   }
  // }

  @override
  void update(double dt) async {
    super.update(dt);

    List<Npc> matches = _npcs.where((n) => n.isNpcDeath == true).toList();
    if(matches.length == _npcs.length && _npcs.length > 0) {
      _isAllNpcsAreDeath = true;
    }
    if(_isAllNpcsAreDeath) {
      map.removeChildComponents();
      components.remove(map);
      components.remove(_joystick);

      // this._characterModel.level += 1;
      // SocketManager.socket.emit('update', this._characterModel);

      spawnTown();
      _isAllNpcsAreDeath = false;
    }
    if(_isCharacterSpawned) {
      if(_character.isDead) {
        // Remove map and his restrictions
        map.removeChildComponents();
        components.remove(map);
        components.remove(_joystick);

        // and then spawn the town
        spawnTown();

        _character.setIsDead = false;
      }
    }
  }
}
