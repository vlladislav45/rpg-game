
import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/geometry.dart';
import 'package:rpg_game/components/character.dart';
import 'package:rpg_game/game.dart';
import 'package:rpg_game/utils/directional_helper.dart';

class Npc extends SpriteAnimationGroupComponent<NpcState> with Hitbox, Collidable, HasGameRef<MyGame> {
  static const speed = 80;
  final Vector2 velocity = Vector2(0, 0);

  static const double S = 1500;
  static final R = Random();

  bool _isCollision = false;

  Npc(animations, {
    Vector2? position,
    Vector2? size,
  }) : super(
    position: position,
    size: size,
    animations: animations
  );


  @override
  void onMount() {
    super.onMount();

    final shape = HitboxCircle(definition: 0.6);
    addShape(shape);
  }

  @override
  void onCollision(Set<Vector2> points, Collidable other) {
    if (other is Character && other.current == NpcState.hitUp) {
      _isCollision = true;
      print('My NPC is hitted');
    }
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
    position.add(displacement);
    _isCollision = false;
  }

  // Generate random coordinates
  static double generateRandomCoordinates() {
    return -S + R.nextDouble() * (2 * S);
  }
}