
import 'package:bloc/bloc.dart';
import 'package:rpg_game/models/character_model.dart';

import 'character_overlay_state.dart';

class CharacterOverlayCubit extends Cubit<CharacterOverlayState> {
  CharacterOverlayCubit(): super(CharacterOverlayState(CharacterModel()));

  void update(String nickname, int hp, int mana, int level, {required String id}) {
    emit(
      CharacterOverlayState(CharacterModel(
        id: id,
        nickname: nickname,
        hp: hp,
        mana: mana,
        level: level,
      ))
    );
  }
}