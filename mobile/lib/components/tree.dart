import 'package:flame/components.dart';
import 'package:flame/geometry.dart';
import 'package:flutter/material.dart';
import 'package:rpg_game/game.dart';

import 'npc.dart';

class Tree extends SpriteComponent with HasGameRef<MyGame> {
  Sprite? sprite;
  bool _isAround = false;
  late final Paint _activePaint;

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
  void update(double dt) {
    super.update(dt);

    _isAround = false;
  }
}
