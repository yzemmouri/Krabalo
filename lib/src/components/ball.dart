import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class Ball extends CircleComponent {
  Ball({
    required this.velocity,
    required super.position,
    required double radius,
  }) : super(
            radius: radius,
            anchor: Anchor.center,
            paint: Paint()
              ..color = const Color(0xff1e6091)
              ..style = PaintingStyle.fill);

  Vector2 velocity;

  @override
  void update(double dt) {
    super.update(dt);
    // Move horizontally based on gyroscope
    position.x += velocity.x * dt;

    position.y += velocity.y * dt;
  }
}
