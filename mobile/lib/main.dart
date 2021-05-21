import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rpg_game/widgets/game_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // to hide both top and bottom bars
  SystemChrome.setEnabledSystemUIOverlays ([]);

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight
  ]);

  runApp(MyGameWidget());
}
