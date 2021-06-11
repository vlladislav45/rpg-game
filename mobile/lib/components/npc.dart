
import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:rpg_game/game.dart';

enum NpcState {
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

class Npc extends SpriteAnimationGroupComponent<NpcState> with HasGameRef<MyGame> {
  static const speed = 80;
  final Vector2 velocity = Vector2(0, 0);
  static const double S = 1500;
  static final R = Random();

  Npc(animations, {
    Vector2? position,
    Vector2? size,
  }) : super(
    position: position,
    size: size,
    animations: animations
  );

  Npc.fromFrameData(
      animations,
      Image image,
      Map<NpcState, SpriteAnimationData> data, {
        Vector2? position,
        Vector2? size,
      }) : super(
    position: position,
    size: size,
    animations: animations
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

  // Generate random coordinates
  static double generateRandomCoordinates() {
    return -S + R.nextDouble() * (2 * S);
  }
}