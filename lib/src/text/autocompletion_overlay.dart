import 'dart:math';

import 'package:flutter/material.dart';

import '../../sbb_design_system_mobile.dart';
import 'autocompletion_link.dart';

/// Signature for a function that builds a single suggestion list item.
typedef AutocompletionItemBuilder =
    Widget Function({
      required VoidCallback onPressed,
      required VoidCallback onCallToAction,
      required bool isFavorite,
    });

/// Manages the [OverlayPortal]-based suggestions drop-down for
/// [SBBAutocompletion].
///
/// The overlay positions itself directly below the text field tracked by
/// [link] and constrains its height to the available space above the
/// on-screen keyboard.
///
/// This widget is internal to the `text` module and is not exported from the
/// library.
class AutocompletionOverlay extends StatefulWidget {
  const AutocompletionOverlay({
    super.key,
    required this.link,
    required this.visible,
    required this.favoritesSection,
    required this.suggestionsSection,
    required this.child,
  });

  /// The link shared with [AutocompletionTarget].
  final AutocompletionLink link;

  /// Whether the overlay should be shown.
  final bool visible;

  /// Pre-built favourite items (may be empty).
  final List<Widget> favoritesSection;

  /// Pre-built filtered suggestion items (may be empty).
  final List<Widget> suggestionsSection;

  /// The text field wrapped by this overlay (becomes the [OverlayPortal] child).
  final Widget child;

  @override
  State<AutocompletionOverlay> createState() => _AutocompletionOverlayState();
}

class _AutocompletionOverlayState extends State<AutocompletionOverlay> {
  final OverlayPortalController _controller = OverlayPortalController();

  @override
  void initState() {
    super.initState();
    widget.link.addListener(_onLinkChanged);
    _syncVisibility();
  }

  @override
  void didUpdateWidget(AutocompletionOverlay oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.link != widget.link) {
      oldWidget.link.removeListener(_onLinkChanged);
      widget.link.addListener(_onLinkChanged);
    }
    _syncVisibility();
  }

  @override
  void dispose() {
    widget.link.removeListener(_onLinkChanged);
    super.dispose();
  }

  void _onLinkChanged() {
    if (widget.visible && mounted) {
      // Force the overlay child to rebuild with fresh geometry.
      setState(() {});
    }
  }

  void _syncVisibility() {
    if (widget.visible) {
      // Show is idempotent – safe to call when already shown.
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) _controller.show();
      });
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) _controller.hide();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return OverlayPortal(
      controller: _controller,
      overlayChildBuilder: _buildOverlay,
      child: widget.child,
    );
  }

  Widget _buildOverlay(BuildContext context) {
    final style = SBBBaseStyle.of(context);
    final backgroundColor = style.themeValue(SBBColors.milk, SBBColors.black);
    final optionColor = style.themeValue(SBBColors.white, SBBColors.charcoal);

    // -----------------------------------------------------------------------
    // Compute available height between the bottom of the text field and the
    // top of the on-screen keyboard (or the screen bottom if no keyboard).
    // -----------------------------------------------------------------------
    final mediaQuery = MediaQuery.of(context);
    final keyboardHeight = mediaQuery.viewInsets.bottom;
    final screenHeight = mediaQuery.size.height;

    final targetBottom = widget.link.value.offset.dy + widget.link.value.size.height;
    final availableHeight = max(0.0, screenHeight - targetBottom - keyboardHeight);

    final hasFavorites = widget.favoritesSection.isNotEmpty;
    final hasSuggestions = widget.suggestionsSection.isNotEmpty;

    if (!hasFavorites && !hasSuggestions) {
      return const SizedBox.shrink();
    }

    return CompositedTransformFollower(
      link: widget.link.layerLink,
      showWhenUnlinked: false,
      targetAnchor: Alignment.bottomLeft,
      followerAnchor: Alignment.topLeft,
      child: Align(
        alignment: Alignment.topLeft,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: widget.link.value.size.width,
            maxHeight: availableHeight,
          ),
          child: Material(
            color: backgroundColor,
            child: ListView(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              children: [
                if (hasFavorites) ...[
                  Container(color: backgroundColor, height: SBBSpacing.xxSmall),
                  ...SBBListItem.divideListItems(
                    context: context,
                    items: widget.favoritesSection.map(
                      (item) => Container(color: optionColor, child: item),
                    ),
                  ),
                ],
                if (hasSuggestions) ...[
                  Container(color: backgroundColor, height: SBBSpacing.xxSmall),
                  ...SBBListItem.divideListItems(
                    context: context,
                    items: widget.suggestionsSection.map(
                      (item) => Container(color: optionColor, child: item),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
