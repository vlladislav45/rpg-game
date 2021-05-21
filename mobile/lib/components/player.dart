import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/extensions.dart';

class Player extends SpriteAnimationComponent with Hitbox {
  static const speed = 150;
  final Vector2 velocity = Vector2(0, 0);

  Player({Vector2 position, Vector2 size}) : super(position: position, size: size);

  Player.fromFrameData(
    Image image,
    SpriteAnimationData data, {
    Vector2 position,
    Vector2 size,
  }) : super(position: position, size: size) {
    animation = SpriteAnimation.fromFrameData(image, data);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    debugMode = true;
  }

  @override
  void update(double dt) {
    super.update(dt);

    final displacement = velocity * (speed * dt);
    position += displacement;
    
  }
}