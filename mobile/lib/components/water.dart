import 'package:flame/components.dart';
import 'package:flame/geometry.dart';
import 'package:rpg_game/components/character.dart';
import 'package:rpg_game/game.dart';

class Water extends SpriteComponent with HasGameRef<MyGame>, Hitbox, Collidable {
  Sprite? sprite;
  bool _isWallHit = false;

  Water({
    this.sprite,
    Vector2? position,
    Vector2? size,
  }) : super(position: position, size: size);

  bool get isWallHit => _isWallHit;


  void setWallHit(bool value) {
    _isWallHit = value;
  }

  @override
  void onMount() {
    super.onMount();

    final shape = HitboxCircle(definition: 0.6);
    addShape(shape);
  }
  
   @override
  void onCollision(Set<Vector2> intersectionPoints, Collidable other) {
    if (other is Character) {
      _isWallHit = true;
    }
  }

  @override
  void update(double dt) {
    super.update(dt);

    _isWallHit = false;
  }
}
