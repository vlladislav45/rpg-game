
import 'package:flame/components.dart';
import 'sprite_animation_action.dart';

class CharacterSpriteAnimation extends SpriteAnimationAction {
  /// Right direction
  late SpriteAnimation _idleRight;
  late SpriteAnimation _hitRight;
  late SpriteAnimation _runRight;

  /// Down direction
  late SpriteAnimation _idleDown;
  late SpriteAnimation _hitDown;
  late SpriteAnimation _runDown;

  /// Left direction
  late SpriteAnimation _idleLeft;
  late SpriteAnimation _hitLeft;
  late SpriteAnimation _runLeft;

  /// Top direction
  late SpriteAnimation _idleTop;
  late SpriteAnimation _hitTop;
  late SpriteAnimation _runTop;

  /// Bottom Right direction
  late SpriteAnimation _idleBottomRight;
  late SpriteAnimation _hitBottomRight;
  late SpriteAnimation _runBottomRight;

  /// Bottom Left direction
  late SpriteAnimation _idleBottomLeft;
  late SpriteAnimation _hitBottomLeft;
  late SpriteAnimation _runBottomLeft;

  /// Top Left direction
  late SpriteAnimation _idleTopLeft;
  late SpriteAnimation _hitTopLeft;
  late SpriteAnimation _runTopLeft;

  /// Top Right direction
  late SpriteAnimation _idleTopRight;
  late SpriteAnimation _hitTopRight;
  late SpriteAnimation _runTopRight;

  /// Length of sprite direction animations
  static const int _lengthOfIdleSprites = 80; // 10 - 80
  static const int _lengthOfAttack1Sprites = 120; // 88 - 120
  static const int _lengthOfWalkSprites = 200; // 140 - 200
  static const int _lengthOfRunSprites = 264; // 220 - 264
  static const int _lengthOfIdle2Sprites = 320; // 268 - 320 When the character is heated or he is hitting
  static const int _lengthOfAttack2Sprites = 400; // 328 - 400

  CharacterSpriteAnimation();

  @override
  Future<void> loadSpriteAnimations() async {
    /// Right direction
    // idle
    List<Sprite> characterSprites = [];
    for (int i = 12; i <= _lengthOfIdleSprites; i += 4)
      characterSprites.add(await Sprite.load(
          'sprites/characters/knights/seq_antlerKnight/A_right00${i}.png'));
    this._idleRight = SpriteAnimation.spriteList(characterSprites, stepTime: 0.20);

    // attack1
    characterSprites = [];
    for (int i = 88; i < _lengthOfAttack1Sprites; i += 4)
      if (i >= 100)
        characterSprites.add(await Sprite.load(
            'sprites/characters/knights/seq_antlerKnight/A_right0${i}.png'));
      else
        characterSprites.add(await Sprite.load(
            'sprites/characters/knights/seq_antlerKnight/A_right00${i}.png'));
    this._hitRight = SpriteAnimation.spriteList(characterSprites, stepTime: 0.20);

    // running
    characterSprites = [];
    for (int i = 220; i < _lengthOfRunSprites; i += 4)
      characterSprites.add(await Sprite.load(
          'sprites/characters/knights/seq_antlerKnight/A_right0${i}.png'));
    this._runRight = SpriteAnimation.spriteList(characterSprites, stepTime: 0.10);

    /// Bottom right direction
    // Idle
    characterSprites = [];
    for (int i = 12; i <= _lengthOfIdleSprites; i += 4)
      characterSprites.add(await Sprite.load(
          'sprites/characters/knights/seq_antlerKnight/B_F_right00${i}.png'));
    this._idleBottomRight = SpriteAnimation.spriteList(characterSprites, stepTime: 0.20);

    // Attack1
    characterSprites = [];
    for (int i = 88; i < _lengthOfAttack1Sprites; i += 4)
      if (i >= 100)
        characterSprites.add(await Sprite.load(
            'sprites/characters/knights/seq_antlerKnight/B_F_right0${i}.png'));
      else
        characterSprites.add(await Sprite.load(
            'sprites/characters/knights/seq_antlerKnight/B_F_right00${i}.png'));
    this._hitBottomRight = SpriteAnimation.spriteList(characterSprites, stepTime: 0.20);

    // Run
    characterSprites = [];
    for (int i = 220; i < _lengthOfRunSprites; i += 4)
      characterSprites.add(await Sprite.load(
          'sprites/characters/knights/seq_antlerKnight/B_F_right0${i}.png'));
    this._runBottomRight = SpriteAnimation.spriteList(characterSprites, stepTime: 0.10);

    /// Down direction
    // Idle
    characterSprites = [];
    for (int i = 12; i < _lengthOfIdleSprites; i += 4)
      characterSprites.add(await Sprite.load(
          'sprites/characters/knights/seq_antlerKnight/C_Front00${i}.png'));
    this._idleDown = SpriteAnimation.spriteList(characterSprites, stepTime: 0.20);

    // Attack1
    characterSprites = [];
    for (int i = 88; i < _lengthOfAttack1Sprites; i += 4)
      if (i >= 100)
        characterSprites.add(await Sprite.load(
            'sprites/characters/knights/seq_antlerKnight/C_Front0${i}.png'));
      else
        characterSprites.add(await Sprite.load(
            'sprites/characters/knights/seq_antlerKnight/C_Front00${i}.png'));
    this._hitDown = SpriteAnimation.spriteList(characterSprites, stepTime: 0.20);

    // Run
    characterSprites = [];
    for (int i = 220; i < _lengthOfRunSprites; i += 4)
      characterSprites.add(await Sprite.load(
          'sprites/characters/knights/seq_antlerKnight/C_Front0${i}.png'));
    this._runDown = SpriteAnimation.spriteList(characterSprites, stepTime: 0.10);

    /// Bottom left direction
    // Idle
    characterSprites = [];
    for (int i = 12; i < _lengthOfIdleSprites; i += 4)
      characterSprites.add(await Sprite.load(
          'sprites/characters/knights/seq_antlerKnight/D_FrontLeft00${i}.png'));
    this._idleBottomLeft = SpriteAnimation.spriteList(characterSprites, stepTime: 0.20);

    // Attack1
    characterSprites = [];
    for (int i = 88; i < _lengthOfAttack1Sprites; i += 4)
      if (i >= 100)
        characterSprites.add(await Sprite.load(
            'sprites/characters/knights/seq_antlerKnight/D_FrontLeft0${i}.png'));
      else
        characterSprites.add(await Sprite.load(
            'sprites/characters/knights/seq_antlerKnight/D_FrontLeft00${i}.png'));
    this._hitBottomLeft = SpriteAnimation.spriteList(characterSprites, stepTime: 0.20);

    // Run
    characterSprites = [];
    for (int i = 220; i < _lengthOfRunSprites; i += 4)
      characterSprites.add(await Sprite.load(
          'sprites/characters/knights/seq_antlerKnight/D_FrontLeft0${i}.png'));
    this._runBottomLeft = SpriteAnimation.spriteList(characterSprites, stepTime: 0.10);

    /// Left direction
    // Idle
    characterSprites = [];
    for (int i = 12; i < _lengthOfIdleSprites; i += 4)
      characterSprites.add(await Sprite.load(
          'sprites/characters/knights/seq_antlerKnight/E_Left00${i}.png'));
    this._idleLeft = SpriteAnimation.spriteList(characterSprites, stepTime: 0.20);

    // Attack1
    characterSprites = [];
    for (int i = 88; i < _lengthOfAttack1Sprites; i += 4)
      if (i >= 100)
        characterSprites.add(await Sprite.load(
            'sprites/characters/knights/seq_antlerKnight/E_Left0${i}.png'));
      else
        characterSprites.add(await Sprite.load(
            'sprites/characters/knights/seq_antlerKnight/E_Left00${i}.png'));
    this._hitLeft = SpriteAnimation.spriteList(characterSprites, stepTime: 0.20);

    // Run
    characterSprites = [];
    for (int i = 220; i < _lengthOfRunSprites; i += 4)
      characterSprites.add(await Sprite.load(
          'sprites/characters/knights/seq_antlerKnight/E_Left0${i}.png'));
    this._runLeft = SpriteAnimation.spriteList(characterSprites, stepTime: 0.10);

    /// Top left direction
    // Idle
    characterSprites = [];
    for (int i = 12; i < _lengthOfIdleSprites; i += 4)
      characterSprites.add(await Sprite.load(
          'sprites/characters/knights/seq_antlerKnight/F_BackLeft00${i}.png'));
    this._idleTopLeft = SpriteAnimation.spriteList(characterSprites, stepTime: 0.20);

    // Attack1
    characterSprites = [];
    for (int i = 88; i < _lengthOfAttack1Sprites; i += 4)
      if (i >= 100)
        characterSprites.add(await Sprite.load(
            'sprites/characters/knights/seq_antlerKnight/F_BackLeft0${i}.png'));
      else
        characterSprites.add(await Sprite.load(
            'sprites/characters/knights/seq_antlerKnight/F_BackLeft00${i}.png'));
    this._hitTopLeft = SpriteAnimation.spriteList(characterSprites, stepTime: 0.20);

    // Run
    characterSprites = [];
    for (int i = 220; i < _lengthOfRunSprites; i += 4)
      characterSprites.add(await Sprite.load(
          'sprites/characters/knights/seq_antlerKnight/F_BackLeft0${i}.png'));
    this._runTopLeft = SpriteAnimation.spriteList(characterSprites, stepTime: 0.10);

    /// Top direction
    // Idle
    characterSprites = [];
    for (int i = 12; i < _lengthOfIdleSprites; i += 4)
      characterSprites.add(await Sprite.load(
          'sprites/characters/knights/seq_antlerKnight/G_Back00${i}.png'));
    this._idleTop = SpriteAnimation.spriteList(characterSprites, stepTime: 0.20);

    // Attack1
    characterSprites = [];
    for (int i = 88; i < _lengthOfAttack1Sprites; i += 4)
      if (i >= 100)
        characterSprites.add(await Sprite.load(
            'sprites/characters/knights/seq_antlerKnight/G_Back0${i}.png'));
      else
        characterSprites.add(await Sprite.load(
            'sprites/characters/knights/seq_antlerKnight/G_Back00${i}.png'));
    this._hitTop = SpriteAnimation.spriteList(characterSprites, stepTime: 0.20);

    // Run
    characterSprites = [];
    for (int i = 220; i < _lengthOfRunSprites; i += 4)
      characterSprites.add(await Sprite.load(
          'sprites/characters/knights/seq_antlerKnight/G_Back0${i}.png'));
    this._runTop = SpriteAnimation.spriteList(characterSprites, stepTime: 0.10);

    /// Top Right direction
    // Idle
    characterSprites = [];
    for (int i = 12; i < _lengthOfIdleSprites; i += 4)
      characterSprites.add(await Sprite.load(
          'sprites/characters/knights/seq_antlerKnight/H_BackRight00${i}.png'));
    this._idleTopRight = SpriteAnimation.spriteList(characterSprites, stepTime: 0.20);

    // Attack1
    characterSprites = [];
    for (int i = 88; i < _lengthOfAttack1Sprites; i += 4)
      if (i >= 100)
        characterSprites.add(await Sprite.load(
            'sprites/characters/knights/seq_antlerKnight/H_BackRight0${i}.png'));
      else
        characterSprites.add(await Sprite.load(
            'sprites/characters/knights/seq_antlerKnight/H_BackRight00${i}.png'));
    this._hitTopRight = SpriteAnimation.spriteList(characterSprites, stepTime: 0.20);

    // Run
    characterSprites = [];
    for (int i = 220; i < _lengthOfRunSprites; i += 4)
      characterSprites.add(await Sprite.load(
          'sprites/characters/knights/seq_antlerKnight/H_BackRight0${i}.png'));
    this._runTopRight = SpriteAnimation.spriteList(characterSprites, stepTime: 0.10);
  }

  SpriteAnimation get idleRight => _idleRight;
  SpriteAnimation get hitRight => _hitRight;
  SpriteAnimation get runRight => _runRight;

  SpriteAnimation get idleDown => _idleDown;
  SpriteAnimation get hitDown => _hitDown;
  SpriteAnimation get runDown => _runDown;

  SpriteAnimation get idleLeft => _idleLeft;
  SpriteAnimation get hitLeft => _hitLeft;
  SpriteAnimation get runLeft => _runLeft;

  SpriteAnimation get idleTop => _idleTop;
  SpriteAnimation get hitTop => _hitTop;
  SpriteAnimation get runTop => _runTop;

  SpriteAnimation get idleBottomRight => _idleBottomRight;
  SpriteAnimation get hitBottomRight => _hitBottomRight;
  SpriteAnimation get runBottomRight => _runBottomRight;

  SpriteAnimation get idleBottomLeft => _idleBottomLeft;
  SpriteAnimation get hitBottomLeft => _hitBottomLeft;
  SpriteAnimation get runBottomLeft => _runBottomLeft;

  SpriteAnimation get idleTopLeft => _idleTopLeft;
  SpriteAnimation get hitTopLeft => _hitTopLeft;
  SpriteAnimation get runTopLeft => _runTopLeft;

  SpriteAnimation get idleTopRight => _idleTopRight;
  SpriteAnimation get hitTopRight => _hitTopRight;
  SpriteAnimation get runTopRight => _runTopRight;
}