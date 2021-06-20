
import 'package:bloc/bloc.dart';

import 'arena_state.dart';

class ArenaCubit extends Cubit<ArenaState> {


  ArenaCubit(): super(ArenaState(0));

  void update(int arenaIndex, ) {
    emit(ArenaState(arenaIndex));
  }
}