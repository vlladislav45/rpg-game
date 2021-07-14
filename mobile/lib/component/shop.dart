
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';

import '../game.dart';

class Shop extends SpriteComponent with HasGameRef<MyGame>, Tappable {
  static final String _overlay = 'ShopMenu';

  Shop({
    Vector2? position,
    Vector2? size,
  }): super(position: position, size: size);

  @override
  bool get debugMode => true;

  @override
  bool onTapDown(_) {
    print('Tapped Shop');

    if (gameRef.overlays.isActive(_overlay)) {
      gameRef.overlays.remove(_overlay);
    } else {
      gameRef.overlays.add(_overlay);
    }
    return false;
  }
}
