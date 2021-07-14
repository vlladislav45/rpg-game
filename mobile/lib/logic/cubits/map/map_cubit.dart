
import 'package:bloc/bloc.dart';

import 'map_state.dart';

class MapCubit extends Cubit<MapState> {
  MapCubit(): super(MapState(0, 0, isArena: false));

  void update(int map, int arena, {required bool isArena}) {
    emit(MapState(
      map,
      arena,
      isArena: isArena,
    ));
  }
}