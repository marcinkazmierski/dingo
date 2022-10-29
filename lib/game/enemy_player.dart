import 'package:dingo/constants.dart';
import 'package:dingo/game/dingo_game.dart';
import 'package:dingo/game/dingo_player.dart';
import 'package:dingo/models/enemy_model.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/game_bloc.dart';

class EnemyPlayer extends SpriteAnimationComponent
    with CollisionCallbacks, HasGameRef<DingoGame> {
  EnemyPlayer(EnemyModel enemyModel) {
    start(enemyModel);
  }

  double speedX = 0;
  bool _collision = false;

  void start(EnemyModel enemyModel) {
    speedX = enemyModel.speedX;
    position = Vector2(kViewPortWidth + enemyModel.size.x, kPlayerDefaultY);
    size = enemyModel.size;
    scale = enemyModel.scale;
    anchor = Anchor.bottomLeft;
    animation = SpriteAnimation.fromFrameData(
      enemyModel.image,
      SpriteAnimationData.sequenced(
        amount: enemyModel.numOfFrames,
        stepTime: enemyModel.stepTime,
        textureSize: enemyModel.textureSize,
      ),
    );
  }

  @override
  void update(double dt) {
    position.x = position.x - speedX * dt;
    if (position.x < 0) {
      gameRef.buildContext!
          .read<GameBloc>()
          .add(const GameAddPoints(points: 1));
      removeFromParent();
    }

    super.update(dt);
  }

  @override
  void onMount() {
    add(
      RectangleHitbox.relative(
        Vector2.all(0.8),
        parentSize: size,
        position: Vector2(size.x * 0.2, size.y * 0.2) / 2,
      ),
    );

    super.onMount();
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    if (!_collision && other is DingoPlayer) {
      position.y = position.y + 5;
      gameRef.buildContext!.read<GameBloc>().add(const GameRemoveOneLife());
      _collision = true;
      animation?.stepTime = double.infinity;
      speedX = kEnemySpeedYAfterDead;
    }
    super.onCollisionStart(intersectionPoints, other);
  }
}
