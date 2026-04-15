import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'sliver/sliver_pinned_floating_widget.dart';

/// This spacer should be placed at the very bottom of a scroll view that has a [SBBSliverHeaderBox].
///
/// It will make sure that the scroll view has enough space to fully expand and contract the headerbox. Otherwise, you
/// may face issues with the headerbox stopping halfway.
class SBBSliverHeaderBoxSpacer extends LeafRenderObjectWidget {
  const SBBSliverHeaderBoxSpacer({super.key});

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _RenderSBBSliverHeaderBoxSpacer();
  }
}

class _RenderSBBSliverHeaderBoxSpacer extends RenderSliver {
  @override
  void performLayout() {
    final firstSibling = _header();

    if (firstSibling == null) {
      geometry = SliverGeometry(scrollExtent: 0);
      return;
    }

    final scrollExtent = firstSibling.expandableExtent;

    // Space that was filled with scrollable elements
    final scrollableContentExtent = constraints.precedingScrollExtent;

    // Available space in the viewport
    final availableSpace = constraints.viewportMainAxisExtent;

    var size = 0.0;

    if (scrollableContentExtent > availableSpace && scrollableContentExtent < (availableSpace + scrollExtent)) {
      // Bridge the gap if we have enough content to scroll, but not enough to finish the whole length of the headerbox
      size = (availableSpace + scrollExtent) - scrollableContentExtent;
    } else if (scrollableContentExtent < availableSpace && firstSibling.currentExtent < firstSibling.maxExtent) {
      // If for some reason (e.g. scroll physics) the headerbox is contracted even though there is not enough space,
      // make sure we make enough space.
      size = (availableSpace + scrollExtent) - scrollableContentExtent;
    }

    geometry = SliverGeometry(scrollExtent: size);
  }

  RenderSliverPinnedFloatingWidget? _header() {
    var parentData = this.parentData as ContainerParentDataMixin<RenderSliver>;

    while (parentData.previousSibling != null) {
      final renderObject = parentData.previousSibling!;
      parentData = renderObject.parentData as ContainerParentDataMixin<RenderSliver>;

      if (renderObject is RenderSliverPinnedFloatingWidget) {
        return renderObject;
      }
    }

    return null;
  }
}
