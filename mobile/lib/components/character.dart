import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/geometry.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';
import 'package:rpg_game/components/npc.dart';
import 'package:rpg_game/components/water.dart';
import 'package:rpg_game/game.dart';
import 'package:flame/joystick.dart';
import 'package:rpg_game/utils/convert_coordinates.dart';
import 'package:rpg_game/utils/directional_helper.dart';

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
  bool _isWall = false;
  bool isDead = false;
  bool isPlayerPressAttack = false;
  int _health = 100;

  /// Where is facing of the character
  /// north, south, east, west, north-east, north-west, south-east, south-west
  late String _facing;

  late final TextComponent _nickname;

  Character(
      Map<NpcState, SpriteAnimation> animations, {
    Vector2? position,
    Vector2? size,
  }) : super(
          position: position,
          size: size,
          animations: animations,
        ) {

    timer = Timer(1.0)
      ..stop()
      ..callback = () {
        gameRef.camera.setRelativeOffset(Anchor.center);
      };
  }


  @override
  int get priority => 1;

  @override
  Future<void> onLoad() async {
    super.onLoad();

    //Player nickname
    gameRef.add(
      _nickname = _renderNickName(),
    );
  }

  TextComponent _renderNickName() {
    return TextComponent(
      'my',
      position: Vector2(this.position.x + this.size.x / 2, this.position.y),
      textRenderer: TextPaint(
          config: TextPaintConfig(
            color: BasicPalette.black.color,
            fontSize: 14.0,
          ),
      ),
    )
    ..anchor = Anchor.topCenter;
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    _nickname.position = Vector2(this.position.x + this.size.x / 2, this.position.y);

    debugMode = true;
  }

  @override
  void update(double dt) {
    super.update(dt);
    timer.update(dt);

    if(_health <= 0) {
      gameRef.camera.setRelativeOffset(Anchor.center);
      timer.start();
      this.die();
    }

    debugColor = _isCollision ? _collisionColor : _defaultColor;

    // Increment the current position of player by speed * delta time along moveDirection.
    // Delta time is the time elapsed since last update. For devices with higher frame rates,
    // delta time will be smaller and for devices with lower frame rates, it will be larger. Multiplying speed with
    // delta time ensure that player speed remains same irrespective of the device FPS.
    if(_isWall && velocity.y == -1) {
      final displacement = (_velocity.y * -1) + 10;
      position.add(ConvertCoordinates.cartToIso(Vector2(0, displacement)));
    }else if(_isWall && velocity.y == 1) {
      final displacement = (_velocity.y * -1) - 10;
      position.add(ConvertCoordinates.cartToIso(Vector2(0, displacement)));
    } else if(_isWall && velocity.x == 1) {
      final displacement = (_velocity.x * -1) - 10;
      position.add(ConvertCoordinates.cartToIso(Vector2(displacement, 0)));
    }else if(_isWall && velocity.x == -1) {
      final displacement = (_velocity.x * -1) + 10;
      position.add(ConvertCoordinates.cartToIso(Vector2(displacement, 0)));
    }
    else {
      _isWall = false;
      final displacement = _velocity * (speed * dt);

      position.add(ConvertCoordinates.cartToIso(displacement));
    }

    _isWall = false;
    _isCollision = false;
  }

  Vector2 get velocity => _velocity;

  void setVelocity(Vector2 newVelocity) {
    this._velocity = newVelocity;
  }

  @override
  void onMount() {
    super.onMount();

    final shape = HitboxCircle(definition: 0.6);
    addShape(shape);
  }

  @override
  void onCollision(Set<Vector2> points, Collidable other) async {
    if (other is Npc) {
      if(other.isPlayerPressAttack) {
        _isCollision = true;
        isPlayerPressAttack = false;

        _health -= 7;
      }
    } else if(other is Water) {
      _isWall = true;
    } else {
      _isCollision = false;
      _isWall = false;
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

    if (event.id == 0 && event.event == ActionEvent.down) {
      // print('Character is hitting');

      this.current = DirectionalHelper.getDirectionalSpriteAnimation(
          _facing, StateAction.Attack);
    } else {
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

  void die() async {
    // int lengthOfSprites = 1296; // Death sprites started from 1256-1296
    // List<Sprite> sprites = [];
    // for (int i = 1256; i <= lengthOfSprites; i += 4)
    //   sprites.add(await Sprite.load(
    //   'sprites/characters/knights/seq_antlerKnight/A_right${i}.png'));
    // final die = SpriteAnimation.spriteList(sprites, stepTime: 0.20);
    isDead = true;

    if(isDead) {
      Sprite sprite = await Sprite.load('crypt.png');
      gameRef.add(
          SpriteComponent(
            sprite: sprite,
            position: this.position,
            size: Vector2(50, 50),
          )
      );
      gameRef.remove(this);
      // gameRef.remove(_nickname);
    }
  }
}
