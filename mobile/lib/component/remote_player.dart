import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/geometry.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rpg_game/component/npc.dart';
import 'package:rpg_game/component/tree.dart';
import 'package:rpg_game/component/water.dart';
import 'package:rpg_game/game.dart';
import 'package:rpg_game/logic/cubit/single_player_statuses/single_player_statuses_cubit.dart';
import 'package:rpg_game/model/character_model.dart';
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

  // Collisions
  final _collisionColor = Colors.amber;
  final _defaultColor = Colors.cyan;
  bool _isCollision = false;
  bool _isWall = false;
  bool _isDead = false;
  bool _isPlayerPressAttack = false;

  // Character Properties
  late int hp = _characterModel.hp;

  //Character model
  late final CharacterModel _characterModel;
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
        _isPlayerPressAttack = false;
        this.current = DirectionalHelper.getDirectionalSpriteAnimation(
            _facing, StateAction.Idle);
      };
  }

  //Getter and setters
  bool get isDead => _isDead;

  void setDead(bool value) {
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
    print(_characterModel);
    print(hp);
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
    )..anchor = Anchor.topCenter;
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    final shape = HitboxCircle(definition: 0.4);
    addShape(shape);

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



    _isCollision = false;
    _isWall = false;
  }

  Vector2 get velocity => _velocity;

  void setVelocity(Vector2 newVelocity) {
    this._velocity = newVelocity;
  }

  void updateCurrentAnimation() {

  }

  void attack() {
    _isPlayerPressAttack = true;
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
    }
  }

  void die() async {
    this._isDead = true;

    Sprite sprite = await Sprite.load('crypt.png');
    gameRef.add(SpriteComponent(
      sprite: sprite,
      position: this.position,
      size: Vector2(50, 50),
    ));
    gameRef.components.remove(_nickname);
    gameRef.components.remove(this);
  }
}
