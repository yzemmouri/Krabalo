import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:krabalo/src/components/play_area.dart';
import 'package:krabalo/src/config.dart';
import 'package:krabalo/src/krabalo.dart';

class Ball extends CircleComponent
    with CollisionCallbacks, HasGameReference<Krabalo> {
  Ball({
    required this.velocity,
    required super.position,
    required double radius,
  }) : super(
            radius: radius,
            anchor: Anchor.center,
            paint: Paint()
              ..color = const Color(0xff1e6091)
              ..style = PaintingStyle.fill,
            children: [CircleHitbox()]);

  Vector2 velocity;
  int bounceCount = 0;


  @override
  void update(double dt) {
    super.update(dt);
    // move down based on gravity
    velocity.y += gravity * dt; // Gravity acceleration
    position.y += velocity.y * dt;
    // Move horizontally based on gyroscope
    position.x += velocity.x * dt;
    // Handle boundary collisions
    final double leftBound = radius;
    final double rightBound = game.width - radius;
    final double topBound = radius;
    final double bottomBound = game.height - radius;

    if (position.x <= leftBound) {
      position.x = leftBound;
      velocity.x = 0; // Stop moving to left
      debugPrint('Hit left boundary');
    } else if (position.x >= rightBound) {
      position.x = rightBound;
      velocity.x = 0; // Stop moving to right
      debugPrint('Hit right boundary');
    }

    if (position.y <= topBound) {
      position.y = topBound;
      velocity.y = -velocity.y; 
      debugPrint('Hit top boundary');
    } else if (position.y >= bottomBound) {
      position.y = bottomBound;
      
      if (bounceCount < maxBounces && velocity.y.abs() > 50) {
        // Apply elasticity and energy loss
        velocity.y = -velocity.y * restitution * energyLoss;
        bounceCount++;
        debugPrint('Bounce $bounceCount: velocity = ${velocity.y}');
      } else {
        // Stop after max bounces or when velocity is too low
        velocity.y = 0;
        bounceCount = 0;
        debugPrint('Stopped bouncing');
      }
    }
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);
    debugPrint('Collision with $other');
  }
}
