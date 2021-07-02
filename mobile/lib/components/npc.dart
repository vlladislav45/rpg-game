
import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/geometry.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';
import 'package:rpg_game/components/character.dart';
import 'package:rpg_game/game.dart';
import 'package:rpg_game/utils/directional_helper.dart';

class Npc extends SpriteAnimationGroupComponent<NpcState> with Hitbox, Collidable, HasGameRef<MyGame> {
  // On Single player game character
  late final Character _character;

  // Text components
  late final TextComponent _name;
  late final TextComponent _title;
  late final TextComponent _healthBar;

  // properties
  static const speed = 50;
  bool _isCollision = false;
  late final bool _isAggressive;
  int _range = 150;
  int health = 100;
  String _facing = "";

  bool isPlayerPressAttack = false;
  bool isNpcDeath = false;

  // Timer
  static const double time = 8 * 0.10;
  late final Timer _timer;

  Npc(bool isAggressive,
      character,
      animations, {
    Vector2? position,
    Vector2? size,
  }) : super(
    position: position,
    size: size,
    animations: animations,
  ) {
    this._character = character;
    this._isAggressive = isAggressive;

    _timer = Timer(time)
      ..stop()
      ..callback = () {
        this.current = DirectionalHelper.getDirectionalSpriteAnimation(
            _facing, StateAction.Idle);
      };
  }


  @override
  void onMount() {
    super.onMount();

    final shape = HitboxCircle(definition: 0.8);
    addShape(shape);
  }

  @override
  void onCollision(Set<Vector2> points, Collidable other) {
    if (other is Character) {
      print('Character hit the npc ${other.isPlayerPressAttack}');
      if(other.isPlayerPressAttack) {
        _isCollision = true;

        other.isPlayerPressAttack = false;
        if(health > 0) {
          health -= 20;
        }
      }
    }
  }


  @override
  Future<void> onLoad() async {
    super.onLoad();

    //Npc name
    gameRef.add(
      _name = _renderName(),
    );

    //Npc title
    if(_isAggressive) {
      gameRef.add(
        _title = _renderAggressiveMode(),
      );
    }

    // Npc health bar
    gameRef.add(
      _healthBar = _renderHealthBar()
    );
  }

  TextComponent _renderName() {
    return TextComponent(
      'Knight',
      position: Vector2(this.position.x + this.size.x / 2, this.position.y - 10),
      textRenderer: TextPaint(
        config: TextPaintConfig(
          color: BasicPalette.black.color,
          fontSize: 14.0,
        ),
      ),
    )
      ..anchor = Anchor.topCenter;
  }

  TextComponent _renderAggressiveMode() {
    return TextComponent(
      '* ',
      position: Vector2(this.position.x + this.size.x / 5, this.position.y - 30),
      textRenderer: TextPaint(
        config: TextPaintConfig(
          color: BasicPalette.green.color,
          fontSize: 14.0,
        ),
      ),
    )
      ..anchor = Anchor.topCenter;
  }

  TextComponent _renderHealthBar() {
    return TextComponent(
      '$health HP',
      position: Vector2(this.position.x + this.size.x / 2, this.position.y - 25),
      textRenderer: TextPaint(
        config: TextPaintConfig(
          color: BasicPalette.red.color,
          fontSize: 14.0,
        ),
      ),
    )
      ..anchor = Anchor.topCenter;
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    _name.position = Vector2(this.position.x + this.size.x / 2, this.position.y - 10);
    if(_isAggressive) {
      _title.position = Vector2(this.position.x + this.size.x / 5, this.position.y - 30);
    }
    _healthBar.position = Vector2(this.position.x + this.size.x / 2, this.position.y - 25);
    _healthBar.text = '$health HP';

    debugMode = true;
  }

  @override
  void update(double dt) {
    super.update(dt);
    _timer.update(dt);

    final Vector2 displacement = this.pathFinding() * (speed * dt);
    position.add(displacement);

    if(health <= 0) {
      die();
    }

    _isCollision = false;
  }

  Vector2 pathFinding() {
    Vector2 pathFinder = Vector2.zero();

    double differentX = (_character.position.x + _character.width / 2) - position.x;
    double differentY = (_character.position.y + _character.height / 2) - position.y;

    // print('offsetY: $differentY');
    // print('offsetX: $differentX');
    facing();
    if((differentX <= this._range) &&
        (differentY <= this._range) && _isAggressive && !_character.isDead) {

      if(differentX > 0)
        pathFinder.add(Vector2(1, 0));
      else
        pathFinder.add(Vector2(-1, 0));

      if(differentY > 0)
        pathFinder.add(Vector2(0, 1));
      else
        pathFinder.add(Vector2(0, -1));

      if ((differentX < 100 && differentX > -100) && (differentY < 100 && differentY > -100)) {
        this.current = DirectionalHelper.getDirectionalSpriteAnimation(_facing, StateAction.Attack);
        isPlayerPressAttack = true;
        _timer.start();
      }

      return pathFinder;
    }

    this.current = DirectionalHelper.getDirectionalSpriteAnimation(_facing, StateAction.Idle);
    return Vector2.zero();
  }

  void facing() {
    double differentX = (_character.position.x + _character.width / 2) - position.x;
    double differentY = (_character.position.y + _character.height / 2) - position.y;

    final double npcAngle = (atan2(differentY, differentX) / pi) * 180;

    // print(npcAngle);
    /// TOP right side of the circle
    if(npcAngle >= 60 && npcAngle <= 90) { // Top direction
      current = NpcState.runDown;
      _facing = "north";
    }else if(npcAngle >= 30 && npcAngle < 60) { // Top right direction
      current = NpcState.runBottomRight;
      _facing = "south-east";
    }else if(npcAngle >= 0 && npcAngle < 30) { // Right direction
      current = NpcState.runRight;
      _facing = "east";
      /// Top left side of the circle
    }else if(npcAngle >= 90 && npcAngle <= 120) { // Top direction
      current = NpcState.runDown;
      _facing = "south";
    } else if(npcAngle >= 120 && npcAngle < 150) { // Top left direction
      current = NpcState.runBottomLeft;
      _facing = "south-left";
    } else if(npcAngle >= 180 && npcAngle < 150) { // Left direction
      current = NpcState.runLeft;
      _facing = "west";
    }
    /// BOTTOM right side of the circle
    if(npcAngle >= -60 && npcAngle <= -90) { // Down direction
      current = NpcState.runTop;
      _facing = "north";
    } else if(npcAngle >= -30 && npcAngle < -60) { // Bottom right direction
      current = NpcState.runTopRight;
      _facing = "north-east";
    } else if(npcAngle >= -0 && npcAngle < -30) { // Right direction
      current = NpcState.runRight;
      _facing = "east";
      /// Bottom left side of the circle
    } else if(npcAngle >= -90 && npcAngle <= -120) { // Down direction
      current = NpcState.runTop;
      _facing = "north";
    } else if(npcAngle >= -120 && npcAngle < -150) { // Bottom left direction
      current = NpcState.runTopLeft;
      _facing = "north-west";
    } else if(npcAngle >= -180 && npcAngle < -150) { // Left direction
      current = NpcState.runLeft;
      _facing = "west";
    }
  }

  void die() async {
    isNpcDeath = true;
      gameRef.add(
          SpriteComponent(
            sprite: await Sprite.load('crypt.png'),
            position: this.position,
            size: Vector2(50,50),
          )
      );
      gameRef.remove(this);
      gameRef.remove(_name);
      if(_isAggressive) gameRef.remove(_title);
      gameRef.remove(_healthBar);
  }
}
