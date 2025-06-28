# Introduction
This package provides customizable widgets that preserve widget state while applying transition animations.

## Usage
The following explains the basic usage of this package.

```dart
CachedTransition(
    duration: Duration(milliseconds: 500),
    curve: Curves.ease,
    transitionBuilder: (child, primaryAnimation, secondaryAnimation) {
        return FadeTransition(
            opacity: primaryAnimation,
            child: child,
        );
    },
    child: Example(key: ValueKey(...)),
);
```
