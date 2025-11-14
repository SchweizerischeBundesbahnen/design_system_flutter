import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

/// The PopoverShiftedPositioned. This Widget is tightly coupled to [SBBModalAnchoredBuilder].
///
/// This widget is responsible for two things:
///
/// 1. It uses the [overlayInfo] to write the [StackParentData] of the [RenderBox] in the stack of
/// [SBBModalAnchoredBuilder] to position the child according to the layout algorithm described below.
/// 2. If the child [RenderObject] is a [SBBPopover], it sets the [PopoverAnchorParentData] such that
/// the [RenderSBBPopover] can paint the notch at the correct position. See [RenderSBBPopover] for details.
///
/// The layout algorithm attempts to avoid the child to appear outside of the parent size. In [SBBModalAnchoredBuilder]
/// this corresponds to the whole available screen size, since building inside an [OverlayPortal].
class PopoverShiftedPositioned extends SingleChildRenderObjectWidget {
  const PopoverShiftedPositioned({super.key, required super.child, required this.overlayInfo});

  final OverlayChildLayoutInfo overlayInfo;


  @override
  SingleChildRenderObjectElement createElement() {
    // TODO: implement createElement
    return ParentDataElement(child);
    return super.createElement();
  }

  @override
  RenderObject createRenderObject(BuildContext context) {
    return super.createRenderObject(context);
  }

  @override
  void applyParentData(RenderObject renderObject) {
    assert(renderObject.parentData is StackParentData);
    final StackParentData parentData = renderObject.parentData! as StackParentData;
    bool needsLayout = false;

    final translation = overlayInfo.childPaintTransform.getTranslation();

    // renderObject.layout(BoxConstraints(), parentUsesSize: true);

    if (parentData.top != translation.y) {
      parentData.top = translation.y;
      needsLayout = true;
    }

    if (parentData.left != translation.x) {
      parentData.left = translation.x;
      needsLayout = true;
    }

    if (needsLayout) renderObject.parent?.markNeedsLayout();
    
    renderObject.visitChildren((child) => child.)
  }

  @override
  Type get debugTypicalAncestorWidgetClass => Stack;

  @override
  RenderObject createRenderObject(BuildContext context) {
    // TODO: implement createRenderObject
    throw UnimplementedError();
  }
}

class PopoverShiftedElement<T extends ParentData> extends ParentDataElement<T> {
  PopoverShiftedElement(super.widget);

  @override
  // TODO: implement renderObject
  RenderObject? get renderObject => super.renderObject;
}
