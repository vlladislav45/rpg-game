
import 'package:bloc/bloc.dart';
import 'package:rpg_game/logic/cubits/states/map_level_state.dart';

class MapLevelCubit extends Cubit<MapLevelState> {

  MapLevelCubit(): super(MapLevelState(null));

  void changeMapLevel(int mapLevel) {
    emit(MapLevelState(mapLevel));
  }
}