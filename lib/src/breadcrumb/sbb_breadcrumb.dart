import 'package:flutter/material.dart';

import '../../design_system_flutter.dart';

/// The SBB Breadcrumb. Use according to:
/// https://digital.sbb.ch/de/webapps/components/breadcrumb
///
///
class SBBBreadcrumb extends StatelessWidget {
  const SBBBreadcrumb({
    Key? key,
    this.leading,
    this.spacerWidget = _defaultSpacingWidget,
    required this.breadcrumbItems,
    this.onLeadingPressed,
    this.textStyle,
    this.foregroundColor,
  }) : super(key: key);

  /// The callback for when [leading] is pressed.
  final VoidCallback? onLeadingPressed;

  /// The leftmost widget displayed in the breadcrumb.
  ///
  /// Defaults to [InkWell] with [SBBIconswip.house_medium]
  /// with onLeadingPressed as callback.
  /// The default will have the [SBBTheme.breadcrumbForegroundColor]
  final Widget? leading;

  /// Separating widget between Breadcrumb items.
  ///
  /// Defaults to [SBBIconswip.chevron_right_small]
  /// with 4px horizontal padding.
  final Widget spacerWidget;

  /// The color for Text and Icons descendants below [SBBBreadcrumb].
  ///
  /// Defaults to [SBBTheme.breadcrumbForegroundColor].
  final MaterialStateProperty<Color?>? foregroundColor;

  /// The text style for text descendants below [SBBBreadcrumb].
  ///
  /// Defaults to [SBBTheme.breadcrumbTextStyle].
  final TextStyle? textStyle;

  final List<SBBBreadcrumbItem> breadcrumbItems;

  static const _defaultSpacingWidget = Icon(
    SBBIcons.chevron_right_small,
    size: 16.0,
  );

  static const _defaultLeading = const Icon(SBBIcons.house_small);

  @override
  Widget build(BuildContext context) {
    final style = SBBControlStyles.of(context);
    return _InheritedBreadcrumbStyle(
      textStyle: textStyle ?? style.breadcrumbTextStyle!,
      foregroundColor: foregroundColor ?? style.breadcrumbForegroundColor!,
      child: Wrap(
        spacing: 4.0,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: _buildBreadcrumbItemsWithSpacing(),
      ),
    );
  }

  List<Widget> _buildBreadcrumbItemsWithSpacing() {
    final boxedBreadcrumbItems = breadcrumbItems
        .map((breadcrumb) => SizedBox(
                child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                spacerWidget,
                breadcrumb,
              ],
            )))
        .toList();
    boxedBreadcrumbItems.insert(
        0,
        SizedBox(
            child: SBBBreadcrumbItem(
          child: leading ?? _defaultLeading,
          onPressed: onLeadingPressed,
        )));
    return boxedBreadcrumbItems;
  }
}

class _InheritedBreadcrumbStyle extends InheritedWidget {
  const _InheritedBreadcrumbStyle({
    Key? key,
    required this.foregroundColor,
    required this.textStyle,
    required Widget child,
  }) : super(key: key, child: child);

  final MaterialStateProperty<Color?> foregroundColor;
  final TextStyle textStyle;

  static _InheritedBreadcrumbStyle of(BuildContext context) {
    final _InheritedBreadcrumbStyle? result =
        context.dependOnInheritedWidgetOfExactType<_InheritedBreadcrumbStyle>();
    assert(result != null, 'No InheritedBreadcrumbStyle found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(_InheritedBreadcrumbStyle old) {
    return old.foregroundColor != foregroundColor || old.textStyle != textStyle;
  }
}

class SBBBreadcrumbItem extends StatefulWidget {
  const SBBBreadcrumbItem({
    Key? key,
    required this.child,
    required this.onPressed,
  }) : super(key: key);

  /// The widget below this in the widget tree.
  ///
  /// Commonly a Text or Icon.
  final Widget child;

  /// The function called when the Breadcrumb is pressed. Used for redirecting
  /// navigation.
  final VoidCallback? onPressed;

  bool get _enabled => onPressed != null;

  @override
  State<SBBBreadcrumbItem> createState() => _SBBBreadcrumbItemState();
}

class _SBBBreadcrumbItemState extends State<SBBBreadcrumbItem>
    with MaterialStateMixin {
  @override
  Widget build(BuildContext context) {
    Color resolvedForegroundColor = _InheritedBreadcrumbStyle.of(context)
        .foregroundColor
        .resolve(materialStates)!;
    TextStyle resolvedTextStyle =
        _InheritedBreadcrumbStyle.of(context).textStyle;
    if (!widget._enabled) {
      resolvedForegroundColor = SBBColors.black;
    }

    return InkWell(
      onTap: () {
        if (widget._enabled) {
          updateMaterialState(MaterialState.pressed);
          widget.onPressed!();
        }
      },
      splashColor: SBBColors.transparent,
      overlayColor: SBBTheme.allStates(SBBColors.transparent),
      highlightColor: SBBColors.transparent,
      mouseCursor: _getEffectiveMouseCursor(),
      onHover:
          widget._enabled ? updateMaterialState(MaterialState.hovered) : null,
      child: DefaultTextStyle(
        style: resolvedTextStyle.copyWith(color: resolvedForegroundColor),
        child: IconTheme.merge(
          data: IconThemeData(color: resolvedForegroundColor),
          child: widget.child,
        ),
      ),
    );
  }

  MouseCursor _getEffectiveMouseCursor() =>
      MaterialStateProperty.resolveAs<MouseCursor>(
        MaterialStateMouseCursor.clickable,
        <MaterialState>{
          if (!widget._enabled) MaterialState.disabled,
        },
      );
}
