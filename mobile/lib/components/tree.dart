import 'package:flame/components.dart';
import 'package:flame/geometry.dart';
import 'package:flutter/material.dart';
import 'package:rpg_game/game.dart';

import 'npc.dart';

class Tree extends SpriteComponent with HasGameRef<MyGame>, Hitbox, Collidable {
  Sprite? sprite;
  bool _isAround = false;
  late final Paint _activePaint;
  final Color _defaultColor = Colors.blue.withOpacity(0.8);

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
  Future<void> onLoad() async {
    _activePaint = Paint()..color = _defaultColor;
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, Collidable other) {
    if (other is Npc) {
      _isAround = true;
    }
  }


  @override
  void render(Canvas canvas) {
    super.render(canvas);

    renderShapes(canvas, paint: _activePaint);
  }

  @override
  void update(double dt) {
    super.update(dt);

    _isAround = false;
  }
}
