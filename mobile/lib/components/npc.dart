
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
  static const speed = 50;

  // Collision
  bool _isCollision = false;

  // On Single player game character
  late final Character _character;

  late final bool _isAggressive;
  int _range = 150;

  late final TextComponent _name;
  late final TextComponent _title;
  late final TextComponent _healthBar;

  int health = 100;

  Npc(bool isAggresive,
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
    this._isAggressive = isAggresive;
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
      print(other.isPlayerPressAttack);
      if(other.isPlayerPressAttack) {
        _isCollision = true;

        if(health > 0) {
          health -= 25;
          other.isPlayerPressAttack = false;
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
    double differentY = (_character.position.y + _character.height / Random().nextInt(3)) - position.y;

    // print('offsetY: $differentY');
    // print('offsetX: $differentX');

    // Radius
    if(differentX <= this._range && differentY <= this._range
        && _isAggressive) {

      if(differentX > 0)
        pathFinder.add(Vector2(1, 0));
      else
        pathFinder.add(Vector2(-1, 0));


      if(differentY > 0)
        pathFinder.add(Vector2(0, 1));
      else
        pathFinder.add(Vector2(0, -1));

      facing();
      return pathFinder;
    }

    return Vector2.zero();
  }

  void facing() {
    double differentX = _character.position.x - position.x;
    double differentY = _character.position.y - position.y;

    // print('ATAN22222222222222 ${atan2(differentY, differentX)}');
    // print('RESULT ${atan2(differentY, differentX) / pi * 180}');
    final double npcAngle = (atan2(differentY, differentX) / pi) * 180;

    /// TOP right side of the circle
    if(npcAngle >= 60 && npcAngle <= 90) // Top direction
      current = NpcState.runDown;
    else if(npcAngle >= 30 && npcAngle < 60) // Top right direction
      current = NpcState.runBottomRight;
    else if(npcAngle >= 0 && npcAngle < 30) // Right direction
      current = NpcState.runRight;
    /// Top left side of the circle
    else if(npcAngle >= 90 && npcAngle <= 120) // Top direction
      current = NpcState.runDown;
    else if(npcAngle >= 120 && npcAngle < 150) // Top left direction
      current = NpcState.runBottomLeft;
    else if(npcAngle >= 180 && npcAngle < 150) // Left direction
      current = NpcState.runLeft;
    /// BOTTOM right side of the circle
    if(npcAngle >= -60 && npcAngle <= -90) // Down direction
      current = NpcState.runTop;
    else if(npcAngle >= -30 && npcAngle < -60) // Bottom right direction
      current = NpcState.runTopRight;
    else if(npcAngle >= -0 && npcAngle < -30) // Right direction
      current = NpcState.runRight;
    /// Bottom left side of the circle
    else if(npcAngle >= -90 && npcAngle <= -120) // Down direction
      current = NpcState.runTop;
    else if(npcAngle >= -120 && npcAngle < -150) // Bottom left direction
      current = NpcState.runTopLeft;
    else if(npcAngle >= -180 && npcAngle < -150) // Left direction
      current = NpcState.runLeft;
  }

  void die() async {
      gameRef.add(
          SpriteComponent(
            sprite: await Sprite.load('crypt.png'),
            position: this.position,
            size: Vector2(50,50),
          )
      );
      gameRef.remove(this);
      gameRef.remove(_name);
      gameRef.remove(_title);
      gameRef.remove(_healthBar);
  }
}