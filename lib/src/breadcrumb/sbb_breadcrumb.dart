import 'package:flutter/material.dart';

import '../../design_system_flutter.dart';

/// The SBB Breadcrumb. Use according to:
/// https://digital.sbb.ch/de/webapps/components/breadcrumb
///
///
class SBBBreadCrumb extends StatelessWidget {
  const SBBBreadCrumb({
    Key? key,
    this.home = const Icon(SBBIcons.house_small),
    this.spacerWidget = _defaultSpacingWidget,
    required this.breadCrumbItems,
  }) : super(key: key);

  /// The leftmost widget displayed in the breadcrumb.
  ///
  /// Defaults to [SBBIcons.house_medium].
  final Widget home;

  /// Separating widget between BreadCrumb items.
  ///
  /// Defaults to [SBBIcons.chevron_right_small]
  /// with 4px horizontal padding.
  final Widget spacerWidget;

  final List<SBBBreadCrumbItem> breadCrumbItems;

  static const _defaultSpacingWidget = const Padding(
    padding: EdgeInsets.symmetric(
      horizontal: 4.0,
    ),
    child: Icon(
      SBBIcons.chevron_right_small,
      size: 16.0,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Row(
      children: _buildBreadCrumbItemsWithSpacing(),
    );
  }

  List<Widget> _buildBreadCrumbItemsWithSpacing() {
    final boxedBreadCrumbItems = breadCrumbItems
        .map((breadCrumb) => SizedBox(child: breadCrumb))
        .toList();
    boxedBreadCrumbItems.insert(0, SizedBox(child: home));

    // helper
    Iterable<T> intersperse<T>(T element, Iterable<T> iterable) sync* {
      final iterator = iterable.iterator;
      if (iterator.moveNext()) {
        yield iterator.current;
        while (iterator.moveNext()) {
          yield element;
          yield iterator.current;
        }
      }
    }

    return intersperse(spacerWidget, boxedBreadCrumbItems).toList();
  }
}

class SBBBreadCrumbItem<T> extends StatefulWidget {
  const SBBBreadCrumbItem({
    Key? key,
    required this.label,
    required this.onPressed,
  }) : super(key: key);

  final String label;

  final VoidCallback? onPressed;

  @override
  State<SBBBreadCrumbItem<T>> createState() => _SBBBreadCrumbItemState<T>();
}

class _SBBBreadCrumbItemState<T> extends State<SBBBreadCrumbItem<T>>
    with MaterialStateMixin {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.onPressed;
        updateMaterialState(MaterialState.pressed);
      },
      onHover: updateMaterialState(MaterialState.hovered),
      child: Text(
        widget.label,
      ),
    );
  }
}
