import 'package:flame/game.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rpg_game/game.dart';
import 'package:rpg_game/widgets/blacksmith_overlay.dart';
import 'package:rpg_game/widgets/castle_overlay.dart';
import 'package:rpg_game/widgets/portal_overlay.dart';
import 'package:rpg_game/widgets/shop_overlay.dart';

class MyGameWidget extends StatefulWidget {
  const MyGameWidget({Key key}) : super(key: key);

  @override
  State<MyGameWidget> createState() {
    return MyGameWidgetState();
  }
}

class MyGameWidgetState extends State<MyGameWidget> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          padding: EdgeInsets.all(0.0),
          // width: double.infinity,
          // decoration: BoxDecoration(
          //   image: DecorationImage(
          //     image: AssetImage('assets/images/bg/Background_3_3840x2160.jpg'),
          //     fit: BoxFit.fill,
          //   ),
          // ),
          child: FutureBuilder(
            future: DefaultAssetBundle.of(context)
                .loadString('assets/maps/main-map.json'),
            builder: (context, snapshot) {
              if (!snapshot.hasData ||
                  snapshot.connectionState == ConnectionState.waiting)
                return Container(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(),
                );
              final jsonMap = snapshot.data;

              return GameWidget<MyGame>(
                game: MyGame(jsonMap: jsonMap),
                overlayBuilderMap: {
                  'PortalMenu': portalOverlayBuilder,
                  'CastleMenu': castleOverlayBuilder,
                  'BlacksmithMenu': blacksmithOverlayBuilder,
                  'ShopMenu': shopOverlayBuilder,
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
