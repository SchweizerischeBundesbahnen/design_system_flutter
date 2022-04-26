import 'dart:js';

import 'package:flutter/material.dart';

import '../../design_system_flutter.dart';
import '../sbb_internal.dart';

/// The SBB Breadcrumb. Use according to:
/// https://digital.sbb.ch/de/webapps/components/breadcrumb
///
///
class SBBBreadCrumb extends StatelessWidget {
  const SBBBreadCrumb({
    Key? key,
    this.leading,
    this.spacerWidget = _defaultSpacingWidget,
    required this.breadCrumbItems,
    this.onLeadingPressed,
    this.textStyle,
    this.foregroundColor,
  }) : super(key: key);

  /// The callback for when [leading] is pressed.
  final VoidCallback? onLeadingPressed;

  /// The leftmost widget displayed in the breadcrumb.
  ///
  /// Defaults to [InkWell] with [SBBIcons.house_medium]
  /// with onLeadingPressed as callback.
  /// The default will have the [SBBThemeData.breadcrumbForegroundColor]
  final Widget? leading;

  /// Separating widget between BreadCrumb items.
  ///
  /// Defaults to [SBBIcons.chevron_right_small]
  /// with 4px horizontal padding.
  final Widget spacerWidget;

  /// The color for Text and Icons descendants below [SBBBreadCrumb].
  ///
  /// Defaults to [SBBTheme.breadcrumbForegroundColor].
  final MaterialStateProperty<Color?>? foregroundColor;

  /// The text style for text descendants below [SBBBreadCrumb].
  ///
  /// Defaults to [SBBTheme.breadcrumbTextStyle].
  final TextStyle? textStyle;

  final List<SBBBreadCrumbItem> breadCrumbItems;

  static const _defaultSpacingWidget = Icon(
    SBBIcons.chevron_right_small,
    size: 16.0,
  );

  static const _defaultLeading = const Icon(SBBIcons.house_small);

  @override
  Widget build(BuildContext context) {
    final SBBThemeData theme = SBBTheme.of(context);
    return _InheritedBreadCrumbStyle(
      textStyle: textStyle ?? theme.breadcrumbTextStyle,
      foregroundColor: foregroundColor ?? theme.breadcrumbForegroundColor,
      child: Wrap(
        spacing: 4.0,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: _buildBreadCrumbItemsWithSpacing(),
      ),
    );
  }

  List<Widget> _buildBreadCrumbItemsWithSpacing() {
    final boxedBreadCrumbItems = breadCrumbItems
        .map((breadCrumb) => SizedBox(
                child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                spacerWidget,
                breadCrumb,
              ],
            )))
        .toList();
    boxedBreadCrumbItems.insert(
        0,
        SizedBox(
            child: SBBBreadCrumbItem(
          child: leading ?? _defaultLeading,
          onPressed: onLeadingPressed,
        )));
    return boxedBreadCrumbItems;
  }
}

class _InheritedBreadCrumbStyle extends InheritedWidget {
  const _InheritedBreadCrumbStyle({
    Key? key,
    required this.foregroundColor,
    required this.textStyle,
    required Widget child,
  }) : super(key: key, child: child);

  final MaterialStateProperty<Color?> foregroundColor;
  final TextStyle textStyle;

  static _InheritedBreadCrumbStyle of(BuildContext context) {
    final _InheritedBreadCrumbStyle? result =
        context.dependOnInheritedWidgetOfExactType<_InheritedBreadCrumbStyle>();
    assert(result != null, 'No InheritedBreadCrumbStyle found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(_InheritedBreadCrumbStyle old) {
    return old.foregroundColor != foregroundColor || old.textStyle != textStyle;
  }
}

class SBBBreadCrumbItem extends StatefulWidget {
  const SBBBreadCrumbItem({
    Key? key,
    required this.child,
    required this.onPressed,
  }) : super(key: key);

  /// The widget below this in the widget tree.
  ///
  /// Commonly a Text or Icon.
  final Widget child;

  /// The function called when the BreadCrumb is pressed. Used for redirecting
  /// navigation.
  final VoidCallback? onPressed;

  bool get _enabled => onPressed != null;

  @override
  State<SBBBreadCrumbItem> createState() => _SBBBreadCrumbItemState();
}

class _SBBBreadCrumbItemState extends State<SBBBreadCrumbItem>
    with MaterialStateMixin {
  @override
  Widget build(BuildContext context) {
    Color resolvedForegroundColor = _InheritedBreadCrumbStyle.of(context)
        .foregroundColor
        .resolve(materialStates)!;
    TextStyle resolvedTextStyle =
        _InheritedBreadCrumbStyle.of(context).textStyle;
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
      overlayColor: SBBInternal.all(SBBColors.transparent),
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
