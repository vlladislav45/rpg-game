
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flutter/material.dart' hide Image;

class Selector extends SpriteComponent {
  bool show = false;

  Selector(double s, Image image)
      : super(
    sprite: Sprite(image, srcSize: Vector2.all(64.0)),
    size: Vector2.all(s),
  );

  @override
  void render(Canvas canvas) {
    if (!show) {
      return;
    }

    super.render(canvas);
  }
}