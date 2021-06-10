import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:rpg_game/game.dart';

enum CharacterState {
  idleRight,
  hitRight,
  runningRight,
  idleDown,
  hitDown,
  runningDown,
  idleLeft,
  hitLeft,
  runningLeft,
  idleUp,
  hitUp,
  runningUp,
}

class Character extends SpriteAnimationGroupComponent<CharacterState> with HasGameRef<MyGame>, Hitbox {
  static const speed = 150;
  final Vector2 velocity = Vector2(0, 0);

  Character({
    Vector2 position,
    Vector2 size,
  // ignore: missing_required_param
  }) : super(
    position: position,
    size: size,
  );

  Character.fromFrameData(
    Image image,
    Map<CharacterState, SpriteAnimationData> data, {
    Vector2 position,
    Vector2 size
  // ignore: missing_required_param
  }) : super(
    position: position,
    size: size,
  ) {
    animations = data.map((key, value) {
      return MapEntry(
        key,
        SpriteAnimation.fromFrameData(
          image,
          value,
        ),
      );
    });
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