
enum StateAction {
  Idle,
  Attack
}

enum NpcState {
  idleRight,
  hitRight,
  runningRight,
  idleDown,
  hitDown,
  runningDown,
  idleLeft,
  hitLeft,
  runningLeft,
  idleUp,
  hitUp,
  runningUp,
  idleBottomRight,
  hitBottomRight,
  runningBottomRight,
  idleBottomLeft,
  hitBottomLeft,
  runningBottomLeft,
  idleUpperLeft,
  hitUpperLeft,
  runningUpperLeft,
  idleUpperRight,
  hitUpperRight,
  runningUpperRight,
}

class DirectionalHelper {
  DirectionalHelper();

  static NpcState? getDirectionalSpriteAnimation(String direction, StateAction action) {
    switch(direction) {
      case 'north': {
        if(action == StateAction.Idle) return NpcState.idleUp;
        else if(action == StateAction.Attack) return NpcState.hitUp;
      }break;
      case 'south': {
        if(action == StateAction.Idle) return NpcState.idleDown;
        else if(action == StateAction.Attack) return NpcState.hitDown;
      }break;
      case 'west': {
        if(action == StateAction.Idle) return NpcState.idleLeft;
        else if(action == StateAction.Attack) return NpcState.hitLeft;
      }break;
      case 'east': {
        if(action == StateAction.Idle) return NpcState.idleRight;
        else if(action == StateAction.Attack) return NpcState.hitRight;
      }break;
      case 'north-east': {
        if(action == StateAction.Idle) return NpcState.idleUpperRight;
        else if(action == StateAction.Attack) return NpcState.hitUpperRight;
      }break;
      case 'north-west': {
        if(action == StateAction.Idle) return NpcState.idleUpperLeft;
        else if(action == StateAction.Attack) return NpcState.hitUpperLeft;
      }break;
      case 'south-east': {
        if(action == StateAction.Idle) return NpcState.idleBottomRight;
        else if(action == StateAction.Attack) return NpcState.hitBottomRight;
      }break;
      case 'south-west': {
        if(action == StateAction.Idle) return NpcState.idleBottomLeft;
        else if(action == StateAction.Attack) return NpcState.hitBottomLeft;
      }break;
      default: return null;
    }
  }
}