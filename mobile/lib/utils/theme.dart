import 'package:rpg_game/utils/hex_color.dart';
import 'package:flutter/material.dart';

class CustomTheme {
  static Color _lightPrimary = Color(HexColor.convertHexColor('#7f6000')); // main color
  static Color _lightPrimaryVariantColor =
      Color(HexColor.convertHexColor('#d61693')); // Appbar color
  static Color _lightSecondaryColor = Color(HexColor.convertHexColor('#000000'));
  static Color _lightSecondaryDonateColor = Color(HexColor.convertHexColor('#ffd400'));
  static Color _lightOnPrimaryColor = Color(HexColor.convertHexColor('#71cdc5')); // text
  static Color _lightAccentColor =
      Color(HexColor.convertHexColor('#c8ba2b')); // Title texts

  static final ThemeData theme = ThemeData(
    colorScheme: ColorScheme.light(
      background: _lightPrimary,
      primary: _lightPrimary,
      primaryVariant: _lightPrimaryVariantColor,
      secondary: _lightSecondaryColor,
      secondaryVariant: _lightSecondaryDonateColor,
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity,

    //Define the default font family.
    fontFamily: 'Vecna',

    // Define the default TextTheme. Use this to specify the default
    // text styling for headlines, titles, bodies of text, and more.
    textTheme: TextTheme(
      headline1: TextStyle(
          inherit: true,
          fontSize: 28.0,
          fontWeight: FontWeight.bold,
          color: _lightAccentColor,
          shadows: [
            Shadow(
                // bottomLeft
                offset: Offset(-1.5, -1.5),
                color: Color(HexColor.convertHexColor('#000000'))),
            Shadow(
                // bottomRight
                offset: Offset(1.5, -1.5),
                color: Color(HexColor.convertHexColor('#000000'))),
            Shadow(
                // topRight
                offset: Offset(1.5, 1.5),
                color: Color(HexColor.convertHexColor('#000000'))),
            Shadow(
                // topLeft
                offset: Offset(-1.5, 1.5),
                color: Color(HexColor.convertHexColor('#000000'))),
          ]),
      headline2: TextStyle(
        fontSize: 22,
        color: Colors.white,
      ),
      headline3: TextStyle(
        fontSize: 18,
        color: Colors.white,
      ),
      bodyText1: TextStyle(
          fontSize: 18.0,
          foreground: Paint()
            ..style = PaintingStyle.stroke
            ..strokeWidth = 1.0
            ..color = _lightSecondaryColor),
      bodyText2: TextStyle(
          fontSize: 13.0,
          fontWeight: FontWeight.bold,
          color: _lightSecondaryColor),
    ),
  );
}