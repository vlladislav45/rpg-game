
import 'dart:convert';
import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/src/spritesheet.dart';

class Map extends IsometricTileMapComponent {
  static const double S = 1500;
  static final R = Random();

  Map(SpriteSheet tileset, List<List<int>> matrix, {Vector2 destTileSize}) : super(tileset, matrix);

  static List<List<int>> fromJson(List<dynamic> list1) => [
    for (final list2 in list1)
      [
        for (final number in list2) number as int
      ]
  ];

  static List<List<int>> toList(String response) {
    final decodedJson = json.decode(response.toString());
    if(decodedJson == null) return [];

    List<dynamic> test = decodedJson.map((s) => (s as List)
        .map((e) => e as int).cast<int>()
        .toList())
        .toList();

    return fromJson(test);
  }

  static double genCoord() {
    return -S + R.nextDouble() * (2 * S);
  }
}