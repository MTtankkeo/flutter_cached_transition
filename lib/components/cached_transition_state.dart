import 'package:flutter/widgets.dart';
import 'package:flutter_cached_transition/components/cached_transition_context.dart';

/// Holds animation state and widget instance for a cached transition.
class CachedTransitionState {
  CachedTransitionState({
    required CachedTransitionContext context,
    required this.widget,
  }) {
    _primaryAnimation = AnimationController(
      vsync: context.vsync,
      duration: context.duration,
    );

    _primaryCurved = CurvedAnimation(
      parent: _primaryAnimation,
      curve: context.curve,
    );

    _secondaryAnimation = AnimationController(
      vsync: context.vsync,
      duration: context.duration,
    );

    _secondaryCurved = CurvedAnimation(
      parent: _secondaryAnimation,
      curve: context.curve,
    );
  }

  /// The widget associated with this transition state.
  final Widget widget;

  late final AnimationController _primaryAnimation;
  late final CurvedAnimation _primaryCurved;

  late final AnimationController _secondaryAnimation;
  late final CurvedAnimation _secondaryCurved;

  /// Returns the fade-in animation with curve applied.
  Animation<double> get primaryAnimation => _primaryCurved;

  /// Returns the fade-out animation with curve applied.
  Animation<double> get secondaryAnimation => _secondaryCurved;

  /// Forces the fade-in animation to jump to the completed state.
  void ensureFadeInCompleted() {
    _primaryAnimation.value = 1;
  }

  /// Starts the fade-in animation from the beginning.
  void fadeIn() {
    _secondaryAnimation.reset();
    _primaryAnimation.reset();
    _primaryAnimation.forward();
  }

  /// Starts the fade-out animation from the beginning.
  void fadeOut() {
    _secondaryAnimation.reset();
    _secondaryAnimation.forward();
  }

  void dispose() {
    _primaryAnimation.dispose();
    _primaryCurved.dispose();
    _secondaryAnimation.dispose();
    _secondaryCurved.dispose();
  }
}
