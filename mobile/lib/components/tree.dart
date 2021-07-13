import 'package:flame/components.dart';
import 'package:flame/geometry.dart';
import 'package:flutter/material.dart';
import 'package:rpg_game/game.dart';

import 'npc.dart';

class Tree extends SpriteComponent with HasGameRef<MyGame>, Hitbox, Collidable {
  Sprite? sprite;
  bool _isAround = false;

  Tree({
    this.sprite,
    Vector2? position,
    Vector2? size,
  }) : super(position: position, size: size);


  bool get isAround => _isAround;

  void setAround(bool value) {
    _isAround = value;
  }

  @override
  void onMount() {
    super.onMount();

    final shape = HitboxCircle(definition: 0.8);
    addShape(shape);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, Collidable other) {
    if (other is Npc) {
      _isAround = true;
    }
  }

  @override
  void update(double dt) {
    super.update(dt);

    _isAround = false;
  }
}
