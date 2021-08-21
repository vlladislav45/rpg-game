
import 'package:bloc/bloc.dart';

import 'map_state.dart';

class MapCubit extends Cubit<MapState> {
  MapCubit(): super(MapState(''));

  void update(String map) {
    emit(MapState(
      map
    ));
  }
}
