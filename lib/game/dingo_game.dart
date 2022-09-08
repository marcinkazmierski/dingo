import 'package:dingo/constants.dart';
import 'package:dingo/game/dingo_player.dart';
import 'package:dingo/widgets/main_menu.dart';
import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flame/parallax.dart';
import 'package:flutter/material.dart';
import 'package:flame/game.dart';

class DingoGame extends FlameGame with TapDetector {
  /// Image assets.
  static const imageAssets = [
    'parallax/back.png',
    'parallax/houses1.png',
    'parallax/houses2.png',
    'parallax/minishop&callbox.png',
    'parallax/road&lamps.png',
    'parallax/sky.png',
    'dog/sprite.png',
  ];

  late DingoPlayer _player;

  @override
  Future<void> onLoad() async {
    await images.loadAll(imageAssets);

    camera.viewport =
        FixedResolutionViewport(Vector2(kViewPortWidth, kViewPortHeight));
    ParallaxComponent background = await ParallaxComponent.load(
      [
        ParallaxImageData('parallax/sky.png'),
        ParallaxImageData('parallax/back.png'),
        ParallaxImageData('parallax/houses2.png'),
        ParallaxImageData('parallax/houses1.png'),
        ParallaxImageData('parallax/minishop&callbox.png'),
        ParallaxImageData('parallax/road&lamps.png'),
      ],
      repeat: ImageRepeat.repeat,
      baseVelocity: Vector2(kGroundParallaxVelocity, 0),
      velocityMultiplierDelta: Vector2(kGroundParallaxVelocityDelta, 0),
    );
    add(background);

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
    await add(_player); //todo: add start function
    return super.onLoad();
  }

  @override
  void onTapDown(TapDownInfo info) {
    // Make jump only when the game is playing
    if (overlays.isActive(MainMenu.id)) {
      // todo
    }
    _player.jump();

    super.onTapDown(info);
  }
}
