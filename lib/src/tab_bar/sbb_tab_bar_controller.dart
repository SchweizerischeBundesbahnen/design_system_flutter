import 'package:flutter/material.dart';
import 'package:sbb_design_system_mobile/src/tab_bar/common/tab_bar_animation.dart';

import '../../sbb_design_system_mobile.dart';

const Duration tabScrollDuration = Duration(milliseconds: 300);

class SBBTabBarController extends ChangeNotifier {
  /// Creates an object that manages the state required by [SBBTabBar].
  ///
  /// The [length] must not be negative. Typically it's a value greater than
  /// one, i.e. typically there are two or more tabs. The [length] must match
  /// [SBBTabBar.items]'s length.
  ///
  /// The `initialIndex` must be valid given [length]. If [length] is zero, then
  /// `initialIndex` must be 0 (the default).
  SBBTabBarController({
    int initialIndex = 0,
    Duration? animationDuration,
    required this.length,
    required TickerProvider vsync,
  })  : assert(length >= 0),
        assert(initialIndex >= 0 && (length == 0 || initialIndex < length)),
        _index = initialIndex,
        _previousIndex = initialIndex,
        _animationDuration = animationDuration ?? kTabScrollDuration,
        _animationController = AnimationController(
          vsync: vsync,
          duration: Duration(milliseconds: 200),
        );

  // Private constructor used by `_copyWith`. This allows a new SBBTabBarController to
  // be created without having to create a new animationController.
  SBBTabBarController._({
    required int index,
    required int previousIndex,
    required AnimationController? animationController,
    required Duration animationDuration,
    required this.length,
  })  : _index = index,
        _previousIndex = previousIndex,
        _animationController = animationController,
        _animationDuration = animationDuration;

  /// Creates a new [SBBTabBarController] with `index`, `previousIndex`, `length`, and
  /// `animationDuration` if they are non-null, and disposes current instance.
  ///
  /// This method is used by [DefaultSBBTabBarController].
  ///
  /// When [DefaultSBBTabBarController.length] is updated, this method is called to
  /// create a new [SBBTabBarController] without creating a new [AnimationController].
  /// Instead the [_animationController] is nulled in current instance and
  /// passed to the new instance.
  SBBTabBarController _copyWithAndDispose({
    required int? index,
    required int? length,
    required int? previousIndex,
    required Duration? animationDuration,
  }) {
    // if (index != null) {
    //   _animationController!.value = _animationController.value;
    // }
    final SBBTabBarController result = SBBTabBarController._(
      index: index ?? _index,
      length: length ?? this.length,
      animationController: _animationController,
      previousIndex: previousIndex ?? _previousIndex,
      animationDuration: animationDuration ?? _animationDuration,
    );
    _animationController = null;
    dispose();
    return result;
  }

  /// An animation whose value represents the current position of the [TabBar]'s
  /// selected tab indicator as well as the scrollOffsets of the [TabBar]
  /// and [TabBarView].
  ///
  /// The animation's value ranges from 0.0 to [length] - 1.0. After the
  /// selected tab is changed, the animation's value equals [index]. The
  /// animation's value can be [offset] by +/- 1.0 to reflect [TabBarView]
  /// drag scrolling.
  ///
  /// If this [TabController] was disposed, then return null.
  Animation<double>? get animation => _animationController?.view;
  AnimationController? _animationController;

  /// Controls the duration of TabController and TabBarView animations.
  ///
  /// Defaults to kTabScrollDuration.
  Duration get animationDuration => _animationDuration;
  final Duration _animationDuration;

  /// The total number of tabs.
  ///
  /// Typically greater than one. Must match [TabBar.tabs]'s and
  /// [TabBarView.children]'s length.
  final int length;

  bool _isHover = false;

  TabBarAnimation get tabBarAnimation => TabBarAnimation(
        index: index,
        previousIndex: previousIndex,
        previousPercentage: _isHover
            ? 1.0
            : indexIsChanging
                ? 1.0 - (animation?.value ?? 0)
                : 0.0,
        percentage: indexIsChanging ? animation?.value ?? 1.0 : 1.0,
        isChanging: indexIsChanging,
      );

  void _changeIndex(int value, {double animationValue = 1.0}) {
    assert(value >= 0 && (value < length || length == 0));
    assert(_indexIsChangingCount >= 0);
    // if ((value == _index && _isHover) || length < 2) {
    //   return;
    // }
    _previousIndex = index;
    _index = value;
    _indexIsChangingCount += 1;
    notifyListeners();
    _animationController!.animateTo(animationValue, curve: Curves.easeInCubic).whenCompleteOrCancel(() {
      if (_animationController != null) {
        // don't notify if we've been disposed
        _indexIsChangingCount -= 1;
        print('indexChanged');
        notifyListeners();
        _animationController!.reset();
      }
    });
  }

  void _hoverIndex(int value, {double animationValue = 1.0}) {
    assert(value >= 0 && (value < length || length == 0));
    assert(_indexIsChangingCount >= 0);
    if (value == _index || length < 2) {
      return;
    }
    _isHover = true;
    _previousIndex = index;
    _index = value;
    _indexIsChangingCount += 1;
    notifyListeners();
    _animationController!.animateTo(0.25, curve: Curves.easeInOutCubic).whenCompleteOrCancel(() {
      if (_animationController != null) {
        // don't notify if we've been disposed
        _indexIsChangingCount -= 1;
        notifyListeners();
      }
    });
  }

  void _cancelHover() {
    assert(_indexIsChangingCount >= 0);
    _index = _previousIndex;
    _indexIsChangingCount += 1;
    notifyListeners();
    _animationController!.animateTo(0, curve: Curves.easeInOutCubic).whenCompleteOrCancel(() {
      if (_animationController != null) {
        // don't notify if we've been disposed
        _indexIsChangingCount -= 1;
        _isHover = false;
        notifyListeners();
        _animationController!.reset();
      }
    });
  }

  /// The index of the currently selected tab.
  ///
  /// Changing the index also updates [previousIndex], sets the [animation]'s
  /// value to index, resets [indexIsChanging] to false, and notifies listeners.
  ///
  /// To change the currently selected tab and play the [animation] use [animateTo].
  ///
  /// The value of [index] must be valid given [length]. If [length] is zero,
  /// then [index] will also be zero.
  int get index => _index;
  int _index;

  set index(int value) {
    _changeIndex(value);
  }

  /// The index of the previously selected tab.
  ///
  /// Initially the same as [index].
  int get previousIndex => _previousIndex;
  int _previousIndex;

  /// True while we're animating from [previousIndex] to [index] as a
  /// consequence of calling [animateTo].
  ///
  /// This value is true during the [animateTo] animation that's triggered when
  /// the user taps a [TabBar] tab. It is false when [offset] is changing as a
  /// consequence of the user dragging (and "flinging") the [TabBarView].
  bool get indexIsChanging => _indexIsChangingCount != 0;
  int _indexIsChangingCount = 0;

  /// Immediately sets [index] and [previousIndex] and then plays the
  /// [animation] from its current value to [index].
  ///
  /// While the animation is running [indexIsChanging] is true. When the
  /// animation completes [offset] will be 0.0.
  void animateTo(int value) {
    _changeIndex(value);
  }

  void hoverTo(int value) {
    _hoverIndex(value);
  }

  void cancelHover() {
    _cancelHover();
  }

  @override
  void dispose() {
    _animationController?.dispose();
    _animationController = null;
    super.dispose();
  }
}

// class _TabControllerScope extends InheritedWidget {
//   const _TabControllerScope({
//     required this.controller,
//     required this.enabled,
//     required super.child,
//   });
//
//   final TabController controller;
//   final bool enabled;
//
//   @override
//   bool updateShouldNotify(_TabControllerScope old) {
//     return enabled != old.enabled || controller != old.controller;
//   }
// }
//
// /// The [TabController] for descendant widgets that don't specify one
// /// explicitly.
// ///
// /// {@youtube 560 315 https://www.youtube.com/watch?v=POtoEH-5l40}
// ///
// /// [DefaultTabController] is an inherited widget that is used to share a
// /// [TabController] with a [TabBar] or a [TabBarView]. It's used when sharing an
// /// explicitly created [TabController] isn't convenient because the tab bar
// /// widgets are created by a stateless parent widget or by different parent
// /// widgets.
// ///
// /// {@animation 700 540 https://flutter.github.io/assets-for-api-docs/assets/material/tabs.mp4}
// ///
// /// ```dart
// /// class MyDemo extends StatelessWidget {
// ///   const MyDemo({super.key});
// ///
// ///   static const List<Tab> myTabs = <Tab>[
// ///     Tab(text: 'LEFT'),
// ///     Tab(text: 'RIGHT'),
// ///   ];
// ///
// ///   @override
// ///   Widget build(BuildContext context) {
// ///     return DefaultTabController(
// ///       length: myTabs.length,
// ///       child: Scaffold(
// ///         appBar: AppBar(
// ///           bottom: const TabBar(
// ///             tabs: myTabs,
// ///           ),
// ///         ),
// ///         body: TabBarView(
// ///           children: myTabs.map((Tab tab) {
// ///             final String label = tab.text!.toLowerCase();
// ///             return Center(
// ///               child: Text(
// ///                 'This is the $label tab',
// ///                 style: const TextStyle(fontSize: 36),
// ///               ),
// ///             );
// ///           }).toList(),
// ///         ),
// ///       ),
// ///     );
// ///   }
// /// }
// /// ```
// class DefaultTabController extends StatefulWidget {
//   /// Creates a default tab controller for the given [child] widget.
//   ///
//   /// The [length] argument is typically greater than one. The [length] must
//   /// match [TabBar.tabs]'s and [TabBarView.children]'s length.
//   const DefaultTabController({
//     super.key,
//     required this.length,
//     this.initialIndex = 0,
//     required this.child,
//     this.animationDuration,
//   })  : assert(length >= 0),
//         assert(length == 0 || (initialIndex >= 0 && initialIndex < length));
//
//   /// The total number of tabs.
//   ///
//   /// Typically greater than one. Must match [TabBar.tabs]'s and
//   /// [TabBarView.children]'s length.
//   final int length;
//
//   /// The initial index of the selected tab.
//   ///
//   /// Defaults to zero.
//   final int initialIndex;
//
//   /// Controls the duration of DefaultTabController and TabBarView animations.
//   ///
//   /// Defaults to kTabScrollDuration.
//   final Duration? animationDuration;
//
//   /// The widget below this widget in the tree.
//   ///
//   /// Typically a [Scaffold] whose [AppBar] includes a [TabBar].
//   ///
//   /// {@macro flutter.widgets.ProxyWidget.child}
//   final Widget child;
//
//   /// The closest instance of [DefaultTabController] that encloses the given
//   /// context, or null if none is found.
//   ///
//   /// {@tool snippet} Typical usage is as follows:
//   ///
//   /// ```dart
//   /// TabController? controller = DefaultTabController.maybeOf(context);
//   /// ```
//   /// {@end-tool}
//   ///
//   /// Calling this method will create a dependency on the closest
//   /// [DefaultTabController] in the [context], if there is one.
//   ///
//   /// See also:
//   ///
//   /// * [DefaultTabController.of], which is similar to this method, but asserts
//   ///   if no [DefaultTabController] ancestor is found.
//   static TabController? maybeOf(BuildContext context) {
//     return context.dependOnInheritedWidgetOfExactType<_TabControllerScope>()?.controller;
//   }
//
//   /// The closest instance of [DefaultTabController] that encloses the given
//   /// context.
//   ///
//   /// If no instance is found, this method will assert in debug mode and throw
//   /// an exception in release mode.
//   ///
//   /// Calling this method will create a dependency on the closest
//   /// [DefaultTabController] in the [context].
//   ///
//   /// {@tool snippet} Typical usage is as follows:
//   ///
//   /// ```dart
//   /// TabController controller = DefaultTabController.of(context);
//   /// ```
//   /// {@end-tool}
//   ///
//   /// See also:
//   ///
//   /// * [DefaultTabController.maybeOf], which is similar to this method, but
//   ///   returns null if no [DefaultTabController] ancestor is found.
//   static TabController of(BuildContext context) {
//     final TabController? controller = maybeOf(context);
//     assert(() {
//       if (controller == null) {
//         throw FlutterError(
//           'DefaultTabController.of() was called with a context that does not '
//           'contain a DefaultTabController widget.\n'
//           'No DefaultTabController widget ancestor could be found starting from '
//           'the context that was passed to DefaultTabController.of(). This can '
//           'happen because you are using a widget that looks for a DefaultTabController '
//           'ancestor, but no such ancestor exists.\n'
//           'The context used was:\n'
//           '  $context',
//         );
//       }
//       return true;
//     }());
//     return controller!;
//   }
//
//   @override
//   State<DefaultTabController> createState() => _DefaultTabControllerState();
// }
//
// class _DefaultTabControllerState extends State<DefaultTabController> with SingleTickerProviderStateMixin {
//   late TabController _controller;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = TabController(
//       vsync: this,
//       length: widget.length,
//       initialIndex: widget.initialIndex,
//       animationDuration: widget.animationDuration,
//     );
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return _TabControllerScope(
//       controller: _controller,
//       enabled: TickerMode.of(context),
//       child: widget.child,
//     );
//   }
//
//   @override
//   void didUpdateWidget(DefaultTabController oldWidget) {
//     super.didUpdateWidget(oldWidget);
//     if (oldWidget.length != widget.length) {
//       // If the length is shortened while the last tab is selected, we should
//       // automatically update the index of the controller to be the new last tab.
//       int? newIndex;
//       int previousIndex = _controller.previousIndex;
//       if (_controller.index >= widget.length) {
//         newIndex = math.max(0, widget.length - 1);
//         previousIndex = _controller.index;
//       }
//       _controller = _controller._copyWithAndDispose(
//         length: widget.length,
//         animationDuration: widget.animationDuration,
//         index: newIndex,
//         previousIndex: previousIndex,
//       );
//     }
//
//     if (oldWidget.animationDuration != widget.animationDuration) {
//       _controller = _controller._copyWithAndDispose(
//         length: widget.length,
//         animationDuration: widget.animationDuration,
//         index: _controller.index,
//         previousIndex: _controller.previousIndex,
//       );
//     }
//   }
// }

// class SBBTabBarController extends ChangeNotifier {
//   SBBTabBarController({
//     int initialIndex = 0,
//     required this.length,
//     required TickerProvider vsync,
//   }): assert(length >= 0),
//         assert(initialIndex >= 0 && (length == 0 || initialIndex < length)),
//         _index = initialIndex,
//         _previousIndex = initialIndex,
//         _animationDuration = animationDuration ?? tabScrollDuration,
//
//   final _navigationController = StreamController<TabBarNavigationData>.broadcast();
//
//   Stream<TabBarNavigationData> get navigationStream => _navigationController.stream;
//
//   late TabBarItem selectedTab;
//   late TickerProvider vsync;
//   late TabBarItem _nextTab;
//   late AnimationController _animationController;
//   late Animation<double> _animation;
//   late bool _hover;
//   late TabBarNavigationData currentData;
//
//   static const _duration = Duration(milliseconds: 100);
//
//   // _leftPercentage = from > to ? animation : (hover ? 1 : 1 - animation);
//   // _rightPercentage = from > to ? (hover ? 1 : 1 - animation) : animation;
//
//   void initialize(TickerProvider vsync) {
//     _animationController = AnimationController(
//       vsync: vsync,
//       duration: kThemeAnimationDuration,
//     )..addListener(
//         () {
//           currentData = TabBarNavigationData(
//             selectedTab,
//             _nextTab,
//             _animation.value,
//             _hover,
//           );
//           _navigationController.add(currentData);
//         },
//       );
//     _animation = Tween(begin: 0.0, end: 1.0).animate(_animationController);
//   }
//
//   Future<TabBarItem> selectTab(TabBarItem tab) async {
//     if (selectedTab == tab) return tab;
//     _nextTab = tab;
//     _hover = false;
//     await _animationController.animateTo(1.0, duration: _duration);
//     selectedTab = tab;
//     _animationController.reset();
//     return tab;
//   }
//
//   Future<void> hoverTab(TabBarItem tab) async {
//     _nextTab = tab;
//     _hover = true;
//     await _animationController.animateTo(0.25, duration: _duration);
//   }
//
//   Future<void> cancelHover() async {
//     await _animationController.animateTo(0, duration: _duration);
//     _hover = false;
//     _nextTab = selectedTab;
//     _animationController.reset();
//   }
// }
