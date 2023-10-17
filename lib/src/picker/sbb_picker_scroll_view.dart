part of 'sbb_picker.dart';

typedef SBBPickerScrollViewItemBuilder = (bool isEnabled, Widget widget)?
    Function(BuildContext context, int index);

const _defaultItemHeight = 30.0;
const _visibleItemCount = 7;
const _firstIndexPreItemsCount = 3;
const _scrollAreaHeight = _defaultItemHeight * _visibleItemCount;
const _visibleItemHeights = [
  28.0,
  28.0,
  30.0,
  38.0,
  30.0,
  28.0,
  28.0,
];
const _visibleItemTextColors = [
  SBBColors.silver,
  SBBColors.cement,
  SBBColors.storm,
  SBBColors.storm,
  SBBColors.storm,
  SBBColors.cement,
  SBBColors.silver,
];

class SBBPickerScrollView extends StatefulWidget {
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

class _SBBPickerScrollViewState extends State<SBBPickerScrollView> {
  late ValueNotifier<double> _scrollOffsetValueNotifier;
  late ValueNotifier<int> _selectedItemIndexValueNotifier;
  SBBPickerScrollController? _fallbackController;

  void _initController() {
    if (widget.controller == null) {
      _fallbackController = SBBPickerScrollController();
    }
    _controller.addListener(() {
      _scrollOffsetValueNotifier.value = _controller.offset;
    });
  }

  @override
  void initState() {
    super.initState();
    _initController();
    _scrollOffsetValueNotifier = ValueNotifier(
      _controller.initialScrollOffset,
    );
    _selectedItemIndexValueNotifier = ValueNotifier(_controller.selectedItem);

    _selectedItemIndexValueNotifier.addListener(() {
      final onSelectedItemChanged = widget.onSelectedItemChanged;
      if (onSelectedItemChanged != null) {
        // callback needs to be notified with Future.microtask to prevent
        // notifying callback during build phase which result in an exception
        Future.microtask(() {
          onSelectedItemChanged(_selectedItemIndexValueNotifier.value);
        });
      }
    });
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
    final _listCenterKey = UniqueKey();
    return Container(
      height: _scrollAreaHeight,
      child: Scrollable(
        controller: _controller,
        viewportBuilder: (
          BuildContext context,
          ViewportOffset offset,
        ) {
          return Viewport(
            offset: offset,
            center: _listCenterKey,
            slivers: [
              // negative list (index < 0)
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    // adjust index so it goes negative from -1 instead of
                    // positive from 0
                    final adjustedIndex = -1 * index - 1;
                    return _buildListItem(adjustedIndex);
                  },
                ),
              ),
              // positive list (index >= 0)
              SliverList(
                key: _listCenterKey,
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return _buildListItem(index);
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget? _buildListItem(int index) {
    int? scrollTarget = index;
    (bool, Widget)? listItem = widget.itemBuilder(
      context,
      index,
    );
    var listItemEnabled = listItem?.$1 ?? false;
    var listItemWidget = listItem?.$2;

    if (!widget.looping && listItem == null) {
      // checking for spacer list items in non looping scroll views
      if (index < 0 && index >= -_firstIndexPreItemsCount) {
        // scroll to first item for tapping top spacer items
        scrollTarget = 0;
        listItemWidget = SizedBox.shrink();
      } else if (widget.itemBuilder(
            context,
            index - _firstIndexPreItemsCount,
          ) !=
          null) {
        // scroll to last item for tapping bottom spacer items
        scrollTarget = null;
        listItemWidget = SizedBox.shrink();
      } else {
        return null;
      }
    }

    // item style values are calculated based on the current scroll offset
    return ValueListenableBuilder(
      valueListenable: _scrollOffsetValueNotifier,
      builder: (
        BuildContext context,
        double offset,
        Widget? _,
      ) {
        final itemsOfBothListsVisible =
            offset < 0 && offset > -_scrollAreaHeight;
        if (itemsOfBothListsVisible) {
          // Because of the target scroll position calculation workaround used
          // in SBBPickerScrollController, it's necessary to adjust the offset
          // to ensure that item heights are accurately calculated.
          var threshold = 0.0;
          for (var i = 0; i < _visibleItemCount; i++) {
            threshold -= _visibleItemHeights[i];
            if (threshold <= offset) {
              final offsetPercentage = offset / threshold;
              final maxCorrectedOffset = (-1 - i) * _defaultItemHeight;
              offset = offsetPercentage * maxCorrectedOffset;
              break;
            }
          }
        }

        // calculate the current item index of the visible items, this also
        // includes items that are only partly visible when scrolling
        final visibleItemIndex =
            ((offset - index * _defaultItemHeight) * -1 / _defaultItemHeight)
                .ceil();

        if (visibleItemIndex < 0 || visibleItemIndex > _visibleItemCount) {
          // return sized boxes with default height for out of sight items
          return Container(
            color: SBBColors.violet,
            height: _defaultItemHeight,
            child: Text('$visibleItemIndex'),
          );
        }

        // notify selected item changed
        final visibleAreaOffset = offset % _defaultItemHeight;
        var selectedVisibleItemIndex =
            visibleAreaOffset > _defaultItemHeight * 0.5
                ? _firstIndexPreItemsCount + 1
                : _firstIndexPreItemsCount;
        final selectedItemIndex =
            index + selectedVisibleItemIndex - visibleItemIndex;
        _selectedItemIndexValueNotifier.value = selectedItemIndex;

        // index values needed for following calculation of the item values
        final indexA = visibleItemIndex - 1;
        final indexB = visibleItemIndex;

        // calculate weight values based on scroll position
        final weightA = (offset % _defaultItemHeight) / _defaultItemHeight;
        final weightB = 1 - weightA;

        // calculate item height based on weight values
        final heightA = _itemHeight(indexA);
        final heightB = _itemHeight(indexB);
        final itemHeight = weightA * heightA + weightB * heightB;

        // calculate text color based on weight values
        final textColorA = _itemTextColor(indexA, listItemEnabled);
        final textColorB = _itemTextColor(indexB, listItemEnabled);
        final textColor = Color.lerp(
          textColorA,
          textColorB,
          weightB,
        );

        return GestureDetector(
          onTap: () {
            if (scrollTarget != null) {
              _controller.animateToItem(scrollTarget);
            } else {
              // scroll to bottom
              _controller.animateToScrollOffset(
                _controller.position.maxScrollExtent,
              );
            }
          },
          // TODO to the theme
          child: Container(
            height: itemHeight,
            color: SBBColors.transparent,
            alignment: Alignment.center,
            child: DefaultTextStyle(
              style: SBBTextStyles.mediumLight.copyWith(
                fontWeight: FontWeight.w400,
                fontSize: 24.0,
                height: 26.0 / 24.0,
                color: textColor,
              ),
              child: listItemWidget!,
            ),
          ),
        );
      },
    );
  }

  double _itemHeight(int index) {
    if (index < 0 || index > _visibleItemCount - 1) {
      return _defaultItemHeight;
    }
    return _visibleItemHeights[index];
  }

  Color _itemTextColor(int index, bool enabled) {
    if (index < 0) {
      return _visibleItemTextColors.first.withOpacity(enabled ? 1.0 : 0.35);
    }
    if (index > _visibleItemCount - 1) {
      return _visibleItemTextColors.last.withOpacity(enabled ? 1.0 : 0.35);
    }
    return _visibleItemTextColors[index].withOpacity(enabled ? 1.0 : 0.35);
  }

  final testController = SBBPickerScrollController(initialItem: 1);

  SBBPickerScrollController get _controller {
    // return testController;
    // return widget.controller!;
    return widget.controller ?? _fallbackController!;
  }
}

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
  }) : super(
          initialScrollOffset: _getItemScrollOffset(
            initialItem,
          ),
        );

  ValueNotifier<bool> _scrollingStateNotifier = ValueNotifier(false);
  late VoidCallback isScrollingListener;

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
    isScrollingListener = () {
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
    position.isScrollingNotifier.addListener(isScrollingListener);
  }

  @override
  void detach(ScrollPosition position) {
    position.isScrollingNotifier.removeListener(isScrollingListener);
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
