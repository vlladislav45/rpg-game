import 'package:flame/components.dart';
import 'package:rpg_game/game.dart';

class Rock extends SpriteComponent with HasGameRef<MyGame>, Hitbox, Collidable {
  Sprite sprite;
  bool _isWallHit = false;
  bool _isCollision = false;

  Rock({
    this.sprite,
    Vector2 position,
    Vector2 size,
  }) : super(position: position, size: size);
  
   @override
  void onCollision(Set<Vector2> intersectionPoints, Collidable other) {
    if (other is ScreenCollidable) {
      _isWallHit = true;
      return;
    }
    _isCollision = true;
  }
}