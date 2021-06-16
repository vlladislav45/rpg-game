import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rpg_game/game.dart';
import 'package:rpg_game/logic/blocs/online/online_bloc.dart';
import 'package:rpg_game/logic/blocs/online/online_state.dart';
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
    return Container(
      padding: EdgeInsets.all(10.0),
      alignment: Alignment.topLeft,
      decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Colors.black45,
              Colors.black87,
            ],

          )
      ),
      width: MediaQuery.of(context).size.width / 5,
      height: MediaQuery.of(context).size.width / 12,
      child: BlocBuilder<OnlineBloc, OnlineState>(builder: (context, state) {
        if(state is OnlineAuthenticatedState) {
          return Column(
            children: <Widget>[
              Container(
                  width: double.infinity,
                  child: Row(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(right: 10.0, bottom: 5.0),
                        child: AutoSizeText(
                            'Lv. ${state.userViewModel.characters[0].level}',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),

                      Container(
                        child: AutoSizeText(
                            '${state.userViewModel.username}',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                        ),
                      ),

                    ],
                  )),
              Container(
                margin: EdgeInsets.only(bottom: 5.0),
                child: FAProgressBar(
                  maxValue: state.userViewModel.characters[0].hp,
                  currentValue: state.userViewModel.characters[0].hp,
                  displayText: '${state.userViewModel.characters[0].hp} / ',
                  progressColor: Color(HexColor.convertHexColor('#A42324')),
                ),
              ),
              FAProgressBar(
                maxValue: state.userViewModel.characters[0].mana,
                currentValue: state.userViewModel.characters[0].mana,
                displayText: '${state.userViewModel.characters[0].mana} / ',
                progressColor: Color(HexColor.convertHexColor('#106FB5')),
              ),
            ],
          );
        }
        return CircularProgressIndicator();
      }),
    );
  }
}
