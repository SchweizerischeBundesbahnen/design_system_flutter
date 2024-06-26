part of 'sbb_picker.dart';

/// Signature for a function that creates a [SBBPickerItem] for a given index,
/// but may return null.
///
/// Used by [SBBPicker] and [SBBPickerScrollView].
///
/// Unlike most builders, this callback can return null, indicating the index
/// is out of range.
typedef SBBPickerScrollViewItemBuilder = SBBPickerItem? Function(
  BuildContext context,
  int index,
);

/// A box in which children on a wheel can be scrolled. Should only be used in
/// combination with [SBBPicker.custom].
///
/// When the list is at the zero scroll offset, the first child is aligned with
/// the middle of the viewport. When the list is at the final scroll offset,
/// the last child is aligned with the middle of the viewport.
class SBBPickerScrollView extends StatefulWidget {
  /// Constructs an [SBBPickerScrollView].
  ///
  /// [onSelectedItemChanged] is the callback called when the selected value
  /// changes.
  ///
  /// [itemBuilder] is the callback called when a picker item needs to be built.
  ///
  /// [controller] cas be used for programmatically reading or changing the
  /// current picker index.
  ///
  /// [looping] decides whether the list loops and can be scrolled infinitely.
  /// If set to true, scrolling past the end of the list will loop the list back
  /// to the beginning. If set to false, the list will stop scrolling when you
  /// reach the end or the beginning. Defaults to true.
  const SBBPickerScrollView({
    super.key,
    required this.onSelectedItemChanged,
    required this.itemBuilder,
    this.controller,
    this.looping = true,
  });

  final ValueChanged<int>? onSelectedItemChanged;
  final SBBPickerScrollViewItemBuilder itemBuilder;
  final SBBPickerScrollController? controller;
  final bool looping;

  @override
  State<SBBPickerScrollView> createState() => _SBBPickerScrollViewState();
}

const _visibleItemHeights = [
  28.0,
  29.0,
  30.0,
  36.0,
  30.0,
  29.0,
  28.0,
];

class _SBBPickerScrollViewState extends State<SBBPickerScrollView> {
  static const _visibleItemTransformValues = [
    -1.0,
    -2.5,
    -3.0,
    0.0,
    3.0,
    2.5,
    1.0,
  ];

  static const _listPaddingHeight = _visibleCenterItemIndex * _itemHeight;

  late ValueNotifier<double> _scrollOffsetValueNotifier;

  /// index of the first item that is currently rendered int the scroll view
  late ValueNotifier<int> _firstVisibleItemIndexValueNotifier;
  late ValueNotifier<int> _selectedItemIndexValueNotifier;

  late int _initialIndexOffset = _controller.initialItem;
  int _itemCountDeficit = 0;
  int? firstIndex;
  int? lastIndex;

  SBBPickerScrollController? _fallbackController;

  SBBPickerScrollController get _controller {
    return widget.controller ?? _fallbackController!;
  }

  @override
  void initState() {
    super.initState();
    _initController();
    _scrollOffsetValueNotifier = ValueNotifier(_controller.initialScrollOffset);
    _firstVisibleItemIndexValueNotifier = ValueNotifier(
      _controller.selectedItem - _visibleCenterItemIndex,
    );
    _selectedItemIndexValueNotifier = ValueNotifier(_controller.selectedItem);
    final onSelectedItemChanged = widget.onSelectedItemChanged;
    if (onSelectedItemChanged != null) {
      _selectedItemIndexValueNotifier.addListener(() {
        onSelectedItemChanged(_selectedItemIndexValueNotifier.value);
      });
    }
  }

  void _initController() {
    if (widget.controller == null) {
      _fallbackController = SBBPickerScrollController();
    }
    _controller.addListener(_onScrolling);
    _controller.setOnAttachListener(_onAttach);
  }

  @override
  void didUpdateWidget(covariant SBBPickerScrollView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != _controller) {
      _initController();
    }
  }

  @override
  void dispose() {
    _scrollOffsetValueNotifier.dispose();
    _selectedItemIndexValueNotifier.dispose();
    _fallbackController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final noScrollbarScrollBehaviour = ScrollConfiguration.of(context).copyWith(
      scrollbars: false,
    );
    return GestureDetector(
      onTapUp: _onTapUp,
      child: SizedBox(
        height: _scrollAreaHeight,
        child: Scrollable(
          controller: _controller,
          scrollBehavior: noScrollbarScrollBehaviour,
          viewportBuilder: (_, ViewportOffset offset) {
            final listCenterKey = UniqueKey();
            final isShortList = _itemCountDeficit > 0;
            final positiveIndexListCenterKey =
                !isShortList ? listCenterKey : null;
            final topPaddingListCenterKey = isShortList ? listCenterKey : null;
            return Viewport(
              offset: offset,
              center: listCenterKey,
              slivers: [
                if (!widget.looping)
                  SliverToBoxAdapter(
                    key: topPaddingListCenterKey,
                    child: const SizedBox(height: _listPaddingHeight),
                  ),
                _buildNegativeIndexList(),
                _buildPositiveIndexList(positiveIndexListCenterKey),
                if (!widget.looping)
                  const SliverToBoxAdapter(
                    child: SizedBox(height: _listPaddingHeight),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildNegativeIndexList() {
    return SliverList(
      delegate: SliverChildBuilderDelegate((_, index) {
        // adjust index so it goes negative from -1 instead of
        // positive from 0
        final adjustedIndex = -1 - index;
        return _buildItem(adjustedIndex);
      }),
    );
  }

  Widget _buildPositiveIndexList(Key? listCenterKey) {
    return SliverList(
      key: listCenterKey,
      delegate: SliverChildBuilderDelegate((_, index) {
        return _buildItem(index);
      }),
    );
  }

  Widget? _buildItem(int index) {
    final itemIndex = index + _initialIndexOffset - _visibleCenterItemIndex;
    final item = widget.itemBuilder(context, itemIndex);
    assert(
      !widget.looping || widget.looping && item != null,
      'Item builder returned null for index $itemIndex but looping was set to true',
    );

    if (!widget.looping && item == null) {
      return null;
    }

    final itemEnabled = item?.isEnabled ?? false;
    final itemWidget = item?.widget ?? const SizedBox.shrink();

    const placeholderItem = SizedBox(height: _itemHeight);

    // use ValueListenableBuilder with first visible item index to prevent
    // rebuilding items too often
    return ValueListenableBuilder(
      valueListenable: _firstVisibleItemIndexValueNotifier,
      builder: (_, int firstVisibleItemIndex, placeholderItem) {
        // check if item visible
        final itemVisible = itemIndex >= firstVisibleItemIndex &&
            itemIndex <= firstVisibleItemIndex + _visibleItemCount;
        if (!itemVisible) {
          // return placeholder item for out of sight items
          return placeholderItem!;
        }

        // item style values are calculated based on the current scroll offset
        return ValueListenableBuilder(
          valueListenable: _scrollOffsetValueNotifier,
          builder: (_, double offset, Widget? child) {
            // calculate the current item index of the visible items, this also
            // includes items that are only partly visible when scrolling
            final visibleItemIndex = itemIndex - firstVisibleItemIndex;

            // calculate transform translation offset based on scroll offset
            final translationOffset = _itemOffset(visibleItemIndex, offset);

            // text style based on whether item is enabled or not
            final textStyle = _itemTextStyle(itemEnabled);

            return SizedBox(
              height: _itemHeight,
              child: Center(
                child: DefaultTextStyle(
                  style: textStyle,
                  child: Transform.translate(
                    offset: translationOffset,
                    child: child,
                  ),
                ),
              ),
            );
          },
          child: itemWidget,
        );
      },
      child: placeholderItem,
    );
  }

  void _onAttach(ScrollPosition position) {
    // reset values
    final initialIndex = _controller.initialItem;
    _initialIndexOffset = initialIndex;
    _itemCountDeficit = 0;
    firstIndex = null;
    lastIndex = null;

    // check if item at initial item index is available
    final initialIndexItem = widget.itemBuilder(context, initialIndex);
    assert(
      initialIndexItem != null,
      'Item builder returned null for initial item index $initialIndex.',
    );

    if (position.hasContentDimensions &&
        (position.minScrollExtent.isFinite ||
            position.maxScrollExtent.isFinite)) {
      // check if list edges available
      var preInitialCount = _visibleCenterItemIndex;
      var postInitialCount = _visibleCenterItemIndex;

      // check 3 items before initial selected item
      for (var i = 0; i < _visibleCenterItemIndex; i++) {
        final indexToCheck = initialIndex - i - 1;
        final itemToCheck = widget.itemBuilder(context, indexToCheck);
        if (itemToCheck == null) {
          preInitialCount = i;
          break;
        }
      }

      // check 3 items after initial selected item
      for (var i = 0; i < _visibleCenterItemIndex; i++) {
        final indexToCheck = initialIndex + i + 1;
        final itemToCheck = widget.itemBuilder(context, indexToCheck);
        if (itemToCheck == null) {
          postInitialCount = i;
          break;
        }
      }

      if (preInitialCount < _visibleCenterItemIndex ||
          postInitialCount < _visibleCenterItemIndex) {
        final itemIndexOffset = _visibleCenterItemIndex - preInitialCount;
        _controller._indexOffset = itemIndexOffset;
        _initialIndexOffset += itemIndexOffset;

        final totalCount = preInitialCount + 1 + postInitialCount;
        if (totalCount < _longListMinItemCount) {
          firstIndex = initialIndex - preInitialCount;
          lastIndex = initialIndex + postInitialCount;
          _itemCountDeficit = _longListMinItemCount - totalCount;
          _controller._indexOffset = itemIndexOffset - _visibleCenterItemIndex;
        }

        _controller.jumpToItem(_controller.initialItem);
      }
    }

    // update value notifiers
    _onScrolling();
  }

  void _onScrolling() {
    final offset = _controller.offset;
    final firstVisibleItemIndex =
        _controller._offsetToIndex(offset).floor() - _visibleCenterItemIndex;
    var selectedItemIndex = _controller.selectedItem;

    // make sure calculated index is within list range
    selectedItemIndex = _clampIndex(selectedItemIndex);

    // update value notifiers
    _scrollOffsetValueNotifier.value = offset;
    _selectedItemIndexValueNotifier.value = selectedItemIndex;
    _firstVisibleItemIndexValueNotifier.value = firstVisibleItemIndex;
  }

  void _onTapUp(TapUpDetails details) {
    // calculate item index based on tap position
    final tapPosition = details.localPosition.dy;

    // determine which of the rendered items has been tapped
    var tappedVisibleItemIndex = 0;
    var totalVisibleItemHeightSoFar = 0.0;
    for (final visibleItemHeight in _visibleItemHeights) {
      totalVisibleItemHeightSoFar += visibleItemHeight;
      if (totalVisibleItemHeightSoFar > tapPosition) {
        break;
      }
      tappedVisibleItemIndex++;
    }

    // convert calculated index of the tapped item of the visible items to the
    // position index of the item in the list
    final firstVisibleItemIndex = _firstVisibleItemIndexValueNotifier.value;
    var itemIndex = firstVisibleItemIndex + tappedVisibleItemIndex;

    // clamp index to prevent scrolling to an item out of range
    itemIndex = _clampIndex(itemIndex);
    _onTapItem(itemIndex);
  }

  void _onTapItem(int index) {
    _controller.onTargetItemSelected?.call(index);
    _controller.animateToItem(index);
  }

  int _clampIndex(int index) {
    if (firstIndex != null && index < firstIndex!) {
      return firstIndex!;
    }
    if (lastIndex != null && index > lastIndex!) {
      return lastIndex!;
    }

    final scrollPosition = _controller.position;
    if (scrollPosition.hasContentDimensions) {
      final minScrollExtent = scrollPosition.minScrollExtent;
      if (minScrollExtent.isFinite) {
        final firstIndex = _controller._offsetToIndex(minScrollExtent).toInt();
        this.firstIndex = firstIndex;
        if (index < firstIndex) {
          return firstIndex;
        }
      }
      final maxScrollExtent = scrollPosition.maxScrollExtent;
      if (maxScrollExtent.isFinite) {
        final lastIndex = _controller._offsetToIndex(maxScrollExtent).toInt();
        this.lastIndex = lastIndex;
        if (index > lastIndex) {
          return lastIndex;
        }
      }
    }
    return index;
  }

  Offset _itemOffset(int visibleItemIndex, double offset) {
    final indexA = max(visibleItemIndex - 1, 0);
    final indexB = min(visibleItemIndex, _visibleItemCount - 1);
    final lerpFactor = 1 - offset % _itemHeight / _itemHeight;
    final transformA = _visibleItemTransformValues[indexA];
    final transformB = _visibleItemTransformValues[indexB];
    final transformY = lerpDouble(transformA, transformB, lerpFactor)!;
    return Offset(0, transformY);
  }

  TextStyle _itemTextStyle(bool itemEnabled) {
    final style = SBBControlStyles.of(context).picker!;
    final colorOpacity = itemEnabled ? 1.0 : 0.35;
    final textColor = SBBColors.white.withOpacity(colorOpacity);
    final textStyle = style.textStyle!.copyWith(color: textColor);
    return textStyle;
  }
}

/// Represents an item in the [SBBPickerScrollView] that is used by [SBBPicker].
class SBBPickerItem {
  /// Constructs an [SBBPickerItem] with a [label] and an optional [isEnabled]
  /// flag.
  ///
  /// [label] is the text that will be displayed for the item.
  ///
  /// [isEnabled] flag determines whether the item is enabled or disabled.
  SBBPickerItem(
    String label, {
    bool isEnabled = true,
  }) : this.custom(
          isEnabled: isEnabled,
          widget: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: _widgetHorizontalPadding + _itemMinPadding,
            ),
            child: Text(label, softWrap: false),
          ),
        );

  /// Constructs a custom [SBBPickerItem] with a widget.
  ///
  /// The [isEnabled] flag determines whether the item is enabled or disabled.
  /// Defaults to true.
  ///
  /// The [widget] is the custom widget to be displayed for the item.
  SBBPickerItem.custom({
    this.isEnabled = true,
    required this.widget,
  });

  final bool isEnabled;
  final Widget widget;
}
