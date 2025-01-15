part of 'sbb_picker.dart';

/// A scroll controller for [SBBPickerScrollView] that is used by [SBBPicker].
///
/// An SBB picker scroll view controller lets you manipulate which item is
/// selected in an [SBBPickerScrollView].
///
/// See also:
///
/// * [SBBPickerScrollView], which is the widget this object controls.
class SBBPickerScrollController extends ScrollController {
  SBBPickerScrollController({
    this.initialItem = 0,
    this.onTargetItemSelected,
  });

  final ValueNotifier<bool> _scrollingStateNotifier = ValueNotifier(false);
  late VoidCallback _isScrollingListener;
  int _indexOffset = 0;
  double _itemHeight = _itemDefaultHeight;

  /// The index of the initial item to be selected.
  ///
  /// Defaults to 0.
  final int initialItem;

  /// Listener to be called as soon as the selected item is determined without
  /// waiting for any animations.
  final ValueChanged<int>? onTargetItemSelected;

  /// The index of the currently selected item.
  int get selectedItem {
    final selectedItemIndex = _offsetToIndex(offset).round();
    return selectedItemIndex;
  }

  @override
  double get initialScrollOffset {
    return _targetOffset(initialItem * _itemHeight);
  }

  /// The current scroll offset of the scrollable widget.
  ///
  /// Requires the controller to be controlling exactly one scrollable widget.
  @override
  double get offset {
    return positions.isEmpty ? initialScrollOffset : super.offset;
  }

  /// Animates the controlled [SBBPickerScrollView] from the current item to
  /// the item at the given index.
  ///
  /// The animation lasts for the given duration and follows the given curve or
  /// uses default values.
  /// The returned [Future] resolves when the animation completes.
  ///
  /// The duration must not be zero. To jump to a particular value without an
  /// animation, use [jumpToItem
  Future<void> animateToItem(
    int itemIndex, {
    Duration duration = kThemeAnimationDuration,
    Curve curve = Curves.fastOutSlowIn,
  }) async {
    await animateTo(
      itemIndex * _itemHeight,
      duration: duration,
      curve: curve,
    );
  }

  /// Animates the position from its current offset to the given offset.
  ///
  /// Any active animation is canceled. If the user is currently scrolling, that
  /// action is canceled.
  ///
  /// The returned [Future] will complete when the animation ends, whether it
  /// completed successfully or whether it was interrupted prematurely.
  ///
  /// An animation will be interrupted whenever the user attempts to scroll
  /// manually, or whenever another activity is started, or whenever the
  /// animation reaches the edge of the viewport and attempts to overscroll in a
  /// non looping [SBBPickerScrollView]. (If the [SBBPickerScrollView] is
  /// looping, then going around the loop will not interrupt the animation.)
  ///
  /// The animation is indifferent to changes to the viewport or content
  /// dimensions.
  ///
  /// Once the animation has completed, the scroll position will attempt to
  /// begin a ballistic activity to snap to the nearest item.
  ///
  /// The duration must not be zero. To jump to a particular value without an
  /// animation, use [jumpTo].
  @override
  Future<void> animateTo(
    double offset, {
    Duration duration = kThemeAnimationDuration,
    Curve curve = Curves.fastOutSlowIn,
  }) async {
    final targetOffset = _targetOffset(offset);
    return super.animateTo(
      targetOffset,
      duration: duration,
      curve: curve,
    );
  }

  /// Jumps the scroll position from the current item to the item at the given
  /// index, without animation.
  ///
  /// Any active animation is canceled. If the user is currently scrolling, that
  /// action is canceled.
  void jumpToItem(int itemIndex) {
    jumpTo(itemIndex * _itemHeight);
  }

  @override
  void jumpTo(double value) {
    final targetOffset = _targetOffset(value);
    super.jumpTo(targetOffset);
  }

  /// Register a listener to be called when the scrolling state changes.
  void addScrollingStateListener(VoidCallback listener) {
    _scrollingStateNotifier.addListener(listener);
  }

  /// Remove a previously registered listener from the list of listeners that
  /// are notified when the scrolling state changes.
  void removeScrollingStateListener(VoidCallback listener) {
    _scrollingStateNotifier.removeListener(listener);
  }

  /// Whether the controller is currently scrolling or not.
  bool isScrolling() {
    return _scrollingStateNotifier.value;
  }

  @override
  void attach(ScrollPosition position) {
    super.attach(position);
    _isScrollingListener = () {
      final scrollingValue = position.isScrollingNotifier.value;
      if (scrollingValue) {
        // only update scrolling value because controller is not idle
        _scrollingStateNotifier.value = scrollingValue;
        return;
      }

      // check for idle scroll controller with Future.microtask to prevent this
      // getting triggered by a new drag action while the view was already in an
      // scroll animation
      Future.microtask(() {
        final scrollingValue = position.isScrollingNotifier.value;
        if (scrollingValue) {
          // only update scrolling value because controller is not idle
          _scrollingStateNotifier.value = scrollingValue;
          return;
        }

        // ensure scroll position snaps to the nearest item after controller is
        // done scrolling
        final currentScrollPosition = position.pixels;
        final targetScrollPosition = _snappedScrollPosition(
          currentScrollPosition,
        );

        // Due to the workaround in the target scroll position calculation, the
        // calculated position may be slightly inaccurate. As a result, if the
        // difference between the current and calculated positions is minor, the
        // snap to item scroll will be skipped.
        final difference = (currentScrollPosition - targetScrollPosition).abs();
        if (difference > 0.01) {
          onTargetItemSelected?.call(selectedItem);
          animateToItem(
            selectedItem,
            curve: Curves.easeInOut,
          ).whenComplete(() {
            // update scrolling value after animation is complete
            _scrollingStateNotifier.value = position.isScrollingNotifier.value;
          });
        } else {
          _scrollingStateNotifier.value = scrollingValue;
        }
      });
    };
    position.isScrollingNotifier.addListener(_isScrollingListener);
  }

  @override
  void detach(ScrollPosition position) {
    position.isScrollingNotifier.removeListener(_isScrollingListener);
    super.detach(position);
  }

  @override
  void dispose() {
    _scrollingStateNotifier.dispose();
    super.dispose();
  }

  double _targetOffset(double offset) {
    final indexBasedPositionOffset = (0 - initialItem - _indexOffset) * _itemHeight;
    return offset + indexBasedPositionOffset;
  }

  double _offsetToIndex(double offset) {
    return offset / _itemHeight + initialItem + _indexOffset;
  }

  double _snappedScrollPosition(double offset) {
    return (offset / _itemHeight).round() * _itemHeight;
  }
}
