import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rpg_game/game.dart';
import 'package:rpg_game/logic/blocs/online/online_bloc.dart';
import 'package:rpg_game/logic/blocs/online/online_state.dart';
import 'package:rpg_game/models/views/user_view_model.dart';
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
            begin: Alignment.centerRight,
            end: Alignment.centerLeft,
            colors: [
              Colors.black.withOpacity(0.60),
              Colors.black.withOpacity(0.75),
            ],

          )
      ),
      width: MediaQuery.of(context).size.width / 5,
      height: MediaQuery.of(context).size.width / 12,
      child: BlocBuilder<OnlineBloc, OnlineState>(builder: (context, state) {
        print(state);
          UserViewModel userViewModel = state.props[0] as UserViewModel;
          return Column(
            children: <Widget>[
              Container(
                  width: double.infinity,
                  child: Row(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(right: 10.0, bottom: 5.0),
                        child: AutoSizeText(
                            'Lv. ${userViewModel.characters[0].level}',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),

                      Container(
                        child: AutoSizeText(
                            '${userViewModel.username}',
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
                  maxValue: userViewModel.characters[0].hp,
                  currentValue: userViewModel.characters[0].hp,
                  displayText: '${userViewModel.characters[0].hp} / ',
                  progressColor: Color(HexColor.convertHexColor('#A42324')),
                ),
              ),
              FAProgressBar(
                maxValue: userViewModel.characters[0].mana,
                currentValue: userViewModel.characters[0].mana,
                displayText: '${userViewModel.characters[0].mana} / ',
                progressColor: Color(HexColor.convertHexColor('#106FB5')),
              ),
            ],
          );
      }),
    );
  }
}
