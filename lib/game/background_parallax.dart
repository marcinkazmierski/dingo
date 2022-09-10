import 'package:dingo/constants.dart';
import 'package:dingo/game/dingo_game.dart';
import 'package:flame/components.dart';
import 'package:flame/parallax.dart';
import 'package:flutter/widgets.dart';

class BackgroundParallax extends ParallaxComponent<DingoGame> {
  @override
  Future<void> onLoad() async {
    parallax = await gameRef.loadParallax(
      [
        ParallaxImageData('parallax/sky.png'),
        ParallaxImageData('parallax/back.png'),
        ParallaxImageData('parallax/houses2.png'),
        ParallaxImageData('parallax/houses1.png'),
        ParallaxImageData('parallax/minishop&callbox.png'),
        ParallaxImageData('parallax/road&lamps.png'),
      ],
      repeat: ImageRepeat.repeat,
      baseVelocity: Vector2(kGroundInActiveParallaxVelocity, 0),
      velocityMultiplierDelta: Vector2(kGroundParallaxVelocityDelta, 0),
    );
  }
}
