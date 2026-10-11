import 'package:flutter/widgets.dart';
import 'package:flutter_cached_transition/flutter_cached_transition.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('preserves child state when returning to a cached key', (tester) async {
    Future<void> show(Widget child) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: .ltr,
          child: CachedTransition(
            transitionBuilder: (child, _, _) => child,
            duration: const .new(milliseconds: 100),
            curve: Curves.linear,
            child: child,
          ),
        ),
      );

      await tester.pumpAndSettle();
    }

    Widget first() {
      return StatefulBuilder(
        key: const ValueKey('first'),
        builder: (_, _) => const SizedBox(),
      );
    }

    // Display the first child and capture its state.
    await show(first());
    final state = tester.state(find.byType(StatefulBuilder));

    // Switch to another child and verify that the first state stays mounted.
    await show(const SizedBox(key: ValueKey('second')));
    expect(state.mounted, isTrue);

    // Return to the same key and verify that the original state is reused.
    await show(first());
    expect(tester.state(find.byType(StatefulBuilder)), same(state));
  });

  testWidgets('updates the current child without recreating its state', (tester) async {
    Future<void> show(String text) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: .ltr,
          child: CachedTransition(
            transitionBuilder: (child, _, _) => child,
            duration: const .new(milliseconds: 100),
            curve: Curves.linear,
            child: StatefulBuilder(
              key: const ValueKey('current'),
              builder: (_, _) => Text(text),
            ),
          ),
        ),
      );
    }

    // Display the initial text and capture the current child's state.
    await show('before');
    final state = tester.state(find.byType(StatefulBuilder));
    expect(find.text('before'), findsOneWidget);

    // Update the text with the same key and verify that it is displayed.
    await show('after');
    expect(find.text('after'), findsOneWidget);
    expect(find.text('before'), findsNothing);

    // Verify that the update preserves the original state.
    expect(tester.state(find.byType(StatefulBuilder)), same(state));
  });
}
