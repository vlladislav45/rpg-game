import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/geometry.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';
import 'package:rpg_game/component/character.dart';
import 'package:rpg_game/component/npc.dart';
import 'package:rpg_game/component/tree.dart';
import 'package:rpg_game/component/water.dart';
import 'package:rpg_game/game.dart';
import 'package:rpg_game/model/character_model.dart';
import 'package:rpg_game/network/socket_manager.dart';
import 'package:rpg_game/util/collision_detect.dart';
import 'package:rpg_game/util/directional_helper.dart';

class RemotePlayer extends SpriteAnimationGroupComponent<NpcState>
    with Hitbox, Collidable, HasGameRef<MyGame> {
  // Directionals and speed
  static const maxSpeed = 180;
  late Vector2 _velocity = Vector2.zero();

  // Joystick
  bool move = false;

  // Camera
  late Timer timer;
  late Timer hideDeadMonumentTimer;

  // Collisions
  final _collisionColor = Colors.amber;
  final _defaultColor = Colors.cyan;
  bool _isCollision = false;

  // Character Properties
  late int hp = _characterModel.hp;
  late SpriteComponent _crypt;

  //Character model
  late CharacterModel _characterModel;
  late final BuildContext context;

  /// Where is facing of the character
  /// north, south, east, west, north-east, north-west, south-east, south-west
  String _facing = 'north-west';

  late final TextComponent _nickname;

  // There are eight images * 0.10
  static const double time = 8 * 0.10;

  RemotePlayer(
      BuildContext context,
      CharacterModel characterModel, {
        Vector2? position,
        Vector2? size,
        required Map<NpcState, SpriteAnimation> animations,
      }) : super(
    position: position,
    size: size,
    animations: animations,
  ) {
    this.context = context;
    this._characterModel = characterModel;

    timer = Timer(time)
      ..stop()
      ..callback = () {
        this.current = DirectionalHelper.getDirectionalSpriteAnimation(
            _facing, StateAction.Idle);
      };

    hideDeadMonumentTimer = Timer(5.0)
      ..stop()
      ..callback = () {
        gameRef.components.remove(_crypt);
      };

    _listenBuffer();
  }

  //Getter and setters
  CharacterModel get characterModel => _characterModel;

  set characterModel(CharacterModel value) {
    _characterModel = value;
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

  void _listenBuffer() {
    SocketManager.socket.on('remotePlayer', (data) {
        bool isMine = data['id'] == _characterModel.id;
        if (!isMine) return;

        this._characterModel = CharacterModel.fromJsonSingle(data);
        if(this._characterModel.action == 'MOVE') {
          serverMove(this._characterModel.direction,
              Vector2(this._characterModel.offsetX.toDouble(),
                  this._characterModel.offsetY.toDouble()));
        }
        if(this._characterModel.action == 'ATTACK') {
          _facing = this._characterModel.direction;
          this.remoteAttackAnimation();
        }
    });

    SocketManager.socket.on("leaveArena", (data) {
      gameRef.components.remove(_nickname);
      gameRef.components.remove(this);
    });
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
    )..anchor = Anchor.topCenter;
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    final shape = HitboxCircle(definition: 0.4);
    addHitbox(shape);

    _nickname.position = Vector2(this.position.x + this.size.x / 2, this.position.y);
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
    if (hp <= 0) {
      timer.start();
      this.die();
    }

    debugColor = _isCollision ? _collisionColor : _defaultColor;

    updateCurrentAnimation(_characterModel.action, this._facing);
    if(!_velocity.isZero()) {
      position.add(_velocity * maxSpeed.toDouble() * dt);
    }

    _isCollision = false;
  }

  Vector2 get velocity => _velocity;

  void setVelocity(Vector2 newVelocity) {
    this._velocity = newVelocity;
  }

  void serverMove(String direction, Vector2 serverPosition) {
    this._facing = direction;

    this.position = Vector2(serverPosition.x, serverPosition.y);
  }

  void updateCurrentAnimation(String action, String direction) {
    if(action == 'MOVE') {
      switch (direction) {
        case 'north-west':
          this.current = NpcState.runTopLeft;
          this.setVelocity(Vector2(-1, 0));
          break;
        case 'south-east':
          this.current = NpcState.runBottomRight;
          this.setVelocity(Vector2(1, 0));
          break;
        case 'north-east':
          this.current = NpcState.runTopRight;
          this.setVelocity(Vector2(0, -1));
          break;
        case 'south-west':
          this.current = NpcState.runBottomLeft;
          this.setVelocity(Vector2(0, 1));
          break;
        case 'west':
          this.current = NpcState.runLeft;
          this.setVelocity(Vector2(-1, 1));
          break;
        case 'south':
          this.current = NpcState.runDown;
          this.setVelocity(Vector2(1, 1));
          break;
        case 'north':
          this.current = NpcState.runTop;
          this.setVelocity(Vector2(-1, -1));
          break;
        case 'east':
          this.current = NpcState.runRight;
          this.setVelocity(Vector2(1, -1));
          break;
        }
    }
    if(action == 'IDLE') {
      this.current = DirectionalHelper.getDirectionalSpriteAnimation(
          _facing, StateAction.Idle);
      this.setVelocity(Vector2(0, 0));
    }
  }

  void remoteAttackAnimation() {
    current = DirectionalHelper.getDirectionalSpriteAnimation(
        _facing, StateAction.Attack);
  }

  @override
  void onCollision(Set<Vector2> points, Collidable other) async {
    if (other is Npc) {
      if (other.isPlayerPressAttack) {
        _isCollision = true;
        other.isPlayerPressAttack = false;

        hp -= 7;
      }
    } else if (other is Water) {
      if (this.position.x + this.size.x < other.position.x ||
          this.position.x > other.position.x + other.size.x ||
          this.position.y + this.size.y < other.position.y ||
          this.position.y > other.position.y + other.size.y) {
        return;
      }
      CollisionDetect.narrowPhase(this, other);
    } else if (other is Tree) {
      if (this.position.x + this.size.x < other.position.x ||
          this.position.x > other.position.x + other.size.x ||
          this.position.y + this.size.y < other.position.y ||
          this.position.y > other.position.y + other.size.y) {
        return;
      }
      CollisionDetect.narrowPhase(this, other);
    } else if (other is Character) {
      if (other.isPlayerPressAttack) {
        print('${other.characterModel.nickname} hit on enemy --> ${this.characterModel.nickname}');
        SocketManager.socket.emit('attack', this.characterModel);
        other.setIsPlayerPressAttack(false);
      }
    }
  }

  void die() async {
    Sprite sprite = await Sprite.load('crypt.png');
    gameRef.add(_crypt = SpriteComponent(
      sprite: sprite,
      position: this.position,
      size: Vector2(50, 50),
    ));
    gameRef.components.remove(_nickname);
    gameRef.components.remove(this);
  }
}
