
import 'package:flame/components.dart';
import 'package:rpg_game/components/blacksmith.dart';
import 'package:rpg_game/components/castle.dart';
import 'package:rpg_game/components/portal.dart';
import 'package:rpg_game/components/shop.dart';
import 'package:rpg_game/game.dart';

class Town extends SpriteComponent with HasGameRef<MyGame> {
  //Each building component
  late Portal _portal;
  late Castle _castle;
  late Blacksmith _blacksmith;
  late Shop _shop;

  Town({
    Vector2? position,
    Vector2? size,
  }): super(position: position, size: size);

  Future<void> spawnTown() async {
    //Spawn portal
    List<Sprite> portalSprites = [];
    int countPortalSprites = 9;
    for(var i = 0; i < countPortalSprites; i++)
      portalSprites.add(await Sprite.load('sprites/buildings/portal/portal_0${i+1}.png'));

    _portal = Portal(
        size: Vector2(100,100),
        position: Vector2(500, 100))
      ..animation = SpriteAnimation.spriteList(portalSprites, stepTime: 0.50)
      ..anchor = Anchor.center;

    //Spawn castle
    final castleSprite = await Sprite.load('sprites/buildings/Castle_3_555x550.png');
    _castle = Castle(
      position: Vector2(50, 0),
      size: Vector2(125,125),
    )..sprite = castleSprite;

    //Spawn blacksmith
    final blacksmithSprite = await Sprite.load('sprites/buildings/Barracks_300x300.png');
    _blacksmith = Blacksmith(
      position: Vector2(500, 200),
      size: Vector2(100, 100),
    )..sprite = blacksmithSprite;

    //Spawn Shop
    final shopSprite = await Sprite.load('sprites/buildings/Dragons_den_300x300.png');
    _shop = Shop(
      position: Vector2(300, 150),
      size: Vector2(100,100),
    )..sprite = shopSprite;

    //Add to game
    gameRef.addAll([_portal, _castle, _blacksmith, _shop]);
  }
}