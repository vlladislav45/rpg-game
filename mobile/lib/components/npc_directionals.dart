
import 'package:flame/components.dart';
import 'package:rpg_game/components/npc.dart';

class NpcDirectionals {
  late SpriteAnimation _idleRight;
  late SpriteAnimation _hitRight;
  late SpriteAnimation _runningRight;
  late SpriteAnimation _idleDown;
  late SpriteAnimation _hitDown;
  late SpriteAnimation _runningDown;
  late SpriteAnimation _idleLeft;
  late SpriteAnimation _hitLeft;
  late SpriteAnimation _runningLeft;
  late SpriteAnimation _idleUp;
  late SpriteAnimation _hitUp;
  late SpriteAnimation _runningUp;

  NpcDirectionals();

  Future<Map<NpcState, SpriteAnimation>> loadDirectionals() async {
    /// Down direction
    // down idle
    List<Sprite> npcsSprites = [];
    for (int i = 0; i <= 15; i++)
      if(i >= 10) npcsSprites.add(await Sprite.load('sprites/npcs/crusader/idle/crusader_idle_000${i}.png'));
      else npcsSprites.add(await Sprite.load('sprites/npcs/crusader/idle/crusader_idle_0000${i}.png'));
    this._idleDown = SpriteAnimation.spriteList(npcsSprites, stepTime: 0.20);

    return {
      NpcState.idleDown: this._idleDown,
    };
  }

  SpriteAnimation get runningUp => _runningUp;

  SpriteAnimation get hitUp => _hitUp;

  SpriteAnimation get idleUp => _idleUp;

  SpriteAnimation get runningLeft => _runningLeft;

  SpriteAnimation get hitLeft => _hitLeft;

  SpriteAnimation get idleLeft => _idleLeft;

  SpriteAnimation get runningDown => _runningDown;

  SpriteAnimation get hitDown => _hitDown;

  SpriteAnimation get idleDown => _idleDown;

  SpriteAnimation get runningRight => _runningRight;

  SpriteAnimation get hitRight => _hitRight;

  SpriteAnimation get idleRight => _idleRight;
}