
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/extensions.dart';

class Player extends SpriteAnimationComponent with Hitbox {
  static const speed = 200;

  static final Vector2 objSize = Vector2.all(150);

  Vector2 target;

  bool onTarget = false;
  Rect _toMousePosition() => position.toPositionedRect(objSize);

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

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    // canvas.drawRect(
    //   _toRect(),
    //   onTarget ? _blue : _white,
    // );
    debugMode = true;
  }

  @override
  void update(double dt) {
    super.update(dt);

    final target = this.target;

    if (target != null) {
      onTarget = _toMousePosition().contains(target.toOffset());

      if (!onTarget) {
        final dir = (target - position).normalized();
        position += dir * (speed * dt);
      }
    }
  }
}