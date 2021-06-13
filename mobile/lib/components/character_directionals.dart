
import 'package:flame/components.dart';

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
  late SpriteAnimation _idleBottomRight;
  late SpriteAnimation _hitBottomRight;
  late SpriteAnimation _runningBottomRight;
  late SpriteAnimation _idleBottomLeft;
  late SpriteAnimation _hitBottomLeft;
  late SpriteAnimation _runningBottomLeft;
  late SpriteAnimation _idleUpperLeft;
  late SpriteAnimation _hitUpperLeft;
  late SpriteAnimation _runningUpperLeft;
  late SpriteAnimation _idleUpperRight;
  late SpriteAnimation _hitUpperRight;
  late SpriteAnimation _runningUpperRight;

  CharacterDirectionals();

  Future<void> loadDirectionals() async {
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
    for (int i = 12; i <= lengthOfIdleSprites; i += 4)
      characterSprites.add(await Sprite.load(
          'sprites/characters/knights/seq_antlerKnight/A_right00${i}.png'));
    this._idleRight = SpriteAnimation.spriteList(characterSprites, stepTime: 0.20);

    // right attack1
    characterSprites = [];
    for (int i = 88; i < lengthOfAttack1Sprites; i += 4)
      if (i >= 100)
        characterSprites.add(await Sprite.load(
            'sprites/characters/knights/seq_antlerKnight/A_right0${i}.png'));
      else
        characterSprites.add(await Sprite.load(
            'sprites/characters/knights/seq_antlerKnight/A_right00${i}.png'));
    this._hitRight = SpriteAnimation.spriteList(characterSprites, stepTime: 0.20);

    // right running
    characterSprites = [];
    for (int i = 220; i < lengthOfRunSprites; i += 4)
      characterSprites.add(await Sprite.load(
          'sprites/characters/knights/seq_antlerKnight/A_right0${i}.png'));
    this._runningRight = SpriteAnimation.spriteList(characterSprites, stepTime: 0.10);

    /// Bottom right direction
    // idle
    characterSprites = [];
    for (int i = 12; i <= lengthOfIdleSprites; i += 4)
      characterSprites.add(await Sprite.load(
          'sprites/characters/knights/seq_antlerKnight/B_F_right00${i}.png'));
    this._idleBottomRight = SpriteAnimation.spriteList(characterSprites, stepTime: 0.20);

    // attack1
    characterSprites = [];
    for (int i = 88; i < lengthOfAttack1Sprites; i += 4)
      if (i >= 100)
        characterSprites.add(await Sprite.load(
            'sprites/characters/knights/seq_antlerKnight/B_F_right0${i}.png'));
      else
        characterSprites.add(await Sprite.load(
            'sprites/characters/knights/seq_antlerKnight/B_F_right00${i}.png'));
    this._hitBottomRight = SpriteAnimation.spriteList(characterSprites, stepTime: 0.20);

    // running
    characterSprites = [];
    for (int i = 220; i < lengthOfRunSprites; i += 4)
      characterSprites.add(await Sprite.load(
          'sprites/characters/knights/seq_antlerKnight/B_F_right0${i}.png'));
    this._runningBottomRight = SpriteAnimation.spriteList(characterSprites, stepTime: 0.10);

    /// Down direction
    // Idle
    characterSprites = [];
    for (int i = 12; i < lengthOfIdleSprites; i += 4)
      characterSprites.add(await Sprite.load(
          'sprites/characters/knights/seq_antlerKnight/C_Front00${i}.png'));
    this._idleDown = SpriteAnimation.spriteList(characterSprites, stepTime: 0.20);

    // Hit
    characterSprites = [];
    for (int i = 88; i < lengthOfAttack1Sprites; i += 4)
      if (i >= 100)
        characterSprites.add(await Sprite.load(
            'sprites/characters/knights/seq_antlerKnight/C_Front0${i}.png'));
      else
        characterSprites.add(await Sprite.load(
            'sprites/characters/knights/seq_antlerKnight/C_Front00${i}.png'));
    this._hitDown = SpriteAnimation.spriteList(characterSprites, stepTime: 0.20);

    // Running
    characterSprites = [];
    for (int i = 220; i < lengthOfRunSprites; i += 4)
      characterSprites.add(await Sprite.load(
          'sprites/characters/knights/seq_antlerKnight/C_Front0${i}.png'));
    this._runningDown = SpriteAnimation.spriteList(characterSprites, stepTime: 0.10);

    /// Bottom left direction
    // Idle
    characterSprites = [];
    for (int i = 12; i < lengthOfIdleSprites; i += 4)
      characterSprites.add(await Sprite.load(
          'sprites/characters/knights/seq_antlerKnight/D_FrontLeft00${i}.png'));
    this._idleBottomLeft = SpriteAnimation.spriteList(characterSprites, stepTime: 0.20);

    // Hit
    characterSprites = [];
    for (int i = 88; i < lengthOfAttack1Sprites; i += 4)
      if (i >= 100)
        characterSprites.add(await Sprite.load(
            'sprites/characters/knights/seq_antlerKnight/D_FrontLeft0${i}.png'));
      else
        characterSprites.add(await Sprite.load(
            'sprites/characters/knights/seq_antlerKnight/D_FrontLeft00${i}.png'));
    this._hitBottomLeft = SpriteAnimation.spriteList(characterSprites, stepTime: 0.20);

    // Running
    characterSprites = [];
    for (int i = 220; i < lengthOfRunSprites; i += 4)
      characterSprites.add(await Sprite.load(
          'sprites/characters/knights/seq_antlerKnight/D_FrontLeft0${i}.png'));
    this._runningBottomLeft = SpriteAnimation.spriteList(characterSprites, stepTime: 0.10);

    /// Left direction
    // Idle
    characterSprites = [];
    for (int i = 12; i < lengthOfIdleSprites; i += 4)
      characterSprites.add(await Sprite.load(
          'sprites/characters/knights/seq_antlerKnight/E_Left00${i}.png'));
    this._idleLeft = SpriteAnimation.spriteList(characterSprites, stepTime: 0.20);

    // Attack1
    characterSprites = [];
    for (int i = 88; i < lengthOfAttack1Sprites; i += 4)
      if (i >= 100)
        characterSprites.add(await Sprite.load(
            'sprites/characters/knights/seq_antlerKnight/E_Left0${i}.png'));
      else
        characterSprites.add(await Sprite.load(
            'sprites/characters/knights/seq_antlerKnight/E_Left00${i}.png'));
    this._hitLeft = SpriteAnimation.spriteList(characterSprites, stepTime: 0.20);

    // Running
    characterSprites = [];
    for (int i = 220; i < lengthOfRunSprites; i += 4)
      characterSprites.add(await Sprite.load(
          'sprites/characters/knights/seq_antlerKnight/E_Left0${i}.png'));
    this._runningLeft = SpriteAnimation.spriteList(characterSprites, stepTime: 0.10);

    /// Upper left direction
    // Idle
    characterSprites = [];
    for (int i = 12; i < lengthOfIdleSprites; i += 4)
      characterSprites.add(await Sprite.load(
          'sprites/characters/knights/seq_antlerKnight/F_BackLeft00${i}.png'));
    this._idleUpperLeft = SpriteAnimation.spriteList(characterSprites, stepTime: 0.20);

    // Attack1
    characterSprites = [];
    for (int i = 88; i < lengthOfAttack1Sprites; i += 4)
      if (i >= 100)
        characterSprites.add(await Sprite.load(
            'sprites/characters/knights/seq_antlerKnight/F_BackLeft0${i}.png'));
      else
        characterSprites.add(await Sprite.load(
            'sprites/characters/knights/seq_antlerKnight/F_BackLeft00${i}.png'));
    this._hitUpperLeft = SpriteAnimation.spriteList(characterSprites, stepTime: 0.20);

    // Running
    characterSprites = [];
    for (int i = 220; i < lengthOfRunSprites; i += 4)
      characterSprites.add(await Sprite.load(
          'sprites/characters/knights/seq_antlerKnight/F_BackLeft0${i}.png'));
    this._runningUpperLeft = SpriteAnimation.spriteList(characterSprites, stepTime: 0.10);

    /// Upper direction
    // Idle
    characterSprites = [];
    for (int i = 12; i < lengthOfIdleSprites; i += 4)
      characterSprites.add(await Sprite.load(
          'sprites/characters/knights/seq_antlerKnight/G_Back00${i}.png'));
    this._idleUp = SpriteAnimation.spriteList(characterSprites, stepTime: 0.20);

    // Attack1
    characterSprites = [];
    for (int i = 88; i < lengthOfAttack1Sprites; i += 4)
      if (i >= 100)
        characterSprites.add(await Sprite.load(
            'sprites/characters/knights/seq_antlerKnight/G_Back0${i}.png'));
      else
        characterSprites.add(await Sprite.load(
            'sprites/characters/knights/seq_antlerKnight/G_Back00${i}.png'));
    this._hitUp = SpriteAnimation.spriteList(characterSprites, stepTime: 0.20);

    // Running
    characterSprites = [];
    for (int i = 220; i < lengthOfRunSprites; i += 4)
      characterSprites.add(await Sprite.load(
          'sprites/characters/knights/seq_antlerKnight/G_Back0${i}.png'));
    this._runningUp = SpriteAnimation.spriteList(characterSprites, stepTime: 0.10);

    /// Upper right direction
    // Idle
    characterSprites = [];
    for (int i = 12; i < lengthOfIdleSprites; i += 4)
      characterSprites.add(await Sprite.load(
          'sprites/characters/knights/seq_antlerKnight/H_BackRight00${i}.png'));
    this._idleUpperRight = SpriteAnimation.spriteList(characterSprites, stepTime: 0.20);

    // Attack1
    characterSprites = [];
    for (int i = 88; i < lengthOfAttack1Sprites; i += 4)
      if (i >= 100)
        characterSprites.add(await Sprite.load(
            'sprites/characters/knights/seq_antlerKnight/H_BackRight0${i}.png'));
      else
        characterSprites.add(await Sprite.load(
            'sprites/characters/knights/seq_antlerKnight/H_BackRight00${i}.png'));
    this._hitUpperRight = SpriteAnimation.spriteList(characterSprites, stepTime: 0.20);

    // Running
    characterSprites = [];
    for (int i = 220; i < lengthOfRunSprites; i += 4)
      characterSprites.add(await Sprite.load(
          'sprites/characters/knights/seq_antlerKnight/H_BackRight0${i}.png'));
    this._runningUpperRight = SpriteAnimation.spriteList(characterSprites, stepTime: 0.10);
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

  SpriteAnimation get runningUpperRight => _runningUpperRight;

  SpriteAnimation get hitUpperRight => _hitUpperRight;

  SpriteAnimation get idleUpperRight => _idleUpperRight;

  SpriteAnimation get runningUpperLeft => _runningUpperLeft;

  SpriteAnimation get hitUpperLeft => _hitUpperLeft;

  SpriteAnimation get idleUpperLeft => _idleUpperLeft;

  SpriteAnimation get runningBottomLeft => _runningBottomLeft;

  SpriteAnimation get hitBottomLeft => _hitBottomLeft;

  SpriteAnimation get idleBottomLeft => _idleBottomLeft;

  SpriteAnimation get runningBottomRight => _runningBottomRight;

  SpriteAnimation get hitBottomRight => _hitBottomRight;

  SpriteAnimation get idleBottomRight => _idleBottomRight;
}