import '../../design_system_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

const Duration _kMenuDuration = Duration(milliseconds: 300);
const double _kMenuCloseIntervalEnd = 2.0 / 3.0;
const double _kMenuHorizontalPadding = 16.0;
const double _kMenuMaxWidth = 7.0 * _kMenuWidthStep;
const double _kMenuMinWidth = 4.0 * _kMenuWidthStep;
const double _kMenuVerticalPadding = 8.0;
const double _kMenuWidthStep = 54.0;
const double _kMenuScreenPadding = 8.0;

/// A base class for entries in an SBB popup menu.
///
/// See also
/// * [PopupMenuEntry], on which this class is based.
abstract class SBBMenuEntry<T> extends StatefulWidget {
  /// Abstract const constructor. This constructor enables subclasses to provide
  /// const constructors so that they can be used in const expressions.
  const SBBMenuEntry({Key? key}) : super(key: key);

  /// The amount of vertical space occupied by this entry.
  ///
  /// This value is used at the time the [showSBBMenu] method is called, if the
  /// `initialValue` argument is provided, to determine the position of this
  /// entry when aligning the selected entry over the given `position`. It is
  /// otherwise ignored.
  double get height;

  /// Whether this entry represents a particular value.
  ///
  /// This method is used by [showSBBMenu], when it is called, to align the entry
  /// representing the `initialValue`, if any, to the given `position`, and then
  /// later is called on each entry to determine if it should be highlighted.
  /// If `initialValue` is null, then this method is not called.
  ///
  /// If the [SBBMenuEntry] represents a single value, this should return true
  /// if the argument matches that value. If it represents multiple values, it
  /// should return true if the argument matches any of them.
  bool represents(T? value);
}

/// A horizontal divider in an SBB menu.
///
/// This widget adapts the [Divider] for use in SBB menus.
/// The divider has a width of
///
/// see also:
/// * [PopupMenuDivider] on which this class is based.
class SBBMenuDivider extends SBBMenuEntry<Never> {
  /// Creates a horizontal divider for a sbb menu.
  ///
  /// By default, the divider has a height of 16 logical pixels.
  const SBBMenuDivider({
    Key? key,
    this.height = 16.0,
    this.color = SBBColors.cloud,
    this.thickness = 1.0,
  }) : super(key: key);

  /// The height of the divider entry.
  ///
  /// Defaults to 16 pixels.
  @override
  final double height;

  /// The color of the divider.
  ///
  /// Defaults to [SBBColors.cloud].
  final Color color;

  /// The thickness of the divider.
  ///
  /// Defaults to 1.0.
  final double thickness;

  @override
  bool represents(void value) => false;

  @override
  State<SBBMenuDivider> createState() => _SBBMenuDividerState();
}

class _SBBMenuDividerState extends State<SBBMenuDivider> {
  @override
  Widget build(BuildContext context) => Divider(
        height: widget.height,
        color: widget.color,
        thickness: widget.thickness,
      );
}

/// A text entry to mark groupings in SBB menus
///
/// Adapts SizedBox to work in SBB menus
class SBBMenuText extends SBBMenuEntry<Never> {
  /// Creates a horizontal text entry for a sbb menu.
  ///
  /// By default, the text
  const SBBMenuText({
    Key? key,
    this.height = 16.0,
    required this.label,
  }) : super(key: key);

  final String label;

  /// The height of the divider entry.
  ///
  /// Defaults to 16 pixels.
  @override
  final double height;

  @override
  bool represents(void value) => false;

  @override
  State<SBBMenuText> createState() => _SBBMenuTextState();
}

class _SBBMenuTextState extends State<SBBMenuText> {
  @override
  //TODO: implement build method
  Widget build(BuildContext context) => throw UnimplementedError;
}

// This widget only exists to enable _PopupMenuRoute to save the sizes of
// each menu item. The sizes are used by _PopupMenuRouteLayout to compute the
// y coordinate of the menu's origin so that the center of selected menu
// item lines up with the center of its PopupMenuButton.
class _MenuItem extends SingleChildRenderObjectWidget {
  const _MenuItem({
    Key? key,
    required this.onLayout,
    required Widget? child,
  }) : super(key: key, child: child);

  final ValueChanged<Size> onLayout;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _RenderMenuItem(onLayout);
  }

  @override
  void updateRenderObject(
      BuildContext context, covariant _RenderMenuItem renderObject) {
    renderObject.onLayout = onLayout;
  }
}

class _RenderMenuItem extends RenderShiftedBox {
  _RenderMenuItem(this.onLayout, [RenderBox? child]) : super(child);

  ValueChanged<Size> onLayout;

  @override
  Size computeDryLayout(BoxConstraints constraints) {
    if (child == null) {
      return Size.zero;
    }
    return child!.getDryLayout(constraints);
  }

  @override
  void performLayout() {
    if (child == null) {
      size = Size.zero;
    } else {
      child!.layout(constraints, parentUsesSize: true);
      size = constraints.constrain(child!.size);
      final BoxParentData childParentData = child!.parentData! as BoxParentData;
      childParentData.offset = Offset.zero;
    }
    onLayout(size);
  }
}

/// An item in a SBB menu.
///
///
/// To show a SBB menu, use the [showSBBMenu] function. To create a button that
/// shows a SBB menu, consider using [SBBMenuButton].
///
/// Use [SBBTheme.menuEntryColorHighlighted] to change background color onHover.
/// Use [SBBTheme.menuEntryTextIconColorHighlighted] to change text and icon color onHover.
///
/// See also:
///
///  * [PopupMenuItem], on which this class is based.
///  * [showSBBMenu], a method to dynamically show a SBB menu at a given location.
///  * [SBBMenuButton], an [IconButton] that automatically shows a menu when
///    it is tapped.
class SBBMenuItem<T> extends SBBMenuEntry<T> {
  /// Creates an item for a SBB menu.
  ///
  /// By default, the item is [enabled].
  ///
  /// The `enabled` and `height` arguments must not be null.
  const SBBMenuItem({
    Key? key,
    this.value,
    this.onTap,
    this.enabled = true,
    this.height = 24.0,
    this.padding = const EdgeInsets.symmetric(
      horizontal: 8.0,
      vertical: 2.0,
    ),
    this.textStyle,
    required this.child,
    this.foregroundColor,
    this.backgroundColor,
  }) : super(key: key);

  /// Create a SBB Menu Tile with a required [title] and optional [icon].
  ///
  /// The icon and title are arranged in a row and padded by 8 logical pixels
  /// at the ends, with an 8 pixel gap in between.
  factory SBBMenuItem.tile({
    Key? key,
    T? value,
    VoidCallback? onTap,
    bool enabled,
    double height,
    EdgeInsets padding,
    TextStyle? textStyle,
    MaterialStateProperty<Color?>? foregroundColor,
    MaterialStateProperty<Color?>? backgroundColor,
    IconData? icon,
    required String title,
  }) = _SBBMenuTileItem;

  /// The value that will be returned by [showSBBMenu] if this entry is selected.
  final T? value;

  /// Called when the menu item is tapped.
  final VoidCallback? onTap;

  /// Whether the user is permitted to select this item.
  ///
  /// Defaults to true. If this is false, then the item will not react to
  /// touches.
  final bool enabled;

  /// The minimum height of the menu item.
  ///
  /// Defaults to 24.0 pixels.
  @override
  final double height;

  /// The padding of the menu item.
  ///
  /// Note that [height] may interact with the applied padding. For example,
  /// If a [height] greater than the height of the sum of the padding and [child]
  /// is provided, then the padding's effect will not be visible.
  ///
  /// When null, the horizontal padding defaults to 8.0 on both sides and 2.0 vertical padding.
  final EdgeInsets padding;

  /// The text style of the sbb menu item.
  ///
  /// If null, [SBBTheme.menuEntryTextStyle] is used, which defaults to
  /// [SBBLeanTextStyles.contextMenu].
  final TextStyle? textStyle;

  /// The widget below this widget in the tree.
  ///
  /// used by the build method
  final Widget? child;

  /// The color for the tile's [Text] and [Icon] widget descendants.
  ///
  /// This color is typically used instead of the color of the [textStyle].
  final MaterialStateProperty<Color?>? foregroundColor;

  /// The color for the tile's background.
  final MaterialStateProperty<Color?>? backgroundColor;

  @override
  bool represents(T? value) => value == this.value;

  @override
  SBBMenuItemState<T, SBBMenuItem<T>> createState() =>
      SBBMenuItemState<T, SBBMenuItem<T>>();
}

/// The [State] for [SBBMenuItem] subclasses.
///
/// The [handleTap] method can be overridden to adjust exactly what happens when
/// the item is tapped. By default, it uses [Navigator.pop] to return the
/// [SBBMenuItem.value] from the menu route.
///
/// This class takes two type arguments. The second, `W`, is the exact type of
/// the [Widget] that is using this [State]. It must be a subclass of
/// [SBBMenuItem]. The first, `T`, must match the type argument of that widget
/// class, and is the type of values returned from this menu.
class SBBMenuItemState<T, W extends SBBMenuItem<T>> extends State<W>
    with MaterialStateMixin {
  /// The handler for when the user selects the item.
  ///
  /// Used by the [InkWell] inserted by the [build] method.
  ///
  /// By default, uses [Navigator.pop] to return the [SBBMenuItem.value] from
  /// the menu route.
  @protected
  void handleTap() {
    updateMaterialState(
      MaterialState.pressed,
    );
    widget.onTap?.call();
    Navigator.pop<T>(context, widget.value);
  }

  @override
  Widget build(BuildContext context) {
    final MouseCursor effectiveMouseCursor = _getEffectiveMouseCursor();
    return MergeSemantics(
      child: Semantics(
        enabled: widget.enabled,
        button: true,
        child: InkWell(
          onTap: widget.enabled ? handleTap : null,
          canRequestFocus: widget.enabled,
          mouseCursor: effectiveMouseCursor,
          onHover: widget.enabled
              ? updateMaterialState(
                  MaterialState.hovered,
                )
              : null,
          child: _buildChild(),
        ),
      ),
    );
  }

  Widget _buildChild() {
    final style = SBBControlStyles.of(context);
    final TextStyle textStyle = widget.textStyle ?? style.menuEntryTextStyle!;
    final Color? resolvedBackgroundColor =
        (widget.backgroundColor ?? style.menuEntryBackgroundColor!)
            .resolve(materialStates);
    final Color? resolvedForegroundColor =
        (widget.foregroundColor ?? style.menuEntryForegroundColor!)
            .resolve(materialStates);
    return Container(
      color: resolvedBackgroundColor,
      alignment: AlignmentDirectional.centerStart,
      padding: widget.padding,
      constraints: BoxConstraints(minHeight: widget.height),
      child: DefaultTextStyle(
        style: textStyle.copyWith(
          color: resolvedForegroundColor,
        ),
        child: IconTheme.merge(
          data: IconThemeData(color: resolvedForegroundColor),
          child: widget.child!,
        ),
      ),
    );
  }

  MouseCursor _getEffectiveMouseCursor() =>
      MaterialStateProperty.resolveAs<MouseCursor>(
        MaterialStateMouseCursor.clickable,
        <MaterialState>{
          if (!widget.enabled) MaterialState.disabled,
        },
      );
}

class _SBBMenu<T> extends StatelessWidget {
  const _SBBMenu({
    Key? key,
    required this.route,
    required this.semanticLabel,
  }) : super(key: key);

  final _PopupMenuRoute<T> route;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final double unit = 1.0 /
        (route.items.length +
            1.5); // 1.0 for the width and 0.5 for the last item's fade.
    final List<Widget> children = <Widget>[];

    for (int i = 0; i < route.items.length; i += 1) {
      final double start = (i + 1) * unit;
      final double end = (start + 1.5 * unit).clamp(0.0, 1.0);
      final CurvedAnimation opacity = CurvedAnimation(
        parent: route.animation!,
        curve: Interval(start, end),
      );
      Widget item = route.items[i];
      if (route.initialValue != null &&
          route.items[i].represents(route.initialValue)) {
        item = Container(
          color: SBBColors.milk,
          child: item,
        );
      }
      children.add(
        _MenuItem(
          onLayout: (Size size) {
            route.itemSizes[i] = size;
          },
          child: FadeTransition(
            opacity: opacity,
            child: item,
          ),
        ),
      );
    }

    final CurveTween opacity =
        CurveTween(curve: const Interval(0.0, 1.0 / 3.0));
    final CurveTween width = CurveTween(curve: Interval(0.0, unit));
    final CurveTween height =
        CurveTween(curve: Interval(0.0, unit * route.items.length));

    final Widget child = ConstrainedBox(
      constraints: const BoxConstraints(
        minWidth: _kMenuMinWidth,
        maxWidth: _kMenuMaxWidth,
      ),
      child: IntrinsicWidth(
        stepWidth: _kMenuWidthStep,
        child: Semantics(
          scopesRoute: true,
          namesRoute: true,
          explicitChildNodes: true,
          label: semanticLabel,
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              vertical: _kMenuVerticalPadding,
            ),
            child: ListBody(children: children),
          ),
        ),
      ),
    );

    final style = SBBControlStyles.of(context);
    return AnimatedBuilder(
      animation: route.animation!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: opacity.animate(route.animation!),
          child: Material(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(
                  2.0,
                ),
              ),
              side: BorderSide(
                color: style.menuBorderColor!,
              ),
            ),
            color: route.backgroundColor ?? style.menuBackgroundColor,
            type: MaterialType.card,
            elevation: 0,
            child: Align(
              alignment: AlignmentDirectional.topEnd,
              widthFactor: width.evaluate(route.animation!),
              heightFactor: height.evaluate(route.animation!),
              child: child,
            ),
          ),
        );
      },
      child: child,
    );
  }
}

// Positioning of the menu on the screen.
class _PopupMenuRouteLayout extends SingleChildLayoutDelegate {
  _PopupMenuRouteLayout(
    this.position,
    this.itemSizes,
    this.selectedItemIndex,
    this.textDirection,
    this.padding,
  );

  // Rectangle of underlying button, relative to the overlay's dimensions.
  final RelativeRect position;

  // The sizes of each item are computed when the menu is laid out, and before
  // the route is laid out.
  List<Size?> itemSizes;

  // The index of the selected item, or null if PopupMenuButton.initialValue
  // was not specified.
  final int? selectedItemIndex;

  // Whether to prefer going to the left or to the right.
  final TextDirection textDirection;

  // The padding of unsafe area.
  EdgeInsets padding;

  // We put the child wherever position specifies, so long as it will fit within
  // the specified parent size padded (inset) by 8. If necessary, we adjust the
  // child's position so that it fits.

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    // The menu can be at most the size of the overlay minus 8.0 pixels in each
    // direction.
    return BoxConstraints.loose(constraints.biggest).deflate(
      const EdgeInsets.all(_kMenuScreenPadding) + padding,
    );
  }

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    // size: The size of the overlay.
    // childSize: The size of the menu, when fully open, as determined by
    // getConstraintsForChild.

    final double buttonHeight = size.height - position.top - position.bottom;
    // Find the ideal vertical position.
    double y = position.top;
    if (selectedItemIndex != null) {
      double selectedItemOffset = _kMenuVerticalPadding;
      for (int index = 0; index < selectedItemIndex!; index += 1)
        selectedItemOffset += itemSizes[index]!.height;
      selectedItemOffset += itemSizes[selectedItemIndex!]!.height / 2;
      y = y + buttonHeight / 2.0 - selectedItemOffset;
    }

    // Find the ideal horizontal position.
    double x;
    if (position.left > position.right) {
      // Menu button is closer to the right edge, so grow to the left, aligned to the right edge.
      x = size.width - position.right - childSize.width;
    } else if (position.left < position.right) {
      // Menu button is closer to the left edge, so grow to the right, aligned to the left edge.
      x = position.left;
    } else {
      // Menu button is equidistant from both edges, so grow in reading direction.
      switch (textDirection) {
        case TextDirection.rtl:
          x = size.width - position.right - childSize.width;
          break;
        case TextDirection.ltr:
          x = position.left;
          break;
      }
    }

    // Avoid going outside an area defined as the rectangle 8.0 pixels from the
    // edge of the screen in every direction.
    if (x < _kMenuScreenPadding + padding.left)
      x = _kMenuScreenPadding + padding.left;
    else if (x + childSize.width >
        size.width - _kMenuScreenPadding - padding.right)
      x = size.width - childSize.width - _kMenuScreenPadding - padding.right;
    if (y < _kMenuScreenPadding + padding.top)
      y = _kMenuScreenPadding + padding.top;
    else if (y + childSize.height >
        size.height - _kMenuScreenPadding - padding.bottom)
      y = size.height - padding.bottom - _kMenuScreenPadding - childSize.height;

    return Offset(x, y);
  }

  @override
  bool shouldRelayout(_PopupMenuRouteLayout oldDelegate) {
    // If called when the old and new itemSizes have been initialized then
    // we expect them to have the same length because there's no practical
    // way to change length of the items list once the menu has been shown.
    assert(itemSizes.length == oldDelegate.itemSizes.length);

    return position != oldDelegate.position ||
        selectedItemIndex != oldDelegate.selectedItemIndex ||
        textDirection != oldDelegate.textDirection ||
        !listEquals(itemSizes, oldDelegate.itemSizes) ||
        padding != oldDelegate.padding;
  }
}

class _PopupMenuRoute<T> extends PopupRoute<T> {
  _PopupMenuRoute({
    required this.position,
    required this.items,
    this.initialValue,
    required this.barrierLabel,
    this.semanticLabel,
    this.backgroundColor,
    required this.capturedThemes,
  }) : itemSizes = List<Size?>.filled(items.length, null);

  final RelativeRect position;
  final List<SBBMenuEntry<T>> items;
  final List<Size?> itemSizes;
  final T? initialValue;
  final String? semanticLabel;
  final Color? backgroundColor;
  final CapturedThemes capturedThemes;

  @override
  Animation<double> createAnimation() {
    return CurvedAnimation(
      parent: super.createAnimation(),
      curve: Curves.linear,
      reverseCurve: const Interval(0.0, _kMenuCloseIntervalEnd),
    );
  }

  @override
  Duration get transitionDuration => _kMenuDuration;

  @override
  bool get barrierDismissible => true;

  @override
  Color? get barrierColor => null;

  @override
  final String barrierLabel;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    int? selectedItemIndex;
    if (initialValue != null) {
      for (int index = 0;
          selectedItemIndex == null && index < items.length;
          index += 1) {
        if (items[index].represents(initialValue)) selectedItemIndex = index;
      }
    }

    final Widget menu = _SBBMenu<T>(route: this, semanticLabel: semanticLabel);
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      removeBottom: true,
      removeLeft: true,
      removeRight: true,
      child: Builder(
        builder: (BuildContext context) {
          return CustomSingleChildLayout(
            delegate: _PopupMenuRouteLayout(
              position,
              itemSizes,
              selectedItemIndex,
              Directionality.of(context),
              mediaQuery.padding,
            ),
            child: capturedThemes.wrap(menu),
          );
        },
      ),
    );
  }
}

/// Show a popup menu that contains the `items` at `position`.
///
/// `items` should be non-null and not empty.
///
/// If `initialValue` is specified then the first item with a matching value
/// will be highlighted and the value of `position` gives the rectangle whose
/// vertical center will be aligned with the vertical center of the highlighted
/// item (when possible).
///
/// If `initialValue` is not specified then the top of the menu will be aligned
/// with the top of the `position` rectangle.
///
/// In both cases, the menu position will be adjusted if necessary to fit on the
/// screen.
///
/// Horizontally, the menu is positioned so that it grows in the direction that
/// has the most room. For example, if the `position` describes a rectangle on
/// the left edge of the screen, then the left edge of the menu is aligned with
/// the left edge of the `position`, and the menu grows to the right. If both
/// edges of the `position` are equidistant from the opposite edge of the
/// screen, then the ambient [Directionality] is used as a tie-breaker,
/// preferring to grow in the reading direction.
///
/// The positioning of the `initialValue` at the `position` is implemented by
/// iterating over the `items` to find the first whose
/// [PopupMenuEntry.represents] method returns true for `initialValue`, and then
/// summing the values of [PopupMenuEntry.height] for all the preceding widgets
/// in the list.
///
/// The `elevation` argument specifies the z-coordinate at which to place the
/// menu. The elevation defaults to 8, the appropriate elevation for popup
/// menus.
///
/// The `context` argument is used to look up the [Navigator] and [Theme] for
/// the menu. It is only used when the method is called. Its corresponding
/// widget can be safely removed from the tree before the popup menu is closed.
///
/// The `useRootNavigator` argument is used to determine whether to push the
/// menu to the [Navigator] furthest from or nearest to the given `context`. It
/// is `false` by default.
///
/// The `semanticLabel` argument is used by accessibility frameworks to
/// announce screen transitions when the menu is opened and closed. If this
/// label is not provided, it will default to
/// [MaterialLocalizations.popupMenuLabel].
///
/// See also:
///
///  * [SBBMenuItem], a popup menu entry for a single value.
///  * [PopupMenuDivider], a popup menu entry that is just a horizontal line.
///  * [CheckedPopupMenuItem], a popup menu item with a checkmark.
///  * [SBBMenuButton], which provides an [IconButton] that shows a menu by
///    calling this method automatically.
///  * [SemanticsConfiguration.namesRoute], for a description of edge triggered
///    semantics.
Future<T?> showSBBMenu<T>({
  required BuildContext context,
  required RelativeRect position,
  required List<SBBMenuEntry<T>> items,
  T? initialValue,
  String? semanticLabel,
  Color? backgroundColor,
  bool useRootNavigator = false,
}) {
  assert(items.isNotEmpty);
  assert(debugCheckHasMaterialLocalizations(context));

  switch (Theme.of(context).platform) {
    case TargetPlatform.iOS:
    case TargetPlatform.macOS:
      break;
    case TargetPlatform.android:
    case TargetPlatform.fuchsia:
    case TargetPlatform.linux:
    case TargetPlatform.windows:
      semanticLabel ??= MaterialLocalizations.of(context).popupMenuLabel;
  }

  final NavigatorState navigator =
      Navigator.of(context, rootNavigator: useRootNavigator);
  return navigator.push(_PopupMenuRoute<T>(
    position: position,
    items: items,
    initialValue: initialValue,
    semanticLabel: semanticLabel,
    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
    backgroundColor: backgroundColor,
    capturedThemes:
        InheritedTheme.capture(from: context, to: navigator.context),
  ));
}

/// Signature for the callback invoked when a menu item is selected. The
/// argument is the value of the [SBBMenuItem] that caused its menu to be
/// dismissed.
///
/// Used by [SBBMenuButton.onSelected].
typedef SBBMenuSelected<T> = void Function(T value);

/// Signature for the callback invoked when a [SBBMenuButton] is dismissed
/// without selecting an item.
///
/// Used by [SBBMenuButton.onCanceled].
typedef SBBMenuCanceled = void Function();

/// Signature used by [SBBMenuButton] to lazily construct the items shown when
/// the button is pressed.
///
/// Used by [SBBMenuButton.itemBuilder].
typedef SBBMenuItemBuilder<T> = List<SBBMenuEntry<T>> Function(
    BuildContext context);

/// Displays a SBB menu when pressed and calls [onSelected] when the menu is dismissed
/// because an item was selected. The value passed to [onSelected] is the value of
/// the selected menu item.
///
/// One of [child] or [icon] may be provided, but not both. If [icon] is provided,
/// then [SBBMenuButton] behaves like an [IconButton].
///
/// If both are null, then the [SBBIconswip.context_menu_medium] is used.
///
/// See also:
///
///  * [SBBMenuItem], a popup menu entry for a single value.
///  * [SBBMenuDivider], a popup menu entry that is just a horizontal line.
///  * [showSBBMenu], a method to dynamically show a popup menu at a given location.
///  * [PopupMenuButton], on which this widget is based
class SBBMenuButton<T> extends StatefulWidget {
  /// Creates a button that shows a popup menu.
  ///
  /// The [itemBuilder] argument must not be null.
  const SBBMenuButton({
    Key? key,
    required this.itemBuilder,
    this.initialValue,
    this.onSelected,
    this.onCanceled,
    this.buttonPadding = const EdgeInsets.all(8.0),
    this.child,
    this.icon,
    this.iconSize = 24.0,
    this.offset = Offset.zero,
    this.enabled = true,
    this.backgroundColor,
  })  : assert(
          !(child != null && icon != null),
          'You can only pass [child] or [icon], not both.',
        ),
        super(key: key);

  /// Called when the button is pressed to create the items to show in the menu.
  final SBBMenuItemBuilder<T> itemBuilder;

  /// The value of the menu item, if any, that should be highlighted when the menu opens.
  final T? initialValue;

  /// Called when the user selects a value from the menu created by this button.
  ///
  /// If the menu is dismissed without selecting a value, [onCanceled] is
  /// called instead.
  final SBBMenuSelected<T>? onSelected;

  /// Called when the user dismisses the menu without selecting an item.
  ///
  /// If the user selects a value, [onSelected] is called instead.
  final SBBMenuCanceled? onCanceled;

  /// Matches IconButton's 8 dps padding by default. In some cases, notably where
  /// this button appears as the trailing element of a list item, it's useful to be able
  /// to set the padding to zero.
  final EdgeInsetsGeometry buttonPadding;

  /// If provided, [child] is the widget used for this button
  /// and the button will utilize an [InkWell] for taps.
  final Widget? child;

  /// If provided, the [icon] is used for this button
  /// and the button will behave like an [IconButton].
  ///
  /// If child and icon is null, the default is an [IconButton]
  /// with [SBBIconswip.context_menu_medium] as icon.
  final Widget? icon;

  /// The offset applied to the Menu Button.
  ///
  /// When not set, the Menu Button will be positioned directly next to
  /// the button that was used to create it.
  final Offset offset;

  /// Whether this SBB menu button is interactive.
  ///
  /// Must be non-null, defaults to `true`
  ///
  /// If `true` the button will respond to presses by displaying the menu.
  ///
  /// If `false`, the button is styled with the disabled color from the
  /// current [Theme] and will not respond to presses or show the popup
  /// menu and [onSelected], [onCanceled] and [itemBuilder] will not be called.
  ///
  /// This can be useful in situations where the app needs to show the button,
  /// but doesn't currently have anything to show in the menu.
  final bool enabled;

  /// If provided, the background color used for the menu.
  ///
  /// If this property is null, then [SBBTheme.menuEntryBackgroundColor] is used,
  /// which defaults to [SBBColors.white].
  final Color? backgroundColor;

  /// The size of the [icon].
  ///
  /// Defaults to 24.0 x 24.0 pixels if this property is null.
  final double iconSize;

  @override
  SBBMenuButtonState<T> createState() => SBBMenuButtonState<T>();
}

/// The [State] for a [SBBMenuButton].
///
/// See [showButtonMenu] for a way to programmatically open the popup menu
/// of your button state.
class SBBMenuButtonState<T> extends State<SBBMenuButton<T>> {
  /// A method to show a popup menu with the items supplied to
  /// [SBBMenuButton.itemBuilder] at the position of your [SBBMenuButton].
  ///
  /// By default, it is called when the user taps the button and [SBBMenuButton.enabled]
  /// is set to `true`. Moreover, you can open the button by calling the method manually.
  ///
  /// You would access your [SBBMenuButtonState] using a [GlobalKey] and
  /// show the menu of the button with `globalKey.currentState.showButtonMenu`.
  void showButtonMenu() {
    final RenderBox button = context.findRenderObject()! as RenderBox;
    final RenderBox overlay =
        Navigator.of(context).overlay!.context.findRenderObject()! as RenderBox;
    final RelativeRect position = RelativeRect.fromRect(
      Rect.fromPoints(
        button.localToGlobal(widget.offset, ancestor: overlay),
        button.localToGlobal(
            button.size.bottomRight(Offset.zero) + widget.offset,
            ancestor: overlay),
      ),
      Offset.zero & overlay.size,
    );
    final List<SBBMenuEntry<T>> items = widget.itemBuilder(context);
    // Only show the menu if there is something to show
    if (items.isNotEmpty) {
      showSBBMenu<T?>(
        context: context,
        items: items,
        initialValue: widget.initialValue,
        position: position,
        backgroundColor: widget.backgroundColor,
      ).then<void>((T? newValue) {
        if (!mounted) return null;
        if (newValue == null) {
          widget.onCanceled?.call();
          return null;
        }
        widget.onSelected?.call(newValue);
      });
    }
  }

  bool get _canRequestFocus {
    final NavigationMode mode = MediaQuery.maybeOf(context)?.navigationMode ??
        NavigationMode.traditional;
    switch (mode) {
      case NavigationMode.traditional:
        return widget.enabled;
      case NavigationMode.directional:
        return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterialLocalizations(context));

    if (widget.child != null) {
      return InkWell(
        onTap: widget.enabled ? showButtonMenu : null,
        canRequestFocus: _canRequestFocus,
        child: widget.child,
        hoverColor: SBBColors.transparent,
        splashColor: SBBColors.transparent,
        overlayColor: SBBTheme.allStates(SBBColors.transparent),
        highlightColor: SBBColors.transparent,
      );
    }

    return IconButton(
      icon: widget.icon ?? Icon(SBBIcons.context_menu_medium),
      padding: widget.buttonPadding,
      iconSize: widget.iconSize,
      onPressed: widget.enabled ? showButtonMenu : null,
      splashColor: SBBColors.transparent,
      highlightColor: SBBColors.transparent,
      hoverColor: SBBColors.transparent,
    );
  }
}

class _SBBMenuTileItem<T> extends SBBMenuItem<T> {
  _SBBMenuTileItem({
    Key? key,
    T? value,
    VoidCallback? onTap,
    bool enabled = true,
    double height = 24.0,
    EdgeInsets padding = const EdgeInsets.symmetric(
      horizontal: 8.0,
      vertical: 2.0,
    ),
    TextStyle? textStyle,
    MaterialStateProperty<Color?>? foregroundColor,
    MaterialStateProperty<Color?>? backgroundColor,
    IconData? icon,
    required String title,
  }) : super(
          key: key,
          value: value,
          onTap: onTap,
          enabled: enabled,
          height: height,
          textStyle: textStyle,
          padding: padding,
          foregroundColor: foregroundColor,
          backgroundColor: backgroundColor,
          child: _SBBMenuItemWithTileChild(
            icon: icon,
            title: title,
          ),
        );
}

class _SBBMenuItemWithTileChild extends StatelessWidget {
  const _SBBMenuItemWithTileChild({
    Key? key,
    required this.title,
    this.icon,
  }) : super(key: key);

  final String title;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        if (icon != null) Icon(icon),
        SizedBox(width: 8.0),
        Flexible(
          child: Text(
            title,
          ),
        ),
      ],
    );
  }
}
