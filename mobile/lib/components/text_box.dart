
import 'package:flame/components.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';
import 'package:rpg_game/utils/hex_color.dart';

final _regularTextConfig = TextPaintConfig(color: BasicPalette.white.color);
final _tiny = TextPaint(config: _regularTextConfig.withFontSize(12.0));

class TextBox extends TextBoxComponent {
  final _white = Paint()
    ..color = BasicPalette.white.color
    ..style = PaintingStyle.stroke;

  TextBox(String text) : super(
    text,
    textRenderer: _tiny,
    boxConfig: TextBoxConfig(
      timePerChar: 0.05,
      growingBox: true,
      margins: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
    ),
  );

  @override
  void drawBackground(Canvas c) {
    final rect = Rect.fromLTWH(0, 0, width, height);
    c.drawRect(rect, Paint()..color = Color(HexColor.convertHexColor('0xFFFF00')));
    final margin = boxConfig.margins;
    final innerRect = Rect.fromLTWH(
      margin.left,
      margin.top,
      width - margin.horizontal,
      height - margin.vertical,
    );
    c.drawRect(innerRect, _white);
  }
}
