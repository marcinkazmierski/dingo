import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flame/game.dart';
import 'dart:ui';

class EnemyModel {
  final Image image;
  final int numOfFrames;
  final double stepTime;
  final Vector2 textureSize;
  final double speedX;
  final Vector2 size;
  final Vector2 scale;

  EnemyModel({
    required this.image,
    required this.numOfFrames,
    required this.stepTime,
    required this.textureSize,
    required this.speedX,
    required this.size,
    required this.scale,
  });
}
