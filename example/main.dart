import 'package:flutter/material.dart';
import 'package:flutter_cached_transition/flutter_cached_transition.dart';

void main() {
  runApp(const RootApp());
}

class RootApp extends StatefulWidget {
  const RootApp({super.key});

  @override
  State<RootApp> createState() => _RootAppState();
}

class _RootAppState extends State<RootApp> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CachedTransition(
                  duration: Duration(milliseconds: 500),
                  curve: Curves.ease,
                  transitionBuilder: (
                    Widget child,
                    Animation<double> primaryAnimation,
                    Animation<double> secondaryAnimation,
                  ) {
                    return FadeTransition(
                      opacity: primaryAnimation,
                      child: child,
                    );
                  },
                  child: Counter(key: ValueKey(_index)),
                ),
                FilledButton(
                  onPressed: () => setState(() => _index = 0),
                  child: Text("Move to 0"),
                ),
                FilledButton(
                  onPressed: () => setState(() => _index = 1),
                  child: Text("Move to 1"),
                ),
                FilledButton(
                  onPressed: () => setState(() => _index = 2),
                  child: Text("Move to 2"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Counter extends StatefulWidget {
  const Counter({super.key});

  @override
  State<Counter> createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => setState(() => count += 1),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 60),
        color: Colors.amber,
        child: Text(count.toString(), style: TextStyle(fontSize: 32)),
      ),
    );
  }
}
