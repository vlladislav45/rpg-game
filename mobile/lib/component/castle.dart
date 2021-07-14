
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:rpg_game/game.dart';

class Castle extends SpriteComponent with HasGameRef<MyGame>, Tappable {
  static final String _overlay = 'CastleMenu';

  Castle({
    Vector2? position,
    Vector2? size,
  }): super(position: position, size: size);

  @override
  bool get debugMode => true;

  @override
  void onGameResize(Vector2 gameSize) {
    super.onGameResize(gameSize);
  }

  @override
  bool onTapDown(_) {
    print('Tapped Castle');

    if (gameRef.overlays.isActive(_overlay)) {
      gameRef.overlays.remove(_overlay);
    } else {
      gameRef.overlays.add(_overlay);
    }
    return false;
  }
}
