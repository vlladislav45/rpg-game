import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/geometry.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rpg_game/components/npc.dart';
import 'package:rpg_game/components/water.dart';
import 'package:rpg_game/game.dart';
import 'package:flame/joystick.dart';
import 'package:rpg_game/logic/cubits/character_overlay/character_overlay_cubit.dart';
import 'package:rpg_game/models/character_model.dart';
import 'package:rpg_game/network/socket_manager.dart';
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
  late Timer timer;

  // Collisions
  final _collisionColor = Colors.amber;
  final _defaultColor = Colors.cyan;
  bool _isCollision = false;
  bool _isWall = false;
  bool _isDead = false;
  bool isPlayerPressAttack = false;

  //Character model
  late final CharacterModel _characterModel;
  late final BuildContext context;

  /// Where is facing of the character
  /// north, south, east, west, north-east, north-west, south-east, south-west
  late String _facing;

  late final TextComponent _nickname;
  late String _overlay = 'CharacterOverlay';

  Character(
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
    timer = Timer(1.0)
      ..stop()
      ..callback = () {
        gameRef.camera.setRelativeOffset(Anchor.center);
      };
  }

  //Getter and setters
  bool get isDead => _isDead;

  set setIsDead(bool value) {
    _isDead = value;
  }

  String get overlay => _overlay;

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
    if(!_isWall) {
      final displacement = _velocity * (speed * dt);

      position.add(ConvertCoordinates.cartToIso(displacement));
    }

    _isCollision = false;
    _isWall = false;
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

        _characterModel.hp -= 7;
        BlocProvider.of<CharacterOverlayCubit>(context).update(_characterModel.nickname, _characterModel.hp,
            _characterModel.mana, _characterModel.level, id: _characterModel.id);
        // var update = new CharacterModel(
        //     _characterModel.id,
        //     _characterModel.nickname,
        //     _characterModel.hp,
        //     _characterModel.level,
        //     _characterModel.mana,
        // );
        // SocketManager.socket.emit("update", update.toJson());
      }
    } else if(other is Water) {
      _isWall = false;
      if(velocity.y == -1) {
        // final displacement = (_velocity.y * -1) + 10;
        // position.setFrom(ConvertCoordinates.cartToIso(Vector2(x, y) + topLeft + Vector2(0, 125)));
        print(position);
        position.y = other.position.y + 1;
        print('New coordiantes: ${position}');
      }else if(velocity.y == 1) {
        // final displacement = (_velocity.y * -1) - 10;
        position.setFrom(ConvertCoordinates.cartToIso(Vector2(x, y) + topLeft + Vector2(0, 125)));
      } else if(velocity.x == 1) {
        // final displacement = (_velocity.x * -1) - 10;
        position.setFrom(ConvertCoordinates.cartToIso(Vector2(x, y) + topLeft + Vector2(0, 125)));
      }else if(velocity.x == -1) {
        // final displacement = (_velocity.x * -1) + 10;
        position.setFrom(ConvertCoordinates.cartToIso(Vector2(x, y) + topLeft + Vector2(0, 125)));
      }
    }
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
    this._isDead = true;

    Sprite sprite = await Sprite.load('crypt.png');
    gameRef.add(
        SpriteComponent(
          sprite: sprite,
          position: this.position,
          size: Vector2(50, 50),
        )
    );
    gameRef.remove(this);
  }
}
