import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/parallax.dart';
import 'package:flutter/material.dart';
import 'package:flame/game.dart';

class DingoGame extends FlameGame {
  @override
  Future<void> onLoad() async {
    super.onLoad();
    camera.viewport = FixedResolutionViewport(Vector2(640, 360));
    final background = await ParallaxComponent.load(
      [
        ParallaxImageData('parallax/1.png'),
        ParallaxImageData('parallax/2.png'),
        ParallaxImageData('parallax/3.png'),
        ParallaxImageData('parallax/4.png'),
        ParallaxImageData('parallax/5.png'),
        ParallaxImageData('parallax/6.png'),
      ],
      repeat: ImageRepeat.repeat,
      baseVelocity: Vector2(5, 0),
      velocityMultiplierDelta: Vector2(1.35, 0),
    );
    add(background);
  }
}
