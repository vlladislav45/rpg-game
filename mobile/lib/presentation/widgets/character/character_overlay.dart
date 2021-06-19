import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rpg_game/game.dart';
import 'package:rpg_game/logic/blocs/game/game_bloc.dart';
import 'package:rpg_game/logic/blocs/game/game_event.dart';
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
  late double width;

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
    this.width = MediaQuery.of(context).size.width / 5;

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
          )
      ),
      width: this.width,
      height: MediaQuery.of(context).size.width / 12,
      child: BlocBuilder<GameBloc, GameState>(
          builder: (context, state) {
          if(state is GamePlayerState) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
   
                Container(
                      margin: EdgeInsets.only(right: 10.0, bottom: 5.0),
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
        

                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(bottom: 5.0),
                    child: FAProgressBar(
                
                      maxValue: state.userModel.characters[0].hp,
                      currentValue: state.userModel.characters[0].hp,
                      displayText: ' / ${state.userModel.characters[0].hp} HP',
                      progressColor: Color(HexColor.convertHexColor('#A42324')),
                    ),
                  ),
                  
                  FAProgressBar(
               
                  
                      maxValue: state.userModel.characters[0].mana,
                      currentValue: state.userModel.characters[0].mana,
                      displayText: ' / ${state.userModel.characters[0].mana} MANA',
                      progressColor: Color(HexColor.convertHexColor('#106FB5')),
                    ),
                ],),

              ],
            );
          }
          return CircularProgressIndicator();
      }),
    );
  }
}
