
class HexColor {
  static int convertHexColor(String hexColor) {
    String convertedColor = '0xff' + hexColor;
    convertedColor = convertedColor.replaceAll('#', '');
    return int.parse(convertedColor);
  }
}