import 'package:dingo/constants.dart';
import 'package:dingo/game/background_parallax.dart';
import 'package:dingo/game/dingo_player.dart';
import 'package:dingo/widgets/hud.dart';
import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flame/game.dart';

class DingoGame extends FlameGame with TapDetector {
  /// Image assets.
  static const imageAssets = [
    'dog/sprite.png',
  ];

  late DingoPlayer _player;
  late ParallaxComponent _background;

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

    var sprite = images.fromCache('dog/sprite.png');
    _player = DingoPlayer(sprite, animations);

    return super.onLoad();
  }

  @override
  void onTapDown(TapDownInfo info) {
    // Make jump only when the game is playing
    if (overlays.isActive(Hud.id)) {
      _player.jump();
    }

    super.onTapDown(info);
  }

  void startGame() {
    _background.parallax?.baseVelocity = Vector2(kGroundParallaxVelocity, 0);
    add(_player);
  }

  void stopGame() {
    _background.parallax?.baseVelocity =
        Vector2(kGroundInActiveParallaxVelocity, 0);
    remove(_player);
  }
}
