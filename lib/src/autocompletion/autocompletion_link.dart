import 'package:flutter/widgets.dart';

/// Holds the last known size and global offset of the [SBBAutocompletion] text
/// field, so that the overlay can position itself accordingly.
typedef AutocompletionInfo = ({
  Size size,
  Offset offset,
});

/// Connects a [_AutocompletionTarget] with a [_AutocompletionOverlay].
class AutocompletionLink extends ValueNotifier<AutocompletionInfo> {
  AutocompletionLink()
    : super(
        (size: Size.zero, offset: Offset.zero),
      );

  /// Used by [CompositedTransformTarget] / [CompositedTransformFollower] to
  /// keep the overlay pinned to the text field during scroll and layout changes.
  final LayerLink layerLink = LayerLink();
}
