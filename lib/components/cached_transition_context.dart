import 'package:flutter/widgets.dart';

mixin CachedTransitionContext {
  TickerProvider get vsync;
  Duration get duration;
  Curve get curve;
  bool get initialAnimation;
}
