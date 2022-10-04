import 'dart:math';

import 'package:dingo/constants.dart';
import 'package:dingo/game/background_parallax.dart';
import 'package:dingo/game/dingo_player.dart';
import 'package:dingo/game/enemy_player.dart';
import 'package:dingo/models/enemy_model.dart';
import 'package:dingo/widgets/hud.dart';
import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flame/game.dart';

class DingoGame extends FlameGame with TapDetector, HasCollisionDetection {
  /// Image assets.
  static const imageAssets = [
    'sprites/dog.png',
    'sprites/rat.png',
  ];

  late DingoPlayer _player;

  late ParallaxComponent _background;

  final Timer _timer = Timer(3, repeat: true, autoStart: false);
  final Random _random = Random();

  @override
  Future<void> onLoad() async {
    await images.loadAll(imageAssets);

    camera.viewport =
        FixedResolutionViewport(Vector2(kViewPortWidth, kViewPortHeight));

    _background = BackgroundParallax();
    add(_background);

    var animations = {
      AnimationState.jumping: SpriteAnimationData.sequenced(
        amount: 4,
        stepTime: 0.3,
        textureSize: Vector2.all(48),
      ),
      AnimationState.run: SpriteAnimationData.sequenced(
        amount: 6,
        stepTime: 0.05,
        textureSize: Vector2.all(48),
      ),
    };

    var sprite = images.fromCache('sprites/dog.png');
    _player = DingoPlayer(sprite, animations);

    return super.onLoad();
  }

  void addEnemy() {
    double speed = _random.nextInt(75) / 100 + 1;

    EnemyModel enemyModel = EnemyModel(
      image: images.fromCache('sprites/rat.png'),
      numOfFrames: 4,
      stepTime: 1 / speed * 0.25,
      textureSize: Vector2.all(32),
      speedX: speed * 110,
      size: Vector2.all(46),
      scale: Vector2(-1, 1),
    );
    EnemyPlayer enemy = EnemyPlayer(enemyModel);
    add(enemy);
  }

  @override
  void onTapDown(TapDownInfo info) {
    // Make jump only when the game is playing
    if (overlays.isActive(Hud.id)) {
      _player.jump();
    }

    super.onTapDown(info);
  }

  @override
  void update(double dt) {
    _timer.update(dt);
    super.update(dt);
  }

  void startGame() {
    _background.parallax?.baseVelocity = Vector2(kGroundParallaxVelocity, 0);
    add(_player);
    _timer.onTick = addEnemy;
    _timer.start();
  }

  void stopGame() {
    _timer.stop();
    _background.parallax?.baseVelocity =
        Vector2(kGroundInActiveParallaxVelocity, 0);
    remove(_player);

    final items = children.whereType<EnemyPlayer>();
    for (var item in items) {
      item.removeFromParent();
    }
  }
}
