import 'package:dingo/constants.dart';
import 'package:dingo/game/dingo_game.dart';
import 'package:dingo/game/dingo_player.dart';
import 'package:dingo/models/enemy_model.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class EnemyPlayer extends SpriteAnimationComponent
    with CollisionCallbacks, HasGameRef<DingoGame> {
  EnemyPlayer(this._enemyModel) {
    start();
  }

  final EnemyModel _enemyModel;

  void start() {
    position = Vector2(kViewPortWidth, kPlayerDefaultY);
    size = _enemyModel.size;
    scale = _enemyModel.scale;
    anchor = Anchor.bottomLeft;
    animation = SpriteAnimation.fromFrameData(
      _enemyModel.image,
      SpriteAnimationData.sequenced(
        amount: _enemyModel.numOfFrames,
        stepTime: _enemyModel.stepTime,
        textureSize: _enemyModel.textureSize,
      ),
    );
  }

  @override
  void update(double dt) {
    position.x = position.x - _enemyModel.speedX * dt;
    if (position.x < 0) {
      gameRef.score++;
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
    if (other is DingoPlayer) {
      position.y = position.y + 5;
    }
    super.onCollisionStart(intersectionPoints, other);
  }

  @override
  void onCollisionEnd(PositionComponent other) {
    if (other is DingoPlayer) {
      position.y = position.y - 5;
    }
    super.onCollisionEnd(other);
  }
}
