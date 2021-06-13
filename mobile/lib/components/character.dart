import 'dart:math';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:rpg_game/components/npc.dart';
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

class Character extends SpriteAnimationGroupComponent<CharacterState>
    with Hitbox, Collidable, HasGameRef<MyGame>
    implements JoystickListener {
  static const speed = 100;
  final Vector2 velocity = Vector2.zero();
  int hp = 100;
  double currentSpeed = 0;
  double angle = 0;
  bool move = false;
  late Rect rect;
  late Timer timer;

  Character(Map<CharacterState, SpriteAnimation> animations, {
    Vector2? position,
    Vector2? size,
  }) : super(
          position: position,
          size: size,
          animations: animations,
        ) {
    timer = Timer(3.0)
      ..stop()
      ..callback = () {
        gameRef.camera.setRelativeOffset(Anchor.center);
      };
  }

  Character.fromFrameData(
      animations,
      Image image, Map<CharacterState, SpriteAnimationData> data,
      {Vector2? position,
        Vector2? size
      })
      : super(
          position: position,
          size: size,
          animations: animations,
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

    timer = Timer(3.0)
      ..stop()
      ..callback = () {
        gameRef.camera.setRelativeOffset(Anchor.center);
      };
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    debugMode = true;
  }

  @override
  void update(double dt) {
    super.update(dt);
    timer.update(dt);

    final displacement = velocity * (speed * dt);
    // position += displacement;
    position.add(displacement);
  }

  @override
  int get priority => 1;

  @override
  void onCollision(Set<Vector2> points, Collidable other) {
    if (other is Npc) {
      gameRef.camera.setRelativeOffset(Anchor.topCenter);
      timer.start();
    }
  }

  @override
  void onGameResize(Vector2 gameSize) {
    final offset = (gameSize - size) / 2;
    //rect = offset & size;
    //this.character.size = offset & size
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
