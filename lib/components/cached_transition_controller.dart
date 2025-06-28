import 'package:flutter/widgets.dart';
import 'package:flutter_cached_transition/components/cached_transition_context.dart';
import 'package:flutter_cached_transition/components/cached_transition_state.dart';
import 'package:flutter_cached_transition/widgets/cached_transition.dart';

/// Manages a collection of transition states and controls their animations.
///
/// Used by [CachedTransition] widget.
class CachedTransitionController<T extends CachedTransitionState> {
  CachedTransitionController({required this.context});

  /// Stores transition states mapped by widget keys.
  final Map<Key, T> states = {};

  /// Provides shared animation config and vsync for state creation.
  final CachedTransitionContext context;

  /// Attaches a new widget by creating its transition state
  /// and triggering animation.
  void attach(Widget widget) {
    final T newState = createState(widget);

    if (states.isEmpty) {
      context.initialAnimation
          ? newState.fadeIn()
          : newState.ensureFadeInCompleted();
    } else {
      // Subsequent widgets: always fade-in animation.
      newState.fadeIn();
    }

    states[widget.key!] = newState;
  }

  /// Returns the state associated with the given key,
  /// or null if not found.
  T? findState(Key key) {
    return states[key];
  }

  /// Creates a new transition state instance for the given widget.
  T createState(Widget widget) {
    return CachedTransitionState(widget: widget, context: context) as T;
  }
}
