import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/geometry.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';
import 'package:rpg_game/components/npc.dart';
import 'package:rpg_game/game.dart';
import 'package:flame/joystick.dart';
import 'package:rpg_game/utils/convert_coordinates.dart';
import 'package:rpg_game/utils/directional_helper.dart';

final _regularTextConfig = TextPaintConfig(color: BasicPalette.white.color);
final _regular = TextPaint(config: _regularTextConfig);

class Character extends SpriteAnimationGroupComponent<NpcState>
    with Hitbox, Collidable, HasGameRef<MyGame>
    implements JoystickListener {
  // Directionals and speed
  static const speed = 100;
  late Vector2 _velocity = Vector2.zero();

  // Joystick
  bool move = false;

  // Camera
  late Rect rect;
  late Timer timer;

  // Collisions
  final _collisionColor = Colors.amber;
  final _defaultColor = Colors.cyan;
  bool _isCollision = false;

  // Where is facing of the character
  // north, south, east, west, north-east, north-west, south-east, south-west
  late String _facing;

  Character(Map<NpcState, SpriteAnimation> animations, {
    Vector2? position,
    Vector2? size,
  }) : super(
          position: position,
          size: size,
          animations: animations,
        ) {
    timer = Timer(3.0)
      ..stop()
      ..callback = () {
        gameRef.camera.setRelativeOffset(Anchor.center);
      };
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();

    // gameRef.add(
    //     _renderNickName(),
    // );
    //
    // await gameRef.add(
    //     TextComponent(
    //       'my',
    //       textRenderer: _regular,
    //     )
    //       ..anchor = Anchor.topCenter
    //       ..x = 200
    //       ..y = 200,
    // );
  }

  TextComponent _renderNickName() {
    return TextComponent(
      'my',
      textRenderer: _regular,
    )
    ..anchor = Anchor.topCenter
    ..x = position.x + ((width - (position.length * (width / 13))) / 2)
    ..y = position.y - 20;
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    debugMode = true;
  }

  @override
  void update(double dt) {
    super.update(dt);
    timer.update(dt);

    debugColor = _isCollision ? _collisionColor : _defaultColor;

    // Increment the current position of player by speed * delta time along moveDirection.
    // Delta time is the time elapsed since last update. For devices with higher frame rates,
    // delta time will be smaller and for devices with lower frame rates, it will be larger. Multiplying speed with
    // delta time ensure that player speed remains same irrespective of the device FPS.
    final displacement = _velocity * (speed * dt);

    position.add(ConvertCoordinates.cartToIso(displacement));
    _isCollision = false;
  }

  Vector2 get velocity => _velocity;

  void setVelocity(Vector2 newVelocity) {
    this._velocity = newVelocity;
  }


  @override
  void onMount() {
    super.onMount();

    final shape = HitboxCircle(definition: 0.5);
    addShape(shape);
  }

  @override
  void onCollision(Set<Vector2> points, Collidable other) {
    if (other is Npc) {
      // gameRef.camera.setRelativeOffset(Anchor.center);
      // timer.start();
      _isCollision = true;
      print('My character is hitted');
    }
  }

  @override
  void onGameResize(Vector2 gameSize) {
    // final offset = (gameSize - size) / 2;
    // this.size = offset;

    super.onGameResize(gameSize);
  }

  @override
  void joystickAction(JoystickActionEvent event) {
    if(event.event == ActionEvent.down) {
      if (event.id == 1) {
        this.current = DirectionalHelper.getDirectionalSpriteAnimation(
            _facing, StateAction.Attack);
      }
    }else {
      this.current = DirectionalHelper.getDirectionalSpriteAnimation(_facing, StateAction.Idle);
    }
  }

  /// *
  /// Because our game is isometric and we put character coordinates to iso
  /// we have to change the facing of the character
  /// For example if we need top we have  to set topRight for correct position
  @override
  void joystickChangeDirectional(JoystickDirectionalEvent event) {
    move = event.directional != JoystickMoveDirectional.idle;
    print('${this.velocity} : ${event.directional}');
    if (move) {
      if (event.directional == JoystickMoveDirectional.moveLeft) {
        this.current = NpcState.runTopLeft;
        this.setVelocity(Vector2(-1,0));
        this._facing = 'north-west';
      } else if (event.directional == JoystickMoveDirectional.moveRight) {
        this.current = NpcState.runBottomRight;
        this.setVelocity(Vector2(1,0));
        this._facing = 'south-east';
      } else if (event.directional == JoystickMoveDirectional.moveUp) {
        this.current = NpcState.runTopRight;
        this.setVelocity(Vector2(0,-1));
        this._facing = 'north-east';
      } else if (event.directional == JoystickMoveDirectional.moveDown) {
        this.current = NpcState.runBottomLeft;
        this.setVelocity(Vector2(0,1));
        this._facing = 'south-west';
      } else if (event.directional == JoystickMoveDirectional.moveDownLeft) {
        this.current = NpcState.runLeft;
        this.setVelocity(Vector2(-1,1));
        this._facing = 'west';
      } else if (event.directional == JoystickMoveDirectional.moveDownRight) {
        this.current = NpcState.runDown;
        this.setVelocity(Vector2(1,1));
        this._facing = 'south';
      } else if (event.directional == JoystickMoveDirectional.moveUpLeft) {
        this.current = NpcState.runTop;
        this.setVelocity(Vector2(-1,-1));
        this._facing = 'north';
      } else if (event.directional == JoystickMoveDirectional.moveUpRight) {
        this.current = NpcState.runRight;
        this.setVelocity(Vector2(1,-1));
        this._facing = 'east';
      }
    } else {
      this.current = DirectionalHelper.getDirectionalSpriteAnimation(_facing, StateAction.Idle);
      this.setVelocity(Vector2(0,0));
    }
  }
}
