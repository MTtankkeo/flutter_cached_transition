import 'package:flutter/widgets.dart';
import 'package:flutter_cached_transition/components/cached_transition_context.dart';
import 'package:flutter_cached_transition/components/cached_transition_controller.dart';
import 'package:flutter_cached_transition/widgets/cacehd_transition_stack.dart';

/// Signature for builders used to generate custom transitions for
/// [CachedTransition].
typedef CachedTransitionBuilder = Widget Function(
  Widget child,
  Animation<double> primaryAnimation,
  Animation<double> secondaryAnimation,
);

/// A widget that applies a custom transition between child widgets
/// and preserves the previous widget for visual continuity.
class CachedTransition extends StatefulWidget {
  const CachedTransition({
    super.key,
    required this.transitionBuilder,
    this.initialAnimation = false,
    required this.duration,
    required this.curve,
    required this.child,
  });

  /// Builds the transition effect between the previous and current widgets.
  final CachedTransitionBuilder transitionBuilder;

  /// Whether to animate the initial widget when first rendered.
  final bool initialAnimation;

  /// Duration of the transition animation.
  final Duration duration;

  /// Curve used to animate the transition.
  final Curve curve;

  /// The current widget to display and transition to.
  final Widget child;

  @override
  State<CachedTransition> createState() => _CachedTransitionState();
}

class _CachedTransitionState extends State<CachedTransition>
    with TickerProviderStateMixin, CachedTransitionContext {
  late final CachedTransitionController _controller =
      CachedTransitionController(context: this);

  Key? secondary;

  @override
  void didUpdateWidget(covariant CachedTransition oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.child.key != widget.child.key) {
      secondary = oldWidget.child.key;
      _controller.findState(secondary!)?.fadeOut();

      final Key? primary = widget.child.key;
      _controller.findState(primary!)?.fadeIn();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    assert(widget.child.key != null, "A child must always have a key.");

    final state = _controller.findState(widget.child.key!);
    if (state == null) {
      _controller.attach(widget.child);
    }

    return CachedTransitionStack(
      primaryKey: widget.child.key!,
      secondaryKey: secondary,
      children: _controller.states.values.map((state) {
        return CachedTransitionStackParent(
          key: state.widget.key,
          child: widget.transitionBuilder(
            state.widget,
            state.primaryAnimation,
            state.secondaryAnimation,
          ),
        );
      }).toList(),
    );
  }

  @override
  TickerProvider get vsync => this;

  @override
  Duration get duration => widget.duration;

  @override
  Curve get curve => widget.curve;

  @override
  bool get initialAnimation => widget.initialAnimation;
}
