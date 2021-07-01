import 'dart:convert';
import 'dart:math';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/src/spritesheet.dart';
import 'package:rpg_game/components/water.dart';
import 'package:rpg_game/game.dart';
import 'package:rpg_game/utils/convert_coordinates.dart';

class Map extends IsometricTileMapComponent with HasGameRef<MyGame> {
  static final R = Random();

  // Width and height of all maps
  static const double MAP_OFFSETX_LENGTH = 25;
  static const double MAP_OFFSETY_LENGTH = 25;

  // Constructor
  Map(
      SpriteSheet tileset,
      List<List<int>> matrix,
      {Vector2? destTileSize,
        double? tileHeight})
      : super(tileset, matrix, destTileSize: destTileSize, tileHeight: tileHeight);


  @override
  Future<void> onLoad() async {
    Vector2 topLeft = Vector2(500,150);

    for (var i = 0; i < matrix.length; i++) {
      for (var j = 0; j < matrix[i].length; j++) {
        final element = matrix[i][j];
        if (element == -1) {
          final p = getBlockPositionInts(j, i);
          final waterSprite = await gameRef.loadSprite('sprites/tile_maps/water.png');
          gameRef.add(Water(
            sprite: waterSprite,
            position: p + topLeft,
            size: waterSprite.srcSize,
          ));
        }
      }
    }
  }

  @override
  void render(Canvas c) async {
    super.render(c);

    debugMode = true;
  }

  static List<List<int>> fromJson(List<dynamic> list1) => [
    for (final list2 in list1) [for (final number in list2) number as int]
  ];

  static List<List<int>> toList(String response) {
    final decodedJson = json.decode(response.toString());
    if (decodedJson == null) return [];

    List<dynamic> array = decodedJson
        .map((s) => (s as List).map((e) => e as int).cast<int>().toList())
        .toList();

    return fromJson(array);
  }

  /// If map is loaded in onLoad method, 
  /// the water tiles will be appear on top the iso tiles
  void addRestrictions() async {
    final waterSprite = await gameRef.loadSprite('sprites/tile_maps/water.png');
    //Add watter around isometric map
    for (int i = 0; i < this.matrix.length; i++) {
      int lastRow = this.matrix.length - 1;
      if (i == 0 || i == lastRow) {
        //Loop columns
        for (int j = 0; j < this.matrix[i].length; j++) {
          final element = this.matrix[i][j];
          if (element != -1) {
            // if tile exists
            final p = this.getBlockPositionInts(j, i) +
                topLeft; // get coordinate of the tile
            // and add obstacle(wall)
            gameRef.add(Water(
              sprite: waterSprite,
              position: p,
              size: waterSprite.srcSize,
            ));
          }
          int lastColumn = this.matrix[i].length - 1;
          if (j == 0 || j == lastColumn) {
            // Loop first and last columns vertically
            for (int r = 0; r < this.matrix.length; r++) {
              final element =
                  this.matrix[r][j]; // in first column [0][0], [1][0] etc..
              if (element != -1) {
                // if tile exists
                final p = this.getBlockPositionInts(j, r) +
                    topLeft; // get coordinates of tile
                //add obstacle (wall)
                  gameRef.add(Water(
                    sprite: waterSprite,
                    position: p,
                    size: waterSprite.srcSize,
                  ));
              }
            }
          }
        }
      }
    }
  }

  Vector2 mapSize() {
    // Map width and height contribute equally in both directions
    final double side = MAP_OFFSETX_LENGTH + MAP_OFFSETY_LENGTH;
    return Vector2(side * effectiveTileSize.x / 2,
                   side * effectiveTileSize.y / 2);
  }

  // Generate random coordinates
  Vector2 genCoord() {
    // double S = (mapSize().x * 2) + (mapSize().y * 2);
    // return -S + R.nextDouble() * (2 * S);

    // double x = R.nextDouble() * (mapSize().x / 4);
    // double y = R.nextDouble() * (mapSize().y / 2);
    double x = R.nextDouble() * 1300 + 500;
    double y = R.nextDouble() * 300 + 150;
    return Vector2(x, y);
  }
}
