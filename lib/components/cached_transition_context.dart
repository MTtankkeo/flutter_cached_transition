import 'package:flutter/widgets.dart';

/// Provides shared animation settings for cached transitions.
mixin CachedTransitionContext {
  /// The ticker provider used by the animation controllers.
  TickerProvider get vsync;

  /// The duration of each transition animation.
  Duration get duration;

  /// The curve applied to the transition animations.
  Curve get curve;

  /// Whether to animate the first widget when it is initially displayed.
  bool get initialAnimation;
}
