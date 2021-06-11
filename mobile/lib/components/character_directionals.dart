
import 'package:flame/components.dart';
import 'package:rpg_game/components/character.dart';

class CharacterDirectionals {
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

  CharacterDirectionals();

  Future<Map<CharacterState, SpriteAnimation>> loadDirectionals() async {
    int lengthOfIdleSprites = 80; // 10 - 80
    int lengthOfAttack1Sprites = 120; // 88 - 120
    int lengthOfWalkSprites = 200; // 140 - 200
    int lengthOfRunSprites = 264; // 220 - 264
    int lengthOfIdle2Sprites =
    320; // 268 - 320 When the character is heated or he is hitting
    int lengthOfAttack2Sprites = 400; // 328 - 400
    /// Right direction
    // right idle
    List<Sprite> characterSprites = [];
    for (var i = 12; i <= lengthOfIdleSprites; i += 4)
      characterSprites.add(await Sprite.load(
          'sprites/characters/knights/seq_antlerKnight/A_right00${i}.png'));
    this._idleRight = SpriteAnimation.spriteList(characterSprites, stepTime: 0.20);

    // right attack1
    characterSprites = [];
    for (var i = 88; i < lengthOfAttack1Sprites; i += 4)
      if (i >= 100)
        characterSprites.add(await Sprite.load(
            'sprites/characters/knights/seq_antlerKnight/A_right0${i}.png'));
      else
        characterSprites.add(await Sprite.load(
            'sprites/characters/knights/seq_antlerKnight/A_right00${i}.png'));
    this._hitRight = SpriteAnimation.spriteList(characterSprites, stepTime: 0.20);

    // right running
    characterSprites = [];
    for (var i = 220; i < lengthOfRunSprites; i += 4)
      characterSprites.add(await Sprite.load(
          'sprites/characters/knights/seq_antlerKnight/A_right0${i}.png'));
    this._runningRight = SpriteAnimation.spriteList(characterSprites, stepTime: 0.10);

    /// Down direction
    // Idle down
    characterSprites = [];
    for (var i = 12; i < lengthOfIdleSprites; i += 4)
      characterSprites.add(await Sprite.load(
          'sprites/characters/knights/seq_antlerKnight/C_Front00${i}.png'));
    this._idleDown = SpriteAnimation.spriteList(characterSprites, stepTime: 0.20);

    // Hit down
    characterSprites = [];
    for (var i = 88; i < lengthOfAttack1Sprites; i += 4)
      if (i >= 100)
        characterSprites.add(await Sprite.load(
            'sprites/characters/knights/seq_antlerKnight/C_Front0${i}.png'));
      else
        characterSprites.add(await Sprite.load(
            'sprites/characters/knights/seq_antlerKnight/C_Front00${i}.png'));
    this._hitDown = SpriteAnimation.spriteList(characterSprites, stepTime: 0.20);

    // Running down
    characterSprites = [];
    for (var i = 220; i < lengthOfRunSprites; i += 4)
      characterSprites.add(await Sprite.load(
          'sprites/characters/knights/seq_antlerKnight/C_Front0${i}.png'));
    this._runningDown = SpriteAnimation.spriteList(characterSprites, stepTime: 0.10);

    /// Left direction
    // Idle left
    characterSprites = [];
    for (var i = 12; i < lengthOfIdleSprites; i += 4)
      characterSprites.add(await Sprite.load(
          'sprites/characters/knights/seq_antlerKnight/E_Left00${i}.png'));
    this._idleLeft = SpriteAnimation.spriteList(characterSprites, stepTime: 0.20);

    // Hit left
    characterSprites = [];
    for (var i = 88; i < lengthOfAttack1Sprites; i += 4)
      if (i >= 100)
        characterSprites.add(await Sprite.load(
            'sprites/characters/knights/seq_antlerKnight/E_Left0${i}.png'));
      else
        characterSprites.add(await Sprite.load(
            'sprites/characters/knights/seq_antlerKnight/E_Left00${i}.png'));
    this._hitLeft = SpriteAnimation.spriteList(characterSprites, stepTime: 0.20);

    // Running left
    characterSprites = [];
    for (var i = 220; i < lengthOfRunSprites; i += 4)
      characterSprites.add(await Sprite.load(
          'sprites/characters/knights/seq_antlerKnight/E_Left0${i}.png'));
    this._runningLeft = SpriteAnimation.spriteList(characterSprites, stepTime: 0.10);

    /// Up direction
    // Idle up
    characterSprites = [];
    for (var i = 12; i < lengthOfIdleSprites; i += 4)
      characterSprites.add(await Sprite.load(
          'sprites/characters/knights/seq_antlerKnight/G_Back00${i}.png'));
    this._idleUp = SpriteAnimation.spriteList(characterSprites, stepTime: 0.20);

    // Hit left
    characterSprites = [];
    for (var i = 88; i < lengthOfAttack1Sprites; i += 4)
      if (i >= 100)
        characterSprites.add(await Sprite.load(
            'sprites/characters/knights/seq_antlerKnight/G_Back0${i}.png'));
      else
        characterSprites.add(await Sprite.load(
            'sprites/characters/knights/seq_antlerKnight/G_Back00${i}.png'));
    this._hitUp = SpriteAnimation.spriteList(characterSprites, stepTime: 0.20);

    // Running left
    characterSprites = [];
    for (var i = 220; i < lengthOfRunSprites; i += 4)
      characterSprites.add(await Sprite.load(
          'sprites/characters/knights/seq_antlerKnight/G_Back0${i}.png'));
    this._runningUp = SpriteAnimation.spriteList(characterSprites, stepTime: 0.10);

    return {
      CharacterState.idleRight: this._idleRight,
      CharacterState.hitRight: this._hitRight,
      CharacterState.runningRight: this._runningRight,
      CharacterState.idleDown:this._idleDown,
      CharacterState.hitDown: this._hitDown,
      CharacterState.runningDown: this._runningDown,
      CharacterState.idleLeft: this._idleLeft,
      CharacterState.hitLeft: this._hitLeft,
      CharacterState.runningLeft: this._runningLeft,
      CharacterState.idleUp: this._idleUp,
      CharacterState.hitUp: this._hitUp,
      CharacterState.runningUp: this._runningUp,
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