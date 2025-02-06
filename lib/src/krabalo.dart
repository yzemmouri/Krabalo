import 'dart:async';
import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:sensors_plus/sensors_plus.dart';

import 'components/components.dart';
import 'config.dart';

class Krabalo extends FlameGame with HasCollisionDetection {
  Krabalo()
      : super(
          camera: CameraComponent.withFixedResolution(
            width: gameWidth,
            height: gameHeight,
          ),
        );

  StreamSubscription<GyroscopeEvent>? gyroSubscription;
  late Ball ball;
  double tiltAngle = 0; // To store cumulative tilt based on gyroscope
  double get width => size.x;
  double get height => size.y;

  @override
  FutureOr<void> onLoad() async {
    super.onLoad();

    camera.viewfinder.anchor = Anchor.topLeft;

    world.add(PlayArea());

    ball = Ball(
      radius: ballRadius,
      position: size / 4,
      velocity: Vector2.zero(),
    );

    // Set up gyroscope listener
    gyroSubscription = gyroscopeEventStream().listen((GyroscopeEvent event) {
      // Calculate angular change over time (assuming `dt` is roughly 1/60th second)
      const double dt = 1 / 60;
      // Accumulate the tilt angle based on the angular velocity from the gyroscope
      tiltAngle += event.z * dt;

      // Apply physics-based velocity from the tilt angle
      ball.velocity.x = -sensitivity *
          sin(tiltAngle); // Horizontal velocity from gyroscope
    });

    world.add(ball);

    debugMode = true;
  }
}
