import 'package:dingo/constants.dart';
import 'package:dingo/game/dingo_game.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'dart:ui';

class EnemyPlayer extends SpriteAnimationComponent
    with CollisionCallbacks, HasGameRef<DingoGame> {
  EnemyPlayer(Image image, SpriteAnimationData animation)
      : super.fromFrameData(image, animation,
            size: Vector2.all(40), scale: Vector2(-1, 1));

  double speedX = 99.0;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    position = Vector2(kViewPortWidth, kPlayerDefaultY);
    anchor = Anchor.bottomLeft;
  }

  @override
  void update(double dt) {
    // Move the opponent closer to the left corner of the screen
    position.x = position.x - speedX * dt;
    if (position.x < 0) {
      position = Vector2(kViewPortWidth, kPlayerDefaultY);
    }

    super.update(dt);
  }
}
