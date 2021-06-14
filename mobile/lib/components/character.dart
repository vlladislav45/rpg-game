import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/geometry.dart';
import 'package:flutter/material.dart';
import 'package:rpg_game/components/npc.dart';
import 'package:rpg_game/game.dart';
import 'package:flame/joystick.dart';
import 'package:rpg_game/utils/directional_helper.dart';

class Character extends SpriteAnimationGroupComponent<NpcState>
    with Hitbox, Collidable, HasGameRef<MyGame>
    implements JoystickListener {
  // character properties
  int hp = 100;

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
  void render(Canvas canvas) {
    super.render(canvas);
    debugMode = true;
  }

  Vector2 cartToIso(Vector2 p) {
    final x = p.x - p.y;
    final y = (p.x + p.y) / 2;
    return Vector2(x, y);
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

    position.add(cartToIso(displacement));
    _isCollision = false;
  }

  Vector2 get velocity => _velocity;

  void setNewDirection(Vector2 newDirection) {
    this._velocity = newDirection;
  }


  @override
  void onMount() {
    super.onMount();

    final shape = HitboxCircle(definition: 0.5);
    addShape(shape);
  }

  @override
  int get priority => 1;

  @override
  void onCollision(Set<Vector2> points, Collidable other) {
    if (other is Npc) {
      gameRef.camera.setRelativeOffset(Anchor.centerRight);
      timer.start();
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
    if (event.id == 1) {
      this.current = NpcState.hitTop;
    }
    // if (event.event == ActionEvent.down) {
    //   // if (event.id == 1) {
    //   //   paint = paint == _whitePaint ? _bluePaint : _whitePaint;
    //   // }
    //   // if (event.id == 2) {
    //   //   paint = paint == _whitePaint ? _greenPaint : _whitePaint;
    //   // }
    // } else if (event.event == ActionEvent.move) {
    //   if (event.id == 3) {
    //     angle = event.angle;
    //   }
    // }
  }

  @override
  void joystickChangeDirectional(JoystickDirectionalEvent event) {
    move = event.directional != JoystickMoveDirectional.idle;
    if (move) {
      if (event.directional == JoystickMoveDirectional.moveLeft) {
        this.current = NpcState.runLeft;
        this.velocity.x = -1;
        this._facing = 'west';
      } else if (event.directional == JoystickMoveDirectional.moveRight) {
        this.current = NpcState.runRight;
        this.velocity.x = 1;
        this._facing = 'east';
      } else if (event.directional == JoystickMoveDirectional.moveUp) {
        this.current = NpcState.runTop;
        this.velocity.y = -1;
        this._facing = 'north';
      } else if (event.directional == JoystickMoveDirectional.moveDown) {
        this.current = NpcState.runDown;
        this.velocity.y = 1;
        this._facing = 'south';
      } else if (event.directional == JoystickMoveDirectional.moveDownLeft) {
        this.current = NpcState.runBottomLeft;
        this.setNewDirection(Vector2(-1, 1));
        this._facing = 'south-west';
      } else if (event.directional == JoystickMoveDirectional.moveDownRight) {
        this.current = NpcState.runBottomRight;
        this.setNewDirection(Vector2(1, 1));
        this._facing = 'south-east';
      } else if (event.directional == JoystickMoveDirectional.moveUpLeft) {
        this.current = NpcState.runTopLeft;
        this.setNewDirection(Vector2(-1, -1));
        this._facing = 'north-west';
      } else if (event.directional == JoystickMoveDirectional.moveUpRight) {
        this.current = NpcState.runTopRight;
        this.setNewDirection(Vector2(1, -1));
        this._facing = 'north-east';
      }
    } else {
      this.current = DirectionalHelper.getDirectionalSpriteAnimation(_facing, StateAction.Idle);
      this.setNewDirection(Vector2(0, 0));
    }
  }
}
