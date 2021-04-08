
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/palette.dart';
import 'package:flame/game.dart';
import 'package:flame/extensions.dart';

class Player extends SpriteAnimationComponent {
  static const speed = 200;
  static final Paint _blue = BasicPalette.blue.paint();
  static final Paint _white = BasicPalette.white.paint();
  static final Vector2 objSize = Vector2.all(50);

  Vector2 target;

  bool onTarget = false;
  Rect _toRect() => position.toPositionedRect(objSize);

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

  void mouseHover(Vector2 mousePosition) {
    target = mousePosition;
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    canvas.drawRect(
      _toRect(),
      onTarget ? _blue : _white,
    );
  }

  @override
  void update(double dt) {
    final target = this.target;
    super.update(dt);
    if (target != null) {
      onTarget = _toRect().contains(target.toOffset());

      if (!onTarget) {
        final dir = (target - position).normalized();
        position += dir * (speed * dt);
      }
    }
  }
}