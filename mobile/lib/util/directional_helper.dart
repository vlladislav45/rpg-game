
enum StateAction {
  Idle,
  Attack,
  Move
}

enum NpcState {
  idleRight,
  hitRight,
  runRight,
  idleDown,
  hitDown,
  runDown,
  idleLeft,
  hitLeft,
  runLeft,
  idleTop,
  hitTop,
  runTop,
  idleBottomRight,
  hitBottomRight,
  runBottomRight,
  idleBottomLeft,
  hitBottomLeft,
  runBottomLeft,
  idleTopLeft,
  hitTopLeft,
  runTopLeft,
  idleTopRight,
  hitTopRight,
  runTopRight,
}

class DirectionalHelper {
  DirectionalHelper();

  static NpcState? getDirectionalSpriteAnimation(String direction, StateAction action) {
    switch(direction) {
      case 'north': {
        if(action == StateAction.Idle) return NpcState.idleTop;
        else if(action == StateAction.Attack) return NpcState.hitTop;
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
        if(action == StateAction.Idle) return NpcState.idleTopRight;
        else if(action == StateAction.Attack) return NpcState.hitTopRight;
      }break;
      case 'north-west': {
        if(action == StateAction.Idle) return NpcState.idleTopLeft;
        else if(action == StateAction.Attack) return NpcState.hitTopLeft;
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
