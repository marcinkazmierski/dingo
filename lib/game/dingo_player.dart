import 'package:dingo/bloc/game_bloc.dart';
import 'package:dingo/constants.dart';
import 'package:dingo/game/dingo_game.dart';
import 'package:dingo/game/enemy_player.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'dart:ui';

import 'package:flutter_bloc/flutter_bloc.dart';

enum AnimationState { jumping, run, kick, hit, sprint }

class DingoPlayer extends SpriteAnimationGroupComponent<AnimationState>
    with CollisionCallbacks, HasGameRef<DingoGame> {
  DingoPlayer(Image image, Map<AnimationState, SpriteAnimationData> animations)
      : super.fromFrameData(image, animations,
            size: Vector2.all(kPlayerDefaultSize), current: AnimationState.run);

  static const double gravity = 750;
  double speedY = 0.0;
  bool jumping = false;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    position = Vector2(kPlayerDefaultX, kPlayerDefaultY);
    anchor = Anchor.bottomLeft;
  }

  @override
  void update(double dt) {
    // v = v + gravity*dt
    speedY = speedY + (gravity * dt);
    // position = position + velocity*dt
    y = y + (speedY * dt);

    if (y > kPlayerDefaultY) {
      y = kPlayerDefaultY;
      jumping = false;
      current = AnimationState.run;
    }

    super.update(dt);
  }

  void jump() {
    if (!jumping) {
      speedY = kPlayerJumpSpeedY;
      current = AnimationState.jumping;
      jumping = true;
    }
  }

  @override
  void onMount() {
    add(
      RectangleHitbox.relative(
        Vector2(0.5, 0.7),
        parentSize: size,
        position: Vector2(size.x * 0.5, size.y * 0.3) / 2,
      ),
    );

    super.onMount();
  }
}
