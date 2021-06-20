
import 'package:flame/extensions.dart';

class ConvertCoordinates {
  /// Converts a coordinate from the isometric space to the cartesian space.
  static Vector2 isoToCart(Vector2 p) {
    final x = (2 * p.y + p.x) / 2;
    final y = (2 * p.y - p.x) / 2;
    return Vector2(x, y);
  }

  /// Converts a coordinate from the cartesian space to the isometric space.
  static Vector2 cartToIso(Vector2 p) {
    final x = p.x - p.y;
    final y = (p.x + p.y) / 2;
    return Vector2(x, y);
  }
}