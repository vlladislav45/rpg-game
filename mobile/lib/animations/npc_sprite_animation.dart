
import 'package:flame/components.dart';

import 'sprite_animation_action.dart';

class NpcSpriteAnimation extends SpriteAnimationAction {
  /// Right direction
  late SpriteAnimation _idleRight;
  late SpriteAnimation _hitRight;
  late SpriteAnimation _runRight;
  late SpriteAnimation _deathRight;

  /// Bottom Right direction
  late SpriteAnimation _idleBottomRight;
  late SpriteAnimation _hitBottomRight;
  late SpriteAnimation _runBottomRight;
  late SpriteAnimation _deathBottomRight;

  /// Down direction
  late SpriteAnimation _idleDown;
  late SpriteAnimation _hitDown;
  late SpriteAnimation _runDown;
  late SpriteAnimation _deathDown;

  /// Bottom left direction
  late SpriteAnimation _idleBottomLeft;
  late SpriteAnimation _hitBottomLeft;
  late SpriteAnimation _runBottomLeft;
  late SpriteAnimation _deathBottomLeft;

  /// Left direction
  late SpriteAnimation _idleLeft;
  late SpriteAnimation _hitLeft;
  late SpriteAnimation _runLeft;
  late SpriteAnimation _deathLeft;

  /// Top Left direction
  late SpriteAnimation _idleTopLeft;
  late SpriteAnimation _hitTopLeft;
  late SpriteAnimation _runTopLeft;
  late SpriteAnimation _deathTopLeft;

  /// Top direction
  late SpriteAnimation _idleTop;
  late SpriteAnimation _hitTop;
  late SpriteAnimation _runTop;
  late SpriteAnimation _deathTop;

  /// Top Right direction
  late SpriteAnimation _idleTopRight;
  late SpriteAnimation _hitTopRight;
  late SpriteAnimation _runTopRight;
  late SpriteAnimation _deathTopRight;

  static const int _lengthOfIdleSprites = 15; // 0 - 15
  static const int _lengthOfAttack1Sprites = 17; // 0 - 17
  static const int _lengthOfRunSprites = 16; // 0 - 16
  static const int _lengthOfDeathSprites = 8; // 0 - 8

  NpcSpriteAnimation();

  SpriteAnimation get idleRight => _idleRight; //Getters

  @override
  Future<void> loadSpriteAnimations() async {
    /// Down direction
    // idle
    List<Sprite> npcSprites = [];
    for (int i = 0; i <= _lengthOfIdleSprites; i++)
      if(i >= 10) npcSprites.add(await Sprite.load('sprites/npcs/crusader/idle/crusader_idle_000${i}.png'));
      else npcSprites.add(await Sprite.load('sprites/npcs/crusader/idle/crusader_idle_0000${i}.png'));
    this._idleDown = SpriteAnimation.spriteList(npcSprites, stepTime: 0.20);

    // hit
    npcSprites = [];
    for (int i = 0; i <= _lengthOfAttack1Sprites; i++)
      if(i >= 10) npcSprites.add(await Sprite.load('sprites/npcs/crusader/attack/crusader_attack_000${i}.png'));
      else npcSprites.add(await Sprite.load('sprites/npcs/crusader/attack/crusader_attack_0000${i}.png'));
    this._hitDown = SpriteAnimation.spriteList(npcSprites, stepTime: 0.20);

    // run
    npcSprites = [];
    for (int i = 0; i <= _lengthOfRunSprites; i++)
      if(i >= 10) npcSprites.add(await Sprite.load('sprites/npcs/crusader/run/crusader_run_000${i}.png'));
      else npcSprites.add(await Sprite.load('sprites/npcs/crusader/run/crusader_run_0000${i}.png'));
    this._runDown = SpriteAnimation.spriteList(npcSprites, stepTime: 0.20);

    // death
    npcSprites = [];
    for (int i = 0; i <= _lengthOfDeathSprites; i++)
      if(i >= 10) npcSprites.add(await Sprite.load('sprites/npcs/crusader/death/crusader_death_000${i}.png'));
      else npcSprites.add(await Sprite.load('sprites/npcs/crusader/death/crusader_death_0000${i}.png'));
    this._deathDown = SpriteAnimation.spriteList(npcSprites, stepTime: 0.20);

    /// Bottom right direction
    // idle
    npcSprites = [];
    for (int i = 0; i <= _lengthOfIdleSprites; i++)
      if(i >= 10) npcSprites.add(await Sprite.load('sprites/npcs/crusader/idle/crusader_idle_100${i}.png'));
      else npcSprites.add(await Sprite.load('sprites/npcs/crusader/idle/crusader_idle_1000${i}.png'));
    this._idleBottomRight = SpriteAnimation.spriteList(npcSprites, stepTime: 0.20);

    // hit
    npcSprites = [];
    for (int i = 0; i <= _lengthOfAttack1Sprites; i++)
      if(i >= 10) npcSprites.add(await Sprite.load('sprites/npcs/crusader/attack/crusader_attack_100${i}.png'));
      else npcSprites.add(await Sprite.load('sprites/npcs/crusader/attack/crusader_attack_1000${i}.png'));
    this._hitBottomRight = SpriteAnimation.spriteList(npcSprites, stepTime: 0.20);

    // run
    npcSprites = [];
    for (int i = 0; i <= _lengthOfRunSprites; i++)
      if(i >= 10) npcSprites.add(await Sprite.load('sprites/npcs/crusader/run/crusader_run_100${i}.png'));
      else npcSprites.add(await Sprite.load('sprites/npcs/crusader/run/crusader_run_1000${i}.png'));
    this._runBottomRight = SpriteAnimation.spriteList(npcSprites, stepTime: 0.20);

    // death
    npcSprites = [];
    for (int i = 0; i <= _lengthOfDeathSprites; i++)
      if(i >= 10) npcSprites.add(await Sprite.load('sprites/npcs/crusader/death/crusader_death_100${i}.png'));
      else npcSprites.add(await Sprite.load('sprites/npcs/crusader/death/crusader_death_1000${i}.png'));
    this._deathBottomRight = SpriteAnimation.spriteList(npcSprites, stepTime: 0.20);

    /// Right direction
    // idle
    npcSprites = [];
    for (int i = 0; i <= _lengthOfIdleSprites; i++)
      if(i >= 10) npcSprites.add(await Sprite.load('sprites/npcs/crusader/idle/crusader_idle_200${i}.png'));
      else npcSprites.add(await Sprite.load('sprites/npcs/crusader/idle/crusader_idle_2000${i}.png'));
    this._idleRight = SpriteAnimation.spriteList(npcSprites, stepTime: 0.20);

    // hit
    npcSprites = [];
    for (int i = 0; i <= _lengthOfAttack1Sprites; i++)
      if(i >= 10) npcSprites.add(await Sprite.load('sprites/npcs/crusader/attack/crusader_attack_200${i}.png'));
      else npcSprites.add(await Sprite.load('sprites/npcs/crusader/attack/crusader_attack_2000${i}.png'));
    this._hitRight = SpriteAnimation.spriteList(npcSprites, stepTime: 0.20);

    // run
    npcSprites = [];
    for (int i = 0; i <= _lengthOfRunSprites; i++)
      if(i >= 10) npcSprites.add(await Sprite.load('sprites/npcs/crusader/run/crusader_run_200${i}.png'));
      else npcSprites.add(await Sprite.load('sprites/npcs/crusader/run/crusader_run_2000${i}.png'));
    this._runRight = SpriteAnimation.spriteList(npcSprites, stepTime: 0.20);

    // death
    npcSprites = [];
    for (int i = 0; i <= _lengthOfDeathSprites; i++)
      if(i >= 10) npcSprites.add(await Sprite.load('sprites/npcs/crusader/death/crusader_death_200${i}.png'));
      else npcSprites.add(await Sprite.load('sprites/npcs/crusader/death/crusader_death_2000${i}.png'));
    this._deathRight = SpriteAnimation.spriteList(npcSprites, stepTime: 0.20);

    /// Top Right direction
    // idle
    npcSprites = [];
    for (int i = 0; i <= _lengthOfIdleSprites; i++)
      if(i >= 10) npcSprites.add(await Sprite.load('sprites/npcs/crusader/idle/crusader_idle_300${i}.png'));
      else npcSprites.add(await Sprite.load('sprites/npcs/crusader/idle/crusader_idle_3000${i}.png'));
    this._idleTopRight = SpriteAnimation.spriteList(npcSprites, stepTime: 0.20);

    // hit
    npcSprites = [];
    for (int i = 0; i <= _lengthOfAttack1Sprites; i++)
      if(i >= 10) npcSprites.add(await Sprite.load('sprites/npcs/crusader/attack/crusader_attack_300${i}.png'));
      else npcSprites.add(await Sprite.load('sprites/npcs/crusader/attack/crusader_attack_3000${i}.png'));
    this._hitTopRight = SpriteAnimation.spriteList(npcSprites, stepTime: 0.20);

    // run
    npcSprites = [];
    for (int i = 0; i <= _lengthOfRunSprites; i++)
      if(i >= 10) npcSprites.add(await Sprite.load('sprites/npcs/crusader/run/crusader_run_300${i}.png'));
      else npcSprites.add(await Sprite.load('sprites/npcs/crusader/run/crusader_run_3000${i}.png'));
    this._runTopRight = SpriteAnimation.spriteList(npcSprites, stepTime: 0.20);

    // death
    npcSprites = [];
    for (int i = 0; i <= _lengthOfDeathSprites; i++)
      if(i >= 10) npcSprites.add(await Sprite.load('sprites/npcs/crusader/death/crusader_death_300${i}.png'));
      else npcSprites.add(await Sprite.load('sprites/npcs/crusader/death/crusader_death_3000${i}.png'));
    this._deathTopRight = SpriteAnimation.spriteList(npcSprites, stepTime: 0.20);

    /// Top direction
    // idle
    npcSprites = [];
    for (int i = 0; i <= _lengthOfIdleSprites; i++)
      if(i >= 10) npcSprites.add(await Sprite.load('sprites/npcs/crusader/idle/crusader_idle_400${i}.png'));
      else npcSprites.add(await Sprite.load('sprites/npcs/crusader/idle/crusader_idle_4000${i}.png'));
    this._idleTop = SpriteAnimation.spriteList(npcSprites, stepTime: 0.20);

    // hit
    npcSprites = [];
    for (int i = 0; i <= _lengthOfAttack1Sprites; i++)
      if(i >= 10) npcSprites.add(await Sprite.load('sprites/npcs/crusader/attack/crusader_attack_400${i}.png'));
      else npcSprites.add(await Sprite.load('sprites/npcs/crusader/attack/crusader_attack_4000${i}.png'));
    this._hitTop = SpriteAnimation.spriteList(npcSprites, stepTime: 0.20);

    // run
    npcSprites = [];
    for (int i = 0; i <= _lengthOfRunSprites; i++)
      if(i >= 10) npcSprites.add(await Sprite.load('sprites/npcs/crusader/run/crusader_run_400${i}.png'));
      else npcSprites.add(await Sprite.load('sprites/npcs/crusader/run/crusader_run_4000${i}.png'));
    this._runTop = SpriteAnimation.spriteList(npcSprites, stepTime: 0.20);

    // death
    npcSprites = [];
    for (int i = 0; i <= _lengthOfDeathSprites; i++)
      if(i >= 10) npcSprites.add(await Sprite.load('sprites/npcs/crusader/death/crusader_death_400${i}.png'));
      else npcSprites.add(await Sprite.load('sprites/npcs/crusader/death/crusader_death_4000${i}.png'));
    this._deathTop = SpriteAnimation.spriteList(npcSprites, stepTime: 0.20);

    /// Top Left direction
    // idle
    npcSprites = [];
    for (int i = 0; i <= _lengthOfIdleSprites; i++)
      if(i >= 10) npcSprites.add(await Sprite.load('sprites/npcs/crusader/idle/crusader_idle_500${i}.png'));
      else npcSprites.add(await Sprite.load('sprites/npcs/crusader/idle/crusader_idle_5000${i}.png'));
    this._idleTopLeft = SpriteAnimation.spriteList(npcSprites, stepTime: 0.20);

    // hit
    npcSprites = [];
    for (int i = 0; i <= _lengthOfAttack1Sprites; i++)
      if(i >= 10) npcSprites.add(await Sprite.load('sprites/npcs/crusader/attack/crusader_attack_500${i}.png'));
      else npcSprites.add(await Sprite.load('sprites/npcs/crusader/attack/crusader_attack_5000${i}.png'));
    this._hitTopLeft = SpriteAnimation.spriteList(npcSprites, stepTime: 0.20);

    // run
    npcSprites = [];
    for (int i = 0; i <= _lengthOfRunSprites; i++)
      if(i >= 10) npcSprites.add(await Sprite.load('sprites/npcs/crusader/run/crusader_run_500${i}.png'));
      else npcSprites.add(await Sprite.load('sprites/npcs/crusader/run/crusader_run_5000${i}.png'));
    this._runTopLeft = SpriteAnimation.spriteList(npcSprites, stepTime: 0.20);

    // death
    npcSprites = [];
    for (int i = 0; i <= _lengthOfDeathSprites; i++)
      if(i >= 10) npcSprites.add(await Sprite.load('sprites/npcs/crusader/death/crusader_death_500${i}.png'));
      else npcSprites.add(await Sprite.load('sprites/npcs/crusader/death/crusader_death_5000${i}.png'));
    this._deathTopLeft = SpriteAnimation.spriteList(npcSprites, stepTime: 0.20);

    /// Left direction
    // idle
    npcSprites = [];
    for (int i = 0; i <= _lengthOfIdleSprites; i++)
      if(i >= 10) npcSprites.add(await Sprite.load('sprites/npcs/crusader/idle/crusader_idle_600${i}.png'));
      else npcSprites.add(await Sprite.load('sprites/npcs/crusader/idle/crusader_idle_6000${i}.png'));
    this._idleLeft = SpriteAnimation.spriteList(npcSprites, stepTime: 0.20);

    // hit
    npcSprites = [];
    for (int i = 0; i <= _lengthOfAttack1Sprites; i++)
      if(i >= 10) npcSprites.add(await Sprite.load('sprites/npcs/crusader/attack/crusader_attack_600${i}.png'));
      else npcSprites.add(await Sprite.load('sprites/npcs/crusader/attack/crusader_attack_6000${i}.png'));
    this._hitLeft = SpriteAnimation.spriteList(npcSprites, stepTime: 0.20);

    // run
    npcSprites = [];
    for (int i = 0; i <= _lengthOfRunSprites; i++)
      if(i >= 10) npcSprites.add(await Sprite.load('sprites/npcs/crusader/run/crusader_run_600${i}.png'));
      else npcSprites.add(await Sprite.load('sprites/npcs/crusader/run/crusader_run_6000${i}.png'));
    this._runLeft = SpriteAnimation.spriteList(npcSprites, stepTime: 0.20);

    // death
    npcSprites = [];
    for (int i = 0; i <= _lengthOfDeathSprites; i++)
      if(i >= 10) npcSprites.add(await Sprite.load('sprites/npcs/crusader/death/crusader_death_600${i}.png'));
      else npcSprites.add(await Sprite.load('sprites/npcs/crusader/death/crusader_death_6000${i}.png'));
    this._deathLeft = SpriteAnimation.spriteList(npcSprites, stepTime: 0.20);

    /// Bottom Left direction
    // idle
    npcSprites = [];
    for (int i = 0; i <= _lengthOfIdleSprites; i++)
      if(i >= 10) npcSprites.add(await Sprite.load('sprites/npcs/crusader/idle/crusader_idle_700${i}.png'));
      else npcSprites.add(await Sprite.load('sprites/npcs/crusader/idle/crusader_idle_7000${i}.png'));
    this._idleBottomLeft = SpriteAnimation.spriteList(npcSprites, stepTime: 0.20);

    // hit
    npcSprites = [];
    for (int i = 0; i <= _lengthOfAttack1Sprites; i++)
      if(i >= 10) npcSprites.add(await Sprite.load('sprites/npcs/crusader/attack/crusader_attack_700${i}.png'));
      else npcSprites.add(await Sprite.load('sprites/npcs/crusader/attack/crusader_attack_7000${i}.png'));
    this._hitBottomLeft = SpriteAnimation.spriteList(npcSprites, stepTime: 0.20);

    // run
    npcSprites = [];
    for (int i = 0; i <= _lengthOfRunSprites; i++)
      if(i >= 10) npcSprites.add(await Sprite.load('sprites/npcs/crusader/run/crusader_run_700${i}.png'));
      else npcSprites.add(await Sprite.load('sprites/npcs/crusader/run/crusader_run_7000${i}.png'));
    this._runBottomLeft = SpriteAnimation.spriteList(npcSprites, stepTime: 0.20);

    // death
    npcSprites = [];
    for (int i = 0; i <= _lengthOfDeathSprites; i++)
      if(i >= 10) npcSprites.add(await Sprite.load('sprites/npcs/crusader/death/crusader_death_700${i}.png'));
      else npcSprites.add(await Sprite.load('sprites/npcs/crusader/death/crusader_death_7000${i}.png'));
    this._deathBottomLeft = SpriteAnimation.spriteList(npcSprites, stepTime: 0.20);
  }

  SpriteAnimation get hitRight => _hitRight;

  SpriteAnimation get runRight => _runRight;

  SpriteAnimation get deathRight => _deathRight;

  SpriteAnimation get idleBottomRight => _idleBottomRight;

  SpriteAnimation get hitBottomRight => _hitBottomRight;

  SpriteAnimation get runBottomRight => _runBottomRight;

  SpriteAnimation get deathBottomRight => _deathBottomRight;

  SpriteAnimation get idleDown => _idleDown;

  SpriteAnimation get hitDown => _hitDown;

  SpriteAnimation get runDown => _runDown;

  SpriteAnimation get deathDown => _deathDown;

  SpriteAnimation get idleBottomLeft => _idleBottomLeft;

  SpriteAnimation get hitBottomLeft => _hitBottomLeft;

  SpriteAnimation get runBottomLeft => _runBottomLeft;

  SpriteAnimation get deathBottomLeft => _deathBottomLeft;

  SpriteAnimation get idleLeft => _idleLeft;

  SpriteAnimation get hitLeft => _hitLeft;

  SpriteAnimation get runLeft => _runLeft;

  SpriteAnimation get deathLeft => _deathLeft;

  SpriteAnimation get idleTopLeft => _idleTopLeft;

  SpriteAnimation get hitTopLeft => _hitTopLeft;

  SpriteAnimation get runTopLeft => _runTopLeft;

  SpriteAnimation get deathTopLeft => _deathTopLeft;

  SpriteAnimation get idleTop => _idleTop;

  SpriteAnimation get hitTop => _hitTop;

  SpriteAnimation get runTop => _runTop;

  SpriteAnimation get deathTop => _deathTop;

  SpriteAnimation get idleTopRight => _idleTopRight;

  SpriteAnimation get hitTopRight => _hitTopRight;

  SpriteAnimation get runTopRight => _runTopRight;

  SpriteAnimation get deathTopRight => _deathTopRight;
}