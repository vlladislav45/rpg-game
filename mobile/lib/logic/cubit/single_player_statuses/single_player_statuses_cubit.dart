
import 'package:bloc/bloc.dart';
import 'package:rpg_game/logic/cubit/single_player_statuses/single_player_statuses_state.dart';

class SinglePlayerStatusesCubit extends Cubit<SinglePlayerStatusesState> {
  SinglePlayerStatusesCubit(): super(SinglePlayerStatusesState(0));

  void update(int hp) {
    emit(SinglePlayerStatusesState(
     hp
    ));
  }
}
