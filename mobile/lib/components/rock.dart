import 'package:flame/components.dart';
import 'package:rpg_game/game.dart';

class Rock extends SpriteComponent with HasGameRef<MyGame> {
  
  @override
  Future<void> onLoad() async {
    sprite = await gameRef.loadSprite('sprites/walls/stones.png');
  }
}