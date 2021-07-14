import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:rpg_game/game.dart';

class Portal extends SpriteAnimationComponent with HasGameRef<MyGame>, Tappable {
  static final String _overlay = 'PortalMenu';

  Portal({Vector2? position, Vector2? size})
      : super(position: position, size: size);

  Portal.fromFrameData(
    Image image,
    SpriteAnimationData data, {
    Vector2? position,
    Vector2? size,
  }) : super(position: position, size: size) {
    animation = SpriteAnimation.fromFrameData(image, data);
  }

  @override
  bool get debugMode => true;

  @override
  bool onTapDown(_) {
    print('Tapped Portal');

    if (gameRef.overlays.isActive(_overlay)) {
      gameRef.overlays.remove(_overlay);
    } else {
      gameRef.overlays.add(_overlay);
    }
    return false;
  }
}
