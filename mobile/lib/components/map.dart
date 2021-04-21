import 'dart:convert';
import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/src/spritesheet.dart';
import 'package:rpg_game/components/rock.dart';
import 'package:rpg_game/game.dart';

class Map extends IsometricTileMapComponent with HasGameRef<MyGame> {
  static const double S = 1500;
  static final R = Random();

  // Constructor
  Map(SpriteSheet tileset, List<List<int>> matrix, {Vector2 destTileSize})
      : super(tileset, matrix);

  static List<List<int>> fromJson(List<dynamic> list1) => [
        for (final list2 in list1) [for (final number in list2) number as int]
      ];

  static List<List<int>> toList(String response) {
    final decodedJson = json.decode(response.toString());
    if (decodedJson == null) return [];

    List<dynamic> test = decodedJson
        .map((s) => (s as List).map((e) => e as int).cast<int>().toList())
        .toList();

    return fromJson(test);
  }

  /// If map is loaded in onLoad method, 
  /// the stones will be appear below the iso tiles
  void setWalls() async {
    final rockWallSprite = await gameRef.loadSprite('sprites/walls/stones.png');
    //Add walls arround isometric map
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
            gameRef.add(Rock(
              sprite: rockWallSprite,
              position: p,
              size: rockWallSprite.srcSize,
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
                  gameRef.add(Rock(
                    sprite: rockWallSprite,
                    position: p,
                    size: rockWallSprite.srcSize,
                  ));
              }
            }
          }
        }
      }
    }
  }

  // Generate random coordinates
  static double genCoord() {
    return -S + R.nextDouble() * (2 * S);
  }
}
