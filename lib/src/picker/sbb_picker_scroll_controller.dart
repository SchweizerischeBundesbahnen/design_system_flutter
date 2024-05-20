part of 'sbb_picker.dart';

/// A controller for [SBBPickerScrollView].
///
/// A SBB picker scroll view controller lets you manipulate which item is
/// selected in a [SBBPickerScrollView].
///
/// See also:
///
///  * [SBBPickerScrollView], which is the widget this object controls.
class SBBPickerScrollController extends ScrollController {
  SBBPickerScrollController({
    int initialItem = 0,
    this.onTargetItemSelected,
  }) : super(
          initialScrollOffset: _getItemScrollOffset(
            initialItem,
          ),
        );

  ValueNotifier<bool> _scrollingStateNotifier = ValueNotifier(false);
  late VoidCallback _isScrollingListener;

  /// TODO doc
  final ValueChanged<int>? onTargetItemSelected;

  int get selectedItem {
    final currentOffset = positions.isEmpty ? initialScrollOffset : offset;
    return (currentOffset / _defaultItemHeight).round() +
        _firstIndexPreItemsCount;
  }

  /// Animates the controlled [SBBPickerScrollView] from the current item to
  /// the item at the given index.
  ///
  /// The animation lasts for the given duration and follows the given curve or
  /// uses default values.
  /// The returned [Future] resolves when the animation completes.
  ///
  /// The duration must not be zero. To jump to a particular value without an
  /// animation, use [jumpToItem].
  ///
  /// The `duration` and `curve` arguments must not be null.
  Future<void> animateToItem(
    int itemIndex, {
    Duration duration = kThemeAnimationDuration,
    Curve curve = Curves.fastOutSlowIn,
  }) async {
    final targetItemScrollOffset = _getItemScrollOffset(itemIndex);
    await animateToScrollOffset(
      targetItemScrollOffset,
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
  Future<void> animateToScrollOffset(
    double scrollOffset, {
    Duration duration = kThemeAnimationDuration,
    Curve curve = Curves.fastOutSlowIn,
  }) async {
    await animateTo(
      scrollOffset,
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
    final targetItemScrollOffset = _getItemScrollOffset(itemIndex);
    jumpTo(targetItemScrollOffset);
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

      // check for idle scroll controller with Future.microtask to prevent
      // this getting triggered by a new drag action while the view was
      // already in an scroll animation
      Future.microtask(() {
        final scrollingValue = position.isScrollingNotifier.value;
        if (scrollingValue) {
          // only update scrolling value because controller is not idle
          _scrollingStateNotifier.value = scrollingValue;
          return;
        }

        // ensure scroll position snaps to the nearest item after controller
        // is done scrolling
        final currentScrollPosition = position.pixels;
        final targetScrollPosition =
            SBBPickerScrollController._calculateTargetScrollPosition(
          currentScrollPosition,
        );

        // Due to the workaround in the target scroll position calculation, the
        // calculated position may be slightly inaccurate. As a result, if the
        // difference between the current and calculated positions is minor, the
        // snap to item scroll will be skipped.
        final difference = (currentScrollPosition - targetScrollPosition).abs();
        if (difference > 0.01) {
          onTargetItemSelected?.call(selectedItem);
          animateToScrollOffset(
            targetScrollPosition,
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

  static double _getItemScrollOffset(int index) {
    final targetItemScrollOffset =
        (index - _firstIndexPreItemsCount) * _defaultItemHeight;
    return _calculateTargetScrollPosition(
      targetItemScrollOffset,
    );
  }

  static double _calculateTargetScrollPosition(double scrollPosition) {
    final itemsOfBothListsVisible =
        scrollPosition < 0 && scrollPosition > -_scrollAreaHeight;
    if (itemsOfBothListsVisible) {
      // Because the heights of list items vary depending on their positions,
      // it's necessary to handle the area where items from both the positive
      // and negative lists are visible differently. This is because the
      // calculation for the target scroll position isn't accurate when both
      // lists are scrolling simultaneously. Therefore, the calculation for the
      // target scroll position must be adjusted.
      for (var i = 0; i < _visibleItemCount; i++) {
        var threshold = 0.0;
        for (var j = 0; j < i; j++) {
          threshold -= _visibleItemHeights[j];
        }
        threshold -= _visibleItemHeights[i] * 0.5;
        if (scrollPosition > threshold) {
          return threshold + _visibleItemHeights[i] * 0.5;
        }
      }
    }

    return (scrollPosition / _defaultItemHeight).round() * _defaultItemHeight;
  }
}
