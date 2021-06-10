import 'dart:math';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/palette.dart';
import 'package:rpg_game/game.dart';
import 'package:flame/joystick.dart';

enum CharacterState {
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
}

// final _whitePaint = BasicPalette.white.paint();
// final _bluePaint = BasicPalette.blue.paint();
// final _greenPaint = BasicPalette.green.paint();

class Character extends SpriteAnimationGroupComponent<CharacterState>
    with HasGameRef<MyGame>, Hitbox
    implements JoystickListener {
  static const speed = 100;
  final Vector2 velocity = Vector2(0, 0);
  int hp = 100;
  double currentSpeed = 0;
  double angle = 0;
  bool move = false;
  Paint paint;
  Rect rect;

  Character({
    Vector2 position,
    Vector2 size,
    // ignore: missing_required_param
  }) : super(
          position: position,
          size: size,
        );

  Character.fromFrameData(
      Image image, Map<CharacterState, SpriteAnimationData> data,
      {Vector2 position, Vector2 size
      })
      // ignore: missing_required_param
      : super(
          position: position,
          size: size,
        ) {
    animations = data.map((key, value) {
      return MapEntry(
        key,
        SpriteAnimation.fromFrameData(
          image,
          value,
        ),
      );
    });
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    debugMode = true;
  }

  @override
  void update(double dt) {
    super.update(dt);

    final displacement = velocity * (speed * dt);
    position += displacement;
  }

  @override
  void onGameResize(Vector2 gameSize) {
    final offset = (gameSize - size) / 2;
    rect = offset & size;
    super.onGameResize(gameSize);
  }

  @override
  void joystickAction(JoystickActionEvent event) {
    if (event.event == ActionEvent.down) {
      // if (event.id == 1) {
      //   paint = paint == _whitePaint ? _bluePaint : _whitePaint;
      // }
      // if (event.id == 2) {
      //   paint = paint == _whitePaint ? _greenPaint : _whitePaint;
      // }
    } else if (event.event == ActionEvent.move) {
      if (event.id == 3) {
        angle = event.angle;
      }
    }
  }

  @override
  void joystickChangeDirectional(JoystickDirectionalEvent event) {
    move = event.directional != JoystickMoveDirectional.idle;
    if (move) {
      if (event.directional == JoystickMoveDirectional.moveLeft) {
        this.current = CharacterState.runningLeft;
        this.velocity.x = -1;
      } else if (event.directional == JoystickMoveDirectional.moveRight) {
        this.current = CharacterState.runningRight;
        this.velocity.x = 1;
      } else if (event.directional == JoystickMoveDirectional.moveUp) {
        this.current = CharacterState.runningUp;
        this.velocity.y = -1;
      } else if (event.directional == JoystickMoveDirectional.moveDown) {
        this.current = CharacterState.runningDown;
        this.velocity.y = 1;
      }
    } else {
      this.current = CharacterState.idleRight;
      this.velocity.x = 0;
      this.velocity.y = 0;
    }
  }
}
