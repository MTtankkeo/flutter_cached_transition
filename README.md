# Introduction
This package provides customizable widgets that preserve widget state while applying transition animations.

## Preview
The gif image below may appear distorted and choppy due to compression.

![preview](https://github.com/user-attachments/assets/770c220d-1fc0-4079-8e0b-d6491e5e8d5c)

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
