
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/extensions.dart';

class Player extends SpriteAnimationComponent with Hitbox {
  static const speed = 150;
  final Vector2 velocity = Vector2(0, 0);
  bool _stop = false;
  Vector2 target;

  Player({
    Vector2 position,
    Vector2 size,
  }) : super(position: position, size: size);

  Player.fromFrameData(
      Image image,
      SpriteAnimationData data, {
        Vector2 position,
        Vector2 size,
      }) : super(position: position, size: size) {
    animation = SpriteAnimation.fromFrameData(image, data);
  }

  void onMouseMove(Vector2 mousePosition) {
    target = mousePosition;
  }
  
  void stopCharacter(bool stop) {
    this._stop = stop;
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    debugMode = true;
  }

  @override
  void update(double dt) {
    super.update(dt);
    if(!_stop) {
      final displacement = velocity * (speed * dt);
      position += displacement;
    }
  }
}