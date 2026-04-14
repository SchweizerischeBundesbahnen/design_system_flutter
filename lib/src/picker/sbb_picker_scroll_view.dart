import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'sbb_picker_constants.dart';
import 'sbb_picker_item.dart';
import 'sbb_picker_scope.dart';
import 'sbb_picker_scroll_controller.dart';
import 'theme/sbb_picker_style.dart';

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
  /// [controller] can be used for programmatically reading or changing the
  /// current picker index.
  ///
  /// [looping] decides whether the list loops and can be scrolled infinitely.
  /// If set to true, scrolling past the end of the list will loop the list back
  /// to the beginning. If set to false, the list will stop scrolling when you
  /// reach the end or the beginning. Defaults to true.
  ///
  /// [pickerStyle] can be used to customize the visual appearance of the picker.
  /// Non-null properties override the corresponding properties in
  /// [SBBPickerThemeData.pickerStyle] from the current theme.
  const SBBPickerScrollView({
    super.key,
    required this.onSelectedItemChanged,
    required this.itemBuilder,
    this.controller,
    this.initialItem = 0,
    this.looping = true,
    this.pickerStyle,
  });

  /// Called when the selected item index changes.
  final ValueChanged<int>? onSelectedItemChanged;

  /// Called when a picker item needs to be built.
  ///
  /// May return null to indicate the index is out of range (only valid when
  /// [looping] is false).
  final SBBPickerScrollViewItemBuilder itemBuilder;

  /// Can be used for programmatically reading or changing the current picker
  /// index.
  ///
  /// If not provided, an internal controller is created automatically.
  final SBBPickerScrollController? controller;

  /// The index of the item to select initially when no [controller] is provided.
  ///
  /// Ignored when a [controller] is passed, since the controller already carries
  /// its own [SBBPickerScrollController.initialItem].
  final int initialItem;

  /// Whether the list loops and can be scrolled infinitely.
  ///
  /// If set to true, scrolling past the end of the list will loop the list back
  /// to the beginning. If set to false, the list will stop scrolling when you
  /// reach the end or the beginning.
  final bool looping;

  /// Customizes the visual appearance of the picker.
  ///
  /// Non-null properties override the corresponding properties in
  /// [SBBPickerThemeData.pickerStyle] from the current theme.
  final SBBPickerStyle? pickerStyle;

  @override
  State<SBBPickerScrollView> createState() => _SBBPickerScrollViewState();
}

class _SBBPickerScrollViewState extends State<SBBPickerScrollView> {
  // Visual parameters for the scroll wheel effect.
  static const _transformAmplitude = 2.5; // max vertical translate offset in pixels

  int _visibleItemCount = pickerDefaultVisibleItemCount;

  int get _visibleCenterItemIndex => _visibleItemCount ~/ 2;

  // Item height is read from the ambient SBBPickerScope.
  double get _itemHeight => SBBPickerScope.of(context).itemHeight;

  double get _scrollAreaHeight => _itemHeight * _visibleItemCount;

  double get _listPaddingHeight => _visibleCenterItemIndex * _itemHeight;

  SBBPickerStyle? _getEffectivePickerStyle(BuildContext context) {
    return SBBPickerScope.maybeOf(context)?.pickerStyle;
  }

  late ValueNotifier<double> _scrollOffsetValueNotifier;
  late ValueNotifier<int> _firstVisibleItemIndexValueNotifier;
  late ValueNotifier<int> _selectedItemIndexValueNotifier;
  late VoidCallback _selectedItemChangedListener;

  late int _initialIndexOffset = _controller.initialItem;
  int? _firstIndex;
  int? _lastIndex;

  SBBPickerScrollController? _fallbackController;

  SBBPickerScrollController get _controller {
    return widget.controller ?? _fallbackController!;
  }

  final _listCenterKey = UniqueKey();

  @override
  void initState() {
    super.initState();
    _initController();
    _scrollOffsetValueNotifier = ValueNotifier(_controller.initialScrollOffset);
    _firstVisibleItemIndexValueNotifier = ValueNotifier(_controller.selectedItem - _visibleCenterItemIndex);
    _selectedItemIndexValueNotifier = ValueNotifier(_controller.selectedItem);
    _selectedItemChangedListener = _notifySelectedItemChanged;
    _attachOnSelectedItemChangedListener();
  }

  void _initController() {
    if (widget.controller == null) {
      _fallbackController = SBBPickerScrollController(initialItem: widget.initialItem);
    }
    _controller.addListener(_onScrolling);
    _applyIndexOffset();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final scope = SBBPickerScope.of(context);
    final visibleItemCountChanged = _visibleItemCount != scope.visibleItemCount;
    _visibleItemCount = scope.visibleItemCount;

    // Update controller item height whenever the scope's itemHeight changes.
    _controller.itemHeight = scope.itemHeight;

    if (visibleItemCountChanged) {
      final selectedItem = _clampIndex(_selectedItemIndexValueNotifier.value);
      _applyIndexOffset();
      _firstVisibleItemIndexValueNotifier.value = selectedItem - _visibleCenterItemIndex;
      _selectedItemIndexValueNotifier.value = selectedItem;
      _scrollOffsetValueNotifier.value = _controller.initialScrollOffset;
    }
  }

  @override
  void didUpdateWidget(covariant SBBPickerScrollView oldWidget) {
    super.didUpdateWidget(oldWidget);

    final oldController = oldWidget.controller ?? _fallbackController;
    final controllerChanged = oldWidget.controller != widget.controller;

    if (controllerChanged) {
      final previousSelectedItem = oldController?.selectedItem ?? _selectedItemIndexValueNotifier.value;

      oldController?.removeListener(_onScrolling);
      if (oldWidget.controller == null) {
        _fallbackController?.dispose();
        _fallbackController = null;
      }
      if (widget.controller == null) {
        _fallbackController = SBBPickerScrollController(initialItem: previousSelectedItem);
      }
      _controller.addListener(_onScrolling);

      _controller.itemHeight = _itemHeight;
      _applyIndexOffset();

      final selectedItem = _clampIndex(previousSelectedItem);
      _firstVisibleItemIndexValueNotifier.value = selectedItem - _visibleCenterItemIndex;
      _selectedItemIndexValueNotifier.value = selectedItem;
      _scrollOffsetValueNotifier.value = _controller.initialScrollOffset;
    }

    if (oldWidget.onSelectedItemChanged != widget.onSelectedItemChanged) {
      _detachOnSelectedItemChangedListener();
      _attachOnSelectedItemChangedListener();
    }
  }

  @override
  void dispose() {
    _detachOnSelectedItemChangedListener();
    _scrollOffsetValueNotifier.dispose();
    _firstVisibleItemIndexValueNotifier.dispose();
    _selectedItemIndexValueNotifier.dispose();
    _controller.removeListener(_onScrolling);
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
    // When the total item count is smaller than the number of items on one side
    // of the center, the positive-index list cannot fill the negative scroll
    // region on its own. In that case the center key is placed on the top
    // padding sliver so the viewport origin lands in the right position.
    final isShortList =
        _firstIndex != null && _lastIndex != null && (_lastIndex! - _firstIndex! + 1) <= _visibleCenterItemIndex;

    final topPaddingListCenterKey = isShortList ? _listCenterKey : null;
    final positiveIndexListCenterKey = !isShortList ? _listCenterKey : null;

    final topEndFiller = SizedBox(height: _listPaddingHeight);

    return Viewport(
      offset: offset,
      center: _listCenterKey,
      slivers: [
        if (!widget.looping) SliverToBoxAdapter(key: topPaddingListCenterKey, child: topEndFiller),
        _buildIndexList(negative: true),
        _buildIndexList(centerKey: positiveIndexListCenterKey),
        if (!widget.looping) SliverToBoxAdapter(child: topEndFiller),
      ],
    );
  }

  Widget _buildIndexList({bool negative = false, Key? centerKey}) {
    return SliverList(
      key: centerKey,
      delegate: SliverChildBuilderDelegate((_, index) {
        // adjust index so it goes negative from -1 instead of positive from 0
        return _buildItem(negative ? -1 - index : index);
      }),
    );
  }

  Widget? _buildItem(int index) {
    final itemIndex = index + _initialIndexOffset - _visibleCenterItemIndex;
    final item = widget.itemBuilder(context, itemIndex);
    assert(
      !widget.looping || item != null,
      'Item builder returned null for index $itemIndex but looping was set to true',
    );

    if (!widget.looping && item == null) {
      return null;
    }

    final itemEnabled = item?.isEnabled ?? false;
    final itemWidget = item?.widget ?? const SizedBox.shrink();

    return _buildVisibleItem(itemIndex, itemEnabled, itemWidget);
  }

  Widget _buildVisibleItem(int itemIndex, bool itemEnabled, Widget itemWidget) {
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
    // item translation values are calculated based on the current scroll offset
    return ValueListenableBuilder(
      valueListenable: _scrollOffsetValueNotifier,
      builder: (_, double offset, Widget? child) {
        final visibleItemIndex = itemIndex - firstVisibleItemIndex;
        final translationOffset = _itemOffset(visibleItemIndex, offset);
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
    final firstVisibleItemIndex = _controller.offsetToIndex(offset).floor() - _visibleCenterItemIndex;
    var selectedItemIndex = _controller.selectedItem;

    selectedItemIndex = _clampIndex(selectedItemIndex);

    _scrollOffsetValueNotifier.value = offset;
    _selectedItemIndexValueNotifier.value = selectedItemIndex;
    _firstVisibleItemIndexValueNotifier.value = firstVisibleItemIndex;
  }

  void _onTapUp(TapUpDetails details) {
    final tapPosition = details.localPosition.dy;
    final tappedVisibleItemIndex = (tapPosition / _itemHeight).floor().clamp(0, _visibleItemCount - 1);

    final firstVisibleItemIndex = _firstVisibleItemIndexValueNotifier.value;
    var itemIndex = firstVisibleItemIndex + tappedVisibleItemIndex;

    itemIndex = _clampIndex(itemIndex);
    _onTapItem(itemIndex);
  }

  void _onTapItem(int index) {
    _controller.onTargetItemSelected?.call(index);
    _controller.animateToItem(index);
  }

  void _notifySelectedItemChanged() {
    widget.onSelectedItemChanged?.call(_selectedItemIndexValueNotifier.value);
  }

  void _attachOnSelectedItemChangedListener() {
    if (widget.onSelectedItemChanged != null) {
      _selectedItemIndexValueNotifier.addListener(_selectedItemChangedListener);
    }
  }

  void _detachOnSelectedItemChangedListener() {
    _selectedItemIndexValueNotifier.removeListener(_selectedItemChangedListener);
  }

  /// Ensures proper display and scrolling behavior of the list by checking item
  /// widgets around the initial item. If the number of non-null items before or
  /// around the initial item is insufficient, it calculates and applies an
  /// index offset to maintain proper functionality.
  void _applyIndexOffset() {
    final initialIndex = _controller.initialItem;
    _initialIndexOffset = initialIndex;
    _firstIndex = null;
    _lastIndex = null;

    if (widget.looping) return;

    final initialIndexItem = widget.itemBuilder(context, initialIndex);
    assert(initialIndexItem != null, 'Item builder returned null for initial item index $initialIndex.');

    final preInitialCount = _countItemsInDirection(-1);
    final postInitialCount = _countItemsInDirection(1);
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
      _controller.indexOffset = itemIndexOffset;
      _initialIndexOffset = initialIndex + itemIndexOffset;

      final totalCount = preInitialCount + 1 + postInitialCount;
      if (totalCount <= _visibleCenterItemIndex) {
        _controller.indexOffset = itemIndexOffset - _visibleCenterItemIndex;
      }
    }
  }

  /// Returns the number of consecutive non-null items starting from
  /// [_controller.initialItem] in [direction] (+1 for forward, -1 for backward),
  /// up to [_visibleCenterItemIndex].
  int _countItemsInDirection(int direction) {
    final initialIndex = _controller.initialItem;
    for (var i = 0; i < _visibleCenterItemIndex; i++) {
      final indexToCheck = initialIndex + (i + 1) * direction;
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

    if (!_controller.hasClients) return index;
    final scrollPosition = _controller.position;
    if (scrollPosition.hasContentDimensions) {
      final minScrollExtent = scrollPosition.minScrollExtent;
      if (minScrollExtent.isFinite) {
        final firstIndex = _controller.offsetToIndex(minScrollExtent).toInt();
        _firstIndex = firstIndex;
        if (index < firstIndex) {
          return firstIndex;
        }
      }
      final maxScrollExtent = scrollPosition.maxScrollExtent;
      if (maxScrollExtent.isFinite) {
        final lastIndex = _controller.offsetToIndex(maxScrollExtent).toInt();
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
    final transformA = _transformForDist(indexA - _visibleCenterItemIndex);
    final transformB = _transformForDist(indexB - _visibleCenterItemIndex);
    final transformY = lerpDouble(transformA, transformB, lerpFactor)!;
    return Offset(0, transformY);
  }

  /// Vertical translate offset for an item [d] positions from the center.
  /// Uses a sine curve so the offset is 0 at the center.
  double _transformForDist(int d) {
    final sideItemCount = _visibleCenterItemIndex;
    if (sideItemCount == 0) return 0.0;
    return _transformAmplitude * sin(d * pi / sideItemCount);
  }

  TextStyle _itemTextStyle(bool itemEnabled) {
    final style = _getEffectivePickerStyle(context)!;
    return style.textStyle!.copyWith(color: itemEnabled ? style.foregroundColor : style.disabledForegroundColor);
  }
}
