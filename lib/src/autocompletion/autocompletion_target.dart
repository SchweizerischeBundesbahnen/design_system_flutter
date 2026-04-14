import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'autocompletion_link.dart';

/// A widget that wraps the [SBBAutocompletion] text field and continuously
/// publishes its rendered [Size] and global [Offset] into [link], so that the
/// companion [_AutocompletionOverlay] can position itself correctly.
///
/// It also acts as a [CompositedTransformTarget] so that a
/// [CompositedTransformFollower] can snap to the bottom of the field.
class AutocompletionTarget extends StatelessWidget {
  const AutocompletionTarget({
    super.key,
    required this.link,
    required this.child,
  });

  final AutocompletionLink link;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: link.layerLink,
      child: _RenderAutocompletionTargetWidget(
        link: link,
        child: child,
      ),
    );
  }
}

class _RenderAutocompletionTargetWidget extends SingleChildRenderObjectWidget {
  const _RenderAutocompletionTargetWidget({
    required this.link,
    super.child,
  });

  final AutocompletionLink link;

  @override
  RenderObject createRenderObject(BuildContext context) => _RenderAutocompletionTarget(link: link);

  @override
  void updateRenderObject(
    BuildContext context,
    _RenderAutocompletionTarget renderObject,
  ) {
    renderObject.link = link;
  }
}

class _RenderAutocompletionTarget extends RenderProxyBox {
  _RenderAutocompletionTarget({required AutocompletionLink link}) : _link = link;

  AutocompletionLink _link;

  AutocompletionLink get link => _link;

  set link(AutocompletionLink value) {
    if (_link == value) return;
    _link = value;
    markNeedsLayout();
  }

  @override
  void performLayout() {
    super.performLayout();
    _link.value = (
      size: size,
      offset: _link.value.offset,
    );
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    super.paint(context, offset);
    // Update the global offset after every paint so scroll / layout shifts are
    // reflected immediately.
    _link.value = (
      size: _link.value.size,
      offset: localToGlobal(Offset.zero),
    );
  }
}
