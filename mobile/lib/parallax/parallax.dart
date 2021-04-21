import 'package:flame/components.dart';
import 'package:flame/parallax.dart';
import 'package:rpg_game/game.dart';

class MyParallaxComponent extends ParallaxComponent with HasGameRef<MyGame> {
  final _backgrounds = [
    'parallax/mountains/bgBack_mountain.png',
    'parallax/mountains/bgMid_mountain.png',
    'parallax/farground_cloud_1.png',
    'parallax/sun.png',
  ];

  @override
  Future<void> onLoad() async {
    parallax = await gameRef.loadParallax(
      _backgrounds,
      Vector2(1500,1500),
      baseVelocity: Vector2(20, 0),
      velocityMultiplierDelta: Vector2(1.8, 1.0),
    );
  }
}