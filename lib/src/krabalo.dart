import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:sensors_plus/sensors_plus.dart';

import 'components/components.dart';
import 'config.dart';

class Krabalo extends FlameGame {
  Krabalo()
      : super(
          camera: CameraComponent.withFixedResolution(
            width: gameWidth,
            height: gameHeight,
          ),
        );

  StreamSubscription<GyroscopeEvent>? gyroSubscription;
  late Ball ball;
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
      ball.velocity.x =
          -event.z * width * 0.5; // Horizontal velocity from gyroscope
      ball.velocity.y = height * 0.2;
    });

    world.add(ball);

    debugMode = true;
  }
}
