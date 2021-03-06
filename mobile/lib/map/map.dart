import 'dart:convert';
import 'dart:math';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/src/spritesheet.dart';
import 'package:rpg_game/component/tree.dart';
import 'package:rpg_game/component/water.dart';
import 'package:rpg_game/game.dart';

class Map extends IsometricTileMapComponent with HasGameRef<MyGame> {
  static final R = Random();

  // Walls
  List<Component> _restrictObstacles = [];
  // Trees
  List<Offset> _treeOffsets = [];

  // Constructor
  Map(
      SpriteSheet tileset,
      List<List<int>> matrix,
      {Vector2? destTileSize,
        double? tileHeight})
      : super(tileset, matrix, destTileSize: destTileSize, tileHeight: tileHeight);


  List<Offset> get treeOffsets => _treeOffsets;

  @override
  Future<void> onLoad() async {
    for (var i = 0; i < matrix.length; i++) {
      for (var j = 0; j < matrix[i].length; j++) {
        final element = matrix[i][j];
        if (element == -1) {
          final p = getBlockPositionInts(j, i);
          final waterSprite = await gameRef.loadSprite('sprites/tile_maps/water.png');

          Water obstacle;
          gameRef.add(obstacle = Water(
            sprite: waterSprite,
            position: p,
            size: waterSprite.srcSize,
          ));
          _restrictObstacles.add(obstacle);
        }
      }
    }
  }

  void renderTrees() async {
    for (var i = 0; i < matrix.length; i++) {
      for (var j = 0; j < matrix[i].length; j++) {
        final element = matrix[i][j];
        if(element == 4) {
          final p = getBlockPositionInts(j, i);
          final treeSprite = await gameRef.loadSprite('sprites/obstacles/Tree_2.png');

          _treeOffsets.add(new Offset(j.toDouble(), i.toDouble()));
          gameRef.add(Tree(
            sprite: treeSprite,
            position: p,
            size: Vector2(151,120),
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

  /// DEPRECATED!!!!!!!!!!!!!!!!!!!!!!!!
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
            final p = this.getBlockPositionInts(j, i); // get coordinate of the tile
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
              final element = this.matrix[r][j]; // in first column [0][0], [1][0] etc..
              if (element != -1) {
                // if tile exists
                final p = this.getBlockPositionInts(j, r); // get coordinates of tile
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

  void removeChildComponents() {
    gameRef.components.removeAll(_restrictObstacles);
  }

  Vector2 mapSize() {
    // Map width and height contribute equally in both directions
    final double side = matrix.length.toDouble() + matrix[0].length;
    return Vector2(side * effectiveTileSize.x / 2,
                   side * effectiveTileSize.y / 2);
  }

  // Generate random coordinates
  Vector2 genCoord() {
    double x;
    double y;
    Block block;
    do {
      block = Block((R.nextInt(matrix.length)), (R.nextInt(matrix[0].length)));
    }while(!this.containsBlock(block) && this.matrix[block.x][block.y] == 4 && block.x < 0 && block.y < 0);

    x = this.getBlockPosition(block).x;
    y = this.getBlockPosition(block).y;
    return Vector2(x, y);
  }
}
