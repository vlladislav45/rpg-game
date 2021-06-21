import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rpg_game/game.dart';
import 'package:rpg_game/logic/blocs/game/game_bloc.dart';
import 'package:rpg_game/logic/blocs/game/game_state.dart';
import 'package:rpg_game/utils/hex_color.dart';

Widget characterOverlayBuilder(BuildContext context, MyGame myGame) {
  return CharacterOverlay();
}

class CharacterOverlay extends StatefulWidget {
  @override
  CharacterOverlayState createState() {
    return CharacterOverlayState();
  }
}

class CharacterOverlayState extends State<CharacterOverlay>
    with TickerProviderStateMixin {
  AnimationController? controller;
  late double topLeftCharacterStatusWIDTH;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..addListener(() {
        setState(() {});
      });
    controller!.repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    this.topLeftCharacterStatusWIDTH = MediaQuery.of(context).size.width / 5;

    return Container(
      padding: EdgeInsets.all(10.0),
      alignment: Alignment.topLeft,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerRight,
          end: Alignment.centerLeft,
          colors: [
            Colors.black.withOpacity(0.60),
            Colors.black.withOpacity(0.75),
          ],
        ),
      ),
      width: this.topLeftCharacterStatusWIDTH,
      height: MediaQuery.of(context).size.width / 12,
      child: BlocBuilder<GameBloc, GameState>(builder: (context, state) {
        if (state is GamePlayerState) {
          return Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(
                  child: Container(
                    child: CircleAvatar(
                      maxRadius: 25.0,
                      backgroundColor: Colors.brown.shade800,
                      child: AutoSizeText(
                        'Lv. ${state.userModel.characters[0].level}',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),

                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      AnimatedContainer(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Color(HexColor.convertHexColor('#EC2018')),
                          borderRadius: BorderRadius.horizontal(left: Radius.circular(8.0), right: Radius.circular(8.0)),
                          gradient: LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            colors: [
                              Color(HexColor.convertHexColor('#FF2C1F')),
                              Color(HexColor.convertHexColor('#6D0E16')),
                            ],
                          ),
                        ),
                        duration: Duration(seconds: 1),
                        curve: Curves.fastOutSlowIn,
                        alignment: Alignment.center,
                        child: AutoSizeText(
                          '${state.userModel.characters[0].hp} / ${state.userModel.characters[0].hp}',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),

                      AnimatedContainer(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Color(HexColor.convertHexColor('#EC2018')),
                          borderRadius: BorderRadius.horizontal(left: Radius.circular(8.0), right: Radius.circular(8.0)),
                          gradient: LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            colors: [
                              Color(HexColor.convertHexColor('#00C1FA')),
                              Color(HexColor.convertHexColor('#004977')),
                            ],
                          ),
                        ),
                        duration: Duration(seconds: 1),
                        curve: Curves.fastOutSlowIn,
                        alignment: Alignment.center,
                        child: AutoSizeText(
                          '${state.userModel.characters[0].mana} / ${state.userModel.characters[0].mana}',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
          );
        }
        return CircularProgressIndicator();
      }),
    );
  }
}
