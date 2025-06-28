import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class CacehdTransitionStack extends MultiChildRenderObjectWidget {
  const CacehdTransitionStack({
    super.key,
    required this.primaryKey,
    required this.secondaryKey,
    required super.children,
  });

  final Key primaryKey;
  final Key? secondaryKey;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderCacehdTransitionStack(
      primaryKey: primaryKey,
      secondaryKey: secondaryKey,
    );
  }

  @override
  void updateRenderObject(
    BuildContext context,
    RenderCacehdTransitionStack renderObject,
  ) {
    renderObject
      ..primaryKey = primaryKey
      ..secondaryKey = secondaryKey;
  }
}

class RenderCacehdTransitionStack extends RenderBox
    with
        ContainerRenderObjectMixin<RenderBox, _ParentData>,
        RenderBoxContainerDefaultsMixin<RenderBox, _ParentData> {
  RenderCacehdTransitionStack({
    required Key? primaryKey,
    required Key? secondaryKey,
  })  : _primaryKey = primaryKey,
        _secondaryKey = secondaryKey;

  Key? _primaryKey;
  Key? get primaryKey => _primaryKey!;
  set primaryKey(Key? newKey) {
    if (_primaryKey != newKey) {
      _primaryKey = newKey;
      markNeedsLayout();
    }
  }

  Key? _secondaryKey;
  Key? get secondaryKey => _secondaryKey;
  set secondaryKey(Key? newKey) {
    if (_secondaryKey != newKey) {
      _secondaryKey = newKey;
      markNeedsLayout();
    }
  }

  RenderBox? get primary => getChildByKey(primaryKey);
  RenderBox? get secondary => getChildByKey(secondaryKey);

  RenderBox? getChildByKey(Key? key) {
    if (key == null) return null;
    RenderBox? child = firstChild;
    while (child != null) {
      final childParentData = child.parentData as _ParentData;
      if (childParentData.key == key) {
        return child;
      }
      child = childAfter(child);
    }
    return null;
  }

  @override
  void setupParentData(RenderBox child) {
    if (child.parentData is! _ParentData) {
      child.parentData = _ParentData();
    }
  }

  @override
  void performLayout() {
    primary?.layout(constraints, parentUsesSize: true);
    secondary?.layout(constraints, parentUsesSize: true);

    size = primary?.size ?? Size.zero;
  }

  @override
  bool hitTest(BoxHitTestResult result, {required Offset position}) {
    return primary?.hitTest(result, position: position) ?? false;
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    if (secondary != null) {
      context.paintChild(secondary!, offset);
    }

    if (primary != null) {
      context.paintChild(primary!, offset);
    }
  }
}

class CachedTransitionStackParent extends ParentDataWidget<_ParentData> {
  const CachedTransitionStackParent({
    super.key,
    required super.child,
  });

  @override
  void applyParentData(RenderObject renderObject) {
    final parentData = renderObject.parentData as _ParentData;
    if (parentData.key != key) {
      parentData.key = key;
    }
  }

  @override
  Type get debugTypicalAncestorWidgetClass => RenderCacehdTransitionStack;
}

/// Parent data for use with [CacehdTransitionStack].
class _ParentData extends ContainerBoxParentData<RenderBox> {
  Key? key;
}
