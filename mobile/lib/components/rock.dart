
import 'package:flame/components.dart';
import 'package:rpg_game/components/square.dart';
import 'package:flame/extensions.dart';
import 'package:flame/geometry.dart';
import 'package:flutter/material.dart';

class Rock extends SquareComponent with Hitbox {
  Rock(Vector2 position) {
    this.position.setFrom(position);
    size.setValues(50, 50);
    paint = Paint()..color = const Color(0xFF2222FF);
    addShape(HitboxRectangle());
  }

  @override
  int get priority => 2;
}