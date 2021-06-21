
import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/geometry.dart';
import 'package:rpg_game/components/character.dart';
import 'package:rpg_game/game.dart';
import 'package:rpg_game/utils/directional_helper.dart';

class Npc extends SpriteAnimationGroupComponent<NpcState> with Hitbox, Collidable, HasGameRef<MyGame> {
  static const speed = 50;
  final Vector2 velocity = Vector2(0, 0);

  // Random spawn
  static const double S = 1500;
  static final R = Random();

  // Collision
  bool _isCollision = false;

  // On Single player game character
  late final Character _character;

  static final int _range = 50; // 50 x and y from the players

  Npc(character,
      animations, {
    Vector2? position,
    Vector2? size,
  }) : super(
    position: position,
    size: size,
    animations: animations,
  ) {
    this._character = character;
  }


  @override
  void onMount() {
    super.onMount();

    final shape = HitboxCircle(definition: 0.6);
    addShape(shape);
  }

  @override
  void onCollision(Set<Vector2> points, Collidable other) {
    if (other is Character && other.current == NpcState.hitTop) {
      _isCollision = true;
      print('My NPC is hitted and it is dead');
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

    final Vector2 displacement = this.pathFinding() * (speed * dt);
    position.add(displacement);
    _isCollision = false;
  }

  Vector2 pathFinding() {
    Vector2 pathFinder = Vector2.zero();

    double differentX = _character.position.x - position.x;
    double differentY = _character.position.y - position.y;

    print('offsetY: $differentY');
    print('offsetX: $differentX');

    if(differentX > 0)
      pathFinder.add(Vector2(3,0));
    else
      pathFinder.add(Vector2(-3,0));

    if(differentY > 0)
      pathFinder.add(Vector2(0,3));
    else
      pathFinder.add(Vector2(0,-3));

    return pathFinder;
  }

  // Generate random coordinates
  static double generateRandomCoordinates() {
    return -S + R.nextDouble() * (2 * S);
  }
}