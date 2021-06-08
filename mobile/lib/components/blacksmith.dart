
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:rpg_game/game.dart';

class Blacksmith extends SpriteComponent with HasGameRef<MyGame>, Tapable {
  static final String _overlay = 'BlacksmithMenu';

  Blacksmith({
    Vector2 position,
    Vector2 size,
  }): super(position: position, size: size);

  @override
  bool get debugMode => true;

  @override
  bool onTapDown(_) {
    print('Tapped Blacksmith');

    if (gameRef.overlays.isActive(_overlay)) {
      gameRef.overlays.remove(_overlay);
    } else {
      gameRef.overlays.add(_overlay);
    }
    return false;
  }
}