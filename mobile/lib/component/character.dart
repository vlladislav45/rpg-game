import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/geometry.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';
import 'package:rpg_game/component/npc.dart';
import 'package:rpg_game/component/water.dart';
import 'package:rpg_game/game.dart';
import 'package:rpg_game/model/character_model.dart';
import 'package:rpg_game/util/convert_coordinates.dart';
import 'package:rpg_game/util/directional_helper.dart';

class Character extends SpriteAnimationGroupComponent<NpcState>
    with Hitbox, Collidable, HasGameRef<MyGame> {
  // Directionals and speed
  static const maxSpeed = 300;
  late Vector2 _velocity = Vector2.zero();

  // Joystick
  bool move = false;

  // Camera
  late Timer timer;

  // Collisions
  final _collisionColor = Colors.amber;
  final _defaultColor = Colors.cyan;
  bool _isCollision = false;
  bool _isWall = false;
  bool _isDead = false;
  bool _isPlayerPressAttack = false;

  // Character Properties
  late int currentHp;

  //Character model
  late final CharacterModel _characterModel;
  late final BuildContext context;

  /// Where is facing of the character
  /// north, south, east, west, north-east, north-west, south-east, south-west
  String _facing = 'north-west';

  late final TextComponent _nickname;
  late String _overlay = 'CharacterOverlay';

  // There are eight images * 0.10
  static const double time = 8 * 0.10;

  // Joystick implementation
  final JoystickComponent joystick;

  Character(
      this.joystick,
      BuildContext context,
      CharacterModel characterModel,
      Map<NpcState, SpriteAnimation> animations, {
    Vector2? position,
    Vector2? size,
  }) : super(
          position: position,
          size: size,
          animations: animations,
        ) {
    this.context = context;
    this._characterModel = characterModel;

    this.joystick.anchor = Anchor.center;

    timer = Timer(time)
      ..stop()
      ..callback = () {
        _isPlayerPressAttack = false;
        this.current = DirectionalHelper.getDirectionalSpriteAnimation(
            _facing, StateAction.Idle);
      };
  }

  //Getter and setters
  bool get isDead => _isDead;

  set setIsDead(bool value) {
    _isDead = value;
  }

  bool get isPlayerPressAttack => _isPlayerPressAttack;

  void setIsPlayerPressAttack(bool value) {
    _isPlayerPressAttack = value;
  }

  String get facing => _facing;

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
      '${_characterModel.nickname}',
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

    /// Without this camera isn't working
    /// You are following a position component, but you are not setting the position of that component
    /// Until now
    /// So the changes are basically to use the position field of your position component and set it to the
    /// center of the rect and in render you don't call super since that will prepare the canvas
    if(_characterModel.hp <= 0) {
      timer.start();
      this.die();
    }

    debugColor = _isCollision ? _collisionColor : _defaultColor;

    // Increment the current position of player by speed * delta time along moveDirection.
    // Delta time is the time elapsed since last update. For devices with higher frame rates,
    // delta time will be smaller and for devices with lower frame rates, it will be larger. Multiplying speed with
    // delta time ensure that player speed remains same irrespective of the device FPS.
    updateCurrentAnimation();
    if (!_isWall && !joystick.delta.isZero()) {
      position.add(joystick.relativeDelta * maxSpeed.toDouble() * dt);
    }
    // if(!_isWall) {
    //    position.add(ConvertCoordinates.cartToIso(_velocity * speed.toDouble() * dt));
    // }

    _isCollision = false;
    _isWall = false;
  }

  Vector2 get velocity => _velocity;

  void setVelocity(Vector2 newVelocity) {
    this._velocity = newVelocity;
  }

  String get overlay => _overlay;

  void updateCurrentAnimation() {
    move = joystick.direction != JoystickDirection.idle;
    if(!_isPlayerPressAttack) {
      if (move) {
        if (joystick.direction == JoystickDirection.left) {
          this.current = NpcState.runTopLeft;
          this.setVelocity(Vector2(-1,0));
          this._facing = 'north-west';
        } else if (joystick.direction == JoystickDirection.right) {
          this.current = NpcState.runBottomRight;
          this.setVelocity(Vector2(1,0));
          this._facing = 'south-east';
        } else if (joystick.direction == JoystickDirection.up) {
          this.current = NpcState.runTopRight;
          this.setVelocity(Vector2(0,-1));
          this._facing = 'north-east';
        } else if (joystick.direction == JoystickDirection.down) {
          this.current = NpcState.runBottomLeft;
          this.setVelocity(Vector2(0,1));
          this._facing = 'south-west';
        } else if (joystick.direction == JoystickDirection.downLeft) {
          this.current = NpcState.runLeft;
          this.setVelocity(Vector2(-1,1));
          this._facing = 'west';
        } else if (joystick.direction == JoystickDirection.downRight) {
          this.current = NpcState.runDown;
          this.setVelocity(Vector2(1,1));
          this._facing = 'south';
        } else if (joystick.direction == JoystickDirection.upLeft) {
          this.current = NpcState.runTop;
          this.setVelocity(Vector2(-1,-1));
          this._facing = 'north';
        } else if (joystick.direction == JoystickDirection.upRight) {
          this.current = NpcState.runRight;
          this.setVelocity(Vector2(1,-1));
          this._facing = 'east';
        }
      } else {
        this.current = DirectionalHelper.getDirectionalSpriteAnimation(_facing, StateAction.Idle);
        this.setVelocity(Vector2(0,0));
      }
      timer.start();
    }
  }

  void attack() {
    _isPlayerPressAttack = true;
    current = DirectionalHelper.getDirectionalSpriteAnimation(_facing, StateAction.Attack);
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
        other.isPlayerPressAttack = false;

        _characterModel.hp -= 7;
      }
    } else if(other is Water) {
      other.setWallHit(true);
      if(other.isWallHit) {
        if(velocity.y == -1) {
          // final displacement = (_velocity.y * -1) + 10;
          position.setFrom(ConvertCoordinates.cartToIso(Vector2(0, 125)));
        }else if(velocity.y == 1) {
          // final displacement = (_velocity.y * -1) - 10;
          position.setFrom(ConvertCoordinates.cartToIso(Vector2(0, 125)));
        } else if(velocity.x == 1) {
          // final displacement = (_velocity.x * -1) - 10;
          position.setFrom(ConvertCoordinates.cartToIso(Vector2(0, 125)));
        }else if(velocity.x == -1) {
          // final displacement = (_velocity.x * -1) + 10;
          position.setFrom(ConvertCoordinates.cartToIso(Vector2(0, 125)));
        }
      }
      other.setWallHit(false);
      _isWall = other.isWallHit;
    }
  }

  void die() async {
    this._isDead = true;

    Sprite sprite = await Sprite.load('crypt.png');
    gameRef.add(
        SpriteComponent(
          sprite: sprite,
          position: this.position,
          size: Vector2(50, 50),
        )
    );
    gameRef.components.remove(_nickname);
    gameRef.overlays.remove(_overlay);
    gameRef.components.remove(this);
  }
}
