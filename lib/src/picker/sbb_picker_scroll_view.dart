part of 'sbb_picker.dart';

/// Signature for a function that creates a [SBBPickerItem] for a given index,
/// but may return null.
///
/// Used by [SBBPicker] and [SBBPickerScrollView].
///
/// Unlike most builders, this callback can return null, indicating the index
/// is out of range.
typedef SBBPickerScrollViewItemBuilder = SBBPickerItem? Function(BuildContext context, int index);

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

class _SBBPickerScrollViewState extends _PickerClassState<SBBPickerScrollView> {
  static const _visibleItemTransformValues = [-1.0, -2.5, -3.0, 0.0, 3.0, 2.5, 1.0];

  static const _visibleItemHeightAdjustments = [-2.0, -1.0, 0.0, 6.0, 0.0, -1.0, -2.0];

  static const _visibleCenterItemIndex = 3;

  static const _disabledItemOpacity = 0.35;

  List<double> get _visibleItemHeights =>
      _visibleItemHeightAdjustments.map((adjustment) => _itemHeight + adjustment).toList();

  double get _listPaddingHeight => _visibleCenterItemIndex * _itemHeight;

  late ValueNotifier<double> _scrollOffsetValueNotifier;
  late ValueNotifier<int> _firstVisibleItemIndexValueNotifier;
  late ValueNotifier<int> _selectedItemIndexValueNotifier;

  late int _initialIndexOffset = _controller.initialItem;
  bool _isShortList = false;
  int? _firstIndex;
  int? _lastIndex;

  SBBPickerScrollController? _fallbackController;

  SBBPickerScrollController get _controller {
    return widget.controller ?? _fallbackController!;
  }

  @override
  void initState() {
    super.initState();
    _initController();
    _scrollOffsetValueNotifier = ValueNotifier(_controller.initialScrollOffset);
    _firstVisibleItemIndexValueNotifier = ValueNotifier(_controller.selectedItem - _visibleCenterItemIndex);
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
    _applyIndexOffset();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _controller._itemHeight = _itemHeight;
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
    // disable scroll bars because they don't work properly with the way the
    // scroll view is built
    final noScrollBarsBehaviour = ScrollConfiguration.of(context).copyWith(scrollbars: false);
    return GestureDetector(
      onTapUp: _onTapUp,
      child: SizedBox(
        height: _scrollAreaHeight,
        child: Scrollable(
          controller: _controller,
          scrollBehavior: noScrollBarsBehaviour,
          viewportBuilder: (_, ViewportOffset offset) => _buildViewPort(offset),
        ),
      ),
    );
  }

  Widget _buildViewPort(ViewportOffset offset) {
    // set list center key based on whether there is an item count deficit
    final listCenterKey = UniqueKey();
    final topPaddingListCenterKey = _isShortList ? listCenterKey : null;
    final positiveIndexListCenterKey = !_isShortList ? listCenterKey : null;

    return Viewport(
      offset: offset,
      center: listCenterKey,
      slivers: [
        if (!widget.looping)
          SliverToBoxAdapter(key: topPaddingListCenterKey, child: SizedBox(height: _listPaddingHeight)),
        _buildNegativeIndexList(),
        _buildPositiveIndexList(positiveIndexListCenterKey),
        if (!widget.looping) SliverToBoxAdapter(child: SizedBox(height: _listPaddingHeight)),
      ],
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

    return _firstVisibleItemIndexBasedItem(itemIndex, itemEnabled, itemWidget);
  }

  Widget _firstVisibleItemIndexBasedItem(int itemIndex, bool itemEnabled, Widget itemWidget) {
    // placeholder item used for items that are currently not visible
    final placeholderItem = SizedBox(height: _itemHeight);

    // use ValueListenableBuilder with first visible item index to prevent
    // rebuilding items too often
    return ValueListenableBuilder(
      valueListenable: _firstVisibleItemIndexValueNotifier,
      builder: (_, int firstVisibleItemIndex, placeholderItem) {
        // check if item visible
        final itemVisible =
            itemIndex >= firstVisibleItemIndex && itemIndex <= firstVisibleItemIndex + _visibleItemCount;
        if (!itemVisible) {
          // return placeholder item for out of sight items
          return placeholderItem!;
        }

        // item style values are calculated based on the current scroll offset
        return _buildScrollOffsetBasedItem(firstVisibleItemIndex, itemIndex, itemEnabled, itemWidget);
      },
      child: placeholderItem,
    );
  }

  Widget _buildScrollOffsetBasedItem(int firstVisibleItemIndex, int itemIndex, bool itemEnabled, Widget itemWidget) {
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
              child: Transform.translate(offset: translationOffset, child: child),
            ),
          ),
        );
      },
      child: itemWidget,
    );
  }

  void _onScrolling() {
    final offset = _controller.offset;
    final firstVisibleItemIndex = _controller._offsetToIndex(offset).floor() - _visibleCenterItemIndex;
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

  /// Ensures proper display and scrolling behavior of the list by checking item
  /// widgets around the initial item. If the number of non-null items before or
  /// around the initial item is insufficient, it calculates and applies an
  /// index offset to maintain proper functionality.
  void _applyIndexOffset() {
    // reset values
    final initialIndex = _controller.initialItem;
    _initialIndexOffset = initialIndex;
    _isShortList = false;
    _firstIndex = null;
    _lastIndex = null;

    if (widget.looping) {
      // no need to check for looping lists
      return;
    }

    // check if item at initial item index is available
    final initialIndexItem = widget.itemBuilder(context, initialIndex);
    assert(initialIndexItem != null, 'Item builder returned null for initial item index $initialIndex.');

    // check if list edges available
    final preInitialCount = _itemsAroundInitialItem(true);
    final postInitialCount = _itemsAroundInitialItem(false);
    final preInitialDeficit = preInitialCount < _visibleCenterItemIndex;
    final postInitialDeficit = postInitialCount < _visibleCenterItemIndex;
    if (preInitialDeficit) {
      _firstIndex = initialIndex - preInitialCount;
    }
    if (postInitialDeficit) {
      _lastIndex = initialIndex + postInitialCount;
    }
    if (preInitialDeficit || postInitialDeficit) {
      final itemIndexOffset = _visibleCenterItemIndex - preInitialCount;
      _controller._indexOffset = itemIndexOffset;
      _initialIndexOffset = initialIndex + itemIndexOffset;

      final totalCount = preInitialCount + 1 + postInitialCount;
      if (totalCount < _longListMinItemCount) {
        _controller._indexOffset = itemIndexOffset - _visibleCenterItemIndex;
        _isShortList = true;
      }
    }
  }

  int _itemsAroundInitialItem(bool checkPrevious) {
    final directionFactor = checkPrevious ? -1 : 1;
    final initialIndex = _controller.initialItem;
    for (var i = 0; i < _visibleCenterItemIndex; i++) {
      final indexToCheck = initialIndex + (i + 1) * directionFactor;
      final itemToCheck = widget.itemBuilder(context, indexToCheck);
      if (itemToCheck == null) {
        return i;
      }
    }
    return _visibleCenterItemIndex;
  }

  int _clampIndex(int index) {
    if (_firstIndex != null && index < _firstIndex!) {
      return _firstIndex!;
    }
    if (_lastIndex != null && index > _lastIndex!) {
      return _lastIndex!;
    }

    final scrollPosition = _controller.position;
    if (scrollPosition.hasContentDimensions) {
      final minScrollExtent = scrollPosition.minScrollExtent;
      if (minScrollExtent.isFinite) {
        final firstIndex = _controller._offsetToIndex(minScrollExtent).toInt();
        _firstIndex = firstIndex;
        if (index < firstIndex) {
          return firstIndex;
        }
      }
      final maxScrollExtent = scrollPosition.maxScrollExtent;
      if (maxScrollExtent.isFinite) {
        final lastIndex = _controller._offsetToIndex(maxScrollExtent).toInt();
        _lastIndex = lastIndex;
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
    final colorOpacity = itemEnabled ? 1.0 : _disabledItemOpacity;
    final textColor = SBBColors.white.withValues(alpha: colorOpacity);
    final textStyle = style.textStyle!.copyWith(color: textColor);
    return textStyle;
  }
}
